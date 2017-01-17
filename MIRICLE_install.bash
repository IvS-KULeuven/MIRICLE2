#!/bin/bash
#
# Installation script to setup and/or upgrade MIRICLE, the Python MIRI Analysis System.
# Running the installation script without parameters will install the latest 'stable' version
#
# Options:
#    --help
#      displays the help for this installation script
#    --devel
#      install the latest miri development packages
#    --test
#      install the tested development version
#    --clean
#      remove logfiles and tarfile
#    --update
#      remove existing installation and install the most recent version
#    --verbose
#      show all installed python packages at the end of the installation

MIRICLE_version="6.00"

# verboseEcho only prints the text if the verbose flag is used.
function verboseEcho {
  if [ -n "$verbose" ] ; then
    echo $1
  fi
}

# checkInternet checks if a working internet connection is available and if curl/wget is installed.
function checkInternet {
  #
  # determine download method
  #
  internet=1
  which wget 1> /dev/null
  if [ $? = 0 ] ; then
    verboseEcho "Using wget to download packages."
    download="wget -nd -q "

    wget --spider -q http://www.google.com
    if [ "$?" != 0 ]; then
      internet=0
    fi
  else
    which curl 1> /dev/null
    if [ $? = 0 ] ; then
      verboseEcho "Using curl to download packages."
      download="curl -O --silent "
    fi

    # Check for internet connection
    if curl --silent --head http://www.google.com/ | egrep "20[0-9] Found|30[0-9] Found|200 OK" >/dev/null
    then
      internet=1
    else
      internet=0
    fi
  fi

  if [ $internet -eq 0 ]; then
      echo "No internet connection found!"
      echo "Please rerun MIRICLE_install.bash with a working internet connection to install MIRICLE."
      exit
  fi

  verboseEcho "Internet connection found. Continuing the installation."

  # Determine whether www.miricle.org is up
  if ! curl --silent --head miricle.org>/dev/null; then
    echo "www.miricle.org is down."
    echo "Please try to rerun MIRICLE_install.bash a little later."
    exit
  fi

  if [ -z "$download" ] ; then
    echo "Neither wget nor curl is present. Please have your system manager install either of them."
    exit
  fi
}

# Return status code of a comparison
float_test() {
     echo | awk 'END { exit ( !( '"$1"')); }'
}

# checkUpdateOfScript checks if there is a newer version of the script available in GitHub.
function checkUpdateOfScript {
  verboseEcho ""
  verboseEcho "Checking if there is a newer version of the installation script available..."
  rm -f MIRICLE_install_version
  $download https://raw.githubusercontent.com/IvS-KULeuven/MIRICLE2/master/MIRICLE_install_version
  version_on_server=`cat MIRICLE_install_version`
  verboseEcho "Version of the used installation script is $MIRICLE_version. On the server, I found $version_on_server."
  uptodate=0
  float_test "$MIRICLE_version >= $version_on_server" && uptodate=1

  if [ "$uptodate" -eq 1 ]; then
    verboseEcho "No need to update the MIRICLE install script."
    rm -f MIRICLE_install_version
  else
    verboseEcho "Updating the MIRICLE install script."
    rm -f MIRICLE_install.bash
    rm -f MIRICLE_install_version
    $download https://raw.githubusercontent.com/IvS-KULeuven/MIRICLE2/master/MIRICLE_install.bash
    chmod +x MIRICLE_install.bash
    echo "MIRICLE installation script is updated."
    echo "Please rerun MIRICLE_install.bash to install MIRICLE."
    exit
  fi
}


flavor="stable"
version="-99"
while [ "$1" != "" ]
do
   case $1 in
    "--help")
     echo "MIRICLE_install.bash is the installation script for MIRICLE, the Python MIRI Analysis System."
     echo ""
     echo "To be able to install MIRICLE, you need at the Anaconda python environment, at least version 4.2. You need the python 2.7 version."
     echo "You can download Anaconda from https://www.continuum.io/downloads"
     echo ""
     echo "  --help"
     echo "      displays the help for this installation script."
     echo "  --devel"
     echo "      install the latest miri development packages. This is not at all guaranteed to be stable or fully working!"
     echo "  --test"
     echo "      installs a tested version of the miri development build. This is not guaranteed to be stable or fully working, but should be more stable than the --devel option!"
     echo "  --clean"
     echo "      removes all old MIRICLE and mirisim installations."
     echo "  --verbose"
     echo "      show all installed python packages at the end of the installation."
     echo "  --version <version number>"
     echo "      installs the given version (or the latest successfull version before this)."
     echo ""
     echo "This is version $MIRICLE_version of the MIRICLE_install.bash install script."
     exit
     ;;
    "--devel")
     flavor="devel"
     ;;
    "--test")
     flavor="test"
     ;;
    "--clean")
     clean=1
     ;;
    "--verbose")
     verbose=1
     verboseEcho "Verbose mode"
     ;;
    "--version")
     version=$2
     shift
     ;;
    *)
     echo "Invalid install option. Try with --help option to see the valid options."
     exit
     ;;
  esac
  shift
done

# Check if there is a working internet connection
checkInternet

# Check if there is a newer version of the installation script
checkUpdateOfScript


#echo $flavor
#echo "Version $version"


# TODO: Do we need git? If so, we should check if git is installed -> See line 148 - 156
# TODO: Do we need the X11 development files? -> See line 162 - 175
