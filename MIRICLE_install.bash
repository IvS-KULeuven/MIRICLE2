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
#    --path
#      Installs the auxiliary data in the given path
#    --verbose
#      show all installed python packages at the end of the installation

MIRICLE_version="6.00"

# Make it possible to print bold characters
bold=`tput bold`
normal=`tput sgr0`

# verboseEcho only prints the text if the verbose flag is used.
function verboseEcho {
  if [ -n "$verbose" ] ; then
    echo $1
  fi

  echo $1 >> $LOG/log.txt
}

# verboseEcho only prints the text if the verbose flag is used.
function echoLog {
  echo $1
  echo $1 | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'  | sed $'s,\x1b(B,,g' >> $LOG/log.txt
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
      echoLog "No internet connection found!"
      echoLog "Please rerun MIRICLE_install.bash with a working internet connection to install MIRICLE."
      exit
  fi

  verboseEcho "Internet connection found. Continuing the installation."

  # Determine whether www.miricle.org is up.
  if ! curl --silent --head miricle.org>/dev/null; then
    echoLog "www.miricle.org is down."
    echoLog "Please try to rerun MIRICLE_install.bash a little later."
    exit
  fi
  verboseEcho "www.miricle.org is up and running."

  if [ -z "$download" ] ; then
    echoLog "Neither wget nor curl is present. Please have your system manager install either of them."
    exit
  fi
}

# Return status code of a comparison.
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
    echoLog "MIRICLE installation script is updated."
    echoLog "Please rerun MIRICLE_install.bash to install MIRICLE."
    exit
  fi
}


# Check if anaconda is installed
function checkAnacondaInstalled {
  if hash conda 2>/dev/null; then
    verboseEcho ""
    verboseEcho "Anaconda is installed, continuiung the installation."
  else
    echoLog ""
    echoLog "${bold}First install Anaconda python distribution: https://www.continuum.io/downloads${normal}"
    echoLog "If anaconda is already installed on your computer, execute"
    echoLog "  ${bold}source activate root${normal}"
    exit
  fi
}

# Get the version number to install
function getVersionNumberToInstall {
  getVersion=0
  float_test "$version >= 9999999990" && getVersion=1

  if [ "$getVersion" -eq 1 ]; then
    verboseEcho "Requested installation of latest version from the $flavor track."
  else
    verboseEcho "Version number $version is given as parameter. Will try to install this version.";
  fi

  $download http://www.miricle.org/MIRICLE2/$flavor/buildNumbers

  while read line; do
    if [ -n "$line" ] ; then
      if [ $version -ge $line ]; then
        newversion=$line
      fi
      latestVersion=$line
    fi
  done < buildNumbers
  rm buildNumbers

  version=$newversion

  echoLog "${bold}Requested installation version $version of the $flavor track.${normal}"

  echoLog "Latest available $flavor version is $latestVersion."
}

# Sets the flavor name
function setFlavorName {
  if [ $flavor = "stable" ] ; then
    flavorName=""
  else
    flavorName=".$flavor"
  fi
}

flavor="stable"
version="9999999999"
while [ "$1" != "" ]
do
   case $1 in
    "--help")
     echo "MIRICLE_install.bash is the installation script for MIRICLE, the Python MIRI Analysis System."
     echo ""
     echo "To be able to install MIRICLE, you need at the Anaconda python environment, at least version 4.2. You need the python 2.7 version."
     echo "You can download Anaconda from https://www.continuum.io/downloads"
     echo ""
     echo "Auxiliary data will be installed in \$HOME/MIRICLE. If you want to install this data in another location, you can set the MIRICLE_ROOT environment variable to this location, or you can use the --path option together with the script."
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
     echo "  --path <path location>"
     echo "      installs the auxiliary data in the given location."
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
     echo "Verbose mode"
     ;;
    "--version")
     version=$2
     shift
     ;;
    "--path")
     MIRICLE_ROOT=$2
     shift
     ;;
    *)
     echo "Invalid install option. Try with --help option to see the valid options."
     exit
     ;;
  esac
  shift
done

cwd=`pwd`

# Create and make a log file.
LOG=~/.miricle/$flavor/`date +%y%m%d-%H%M%S`
mkdir -p $LOG

echoLog ""
echoLog "Installation logs found in ${bold}$LOG${normal}"
echoLog ""

# Check if there is a working internet connection
checkInternet

# Check if there is a newer version of the installation script
checkUpdateOfScript

# Check if anaconda is installed
checkAnacondaInstalled

# Set MIRICLE_ROOT
if [ -z "$MIRICLE_ROOT" ] ; then export MIRICLE_ROOT=$HOME/MIRICLE ; fi

# Check the version number to install
getVersionNumberToInstall

# Work around LC_CTYPE problem on MAC
LCCTYPE=$LC_CTYPE
unset LC_CTYPE

# Set the flavorName
setFlavorName

source activate root

# Remove all old MIRICLE environments if the clean option is selected
if [ -n "$clean" ] ; then
  # Loop over all old MIRICLE environments
  verboseEcho "Removing all the old miricle$flavorName anaconda environments"
  for env in `conda env list | grep miricle$flavorName.2 | awk '{print $1}'`
  do
    echo "${bold}Removing $env${normal}"
    conda env remove -q --yes --name $env 2>&1 | tee -a $LOG/anaconda.log $LOG/log.txt > /dev/null
  done
fi

# Clone the existing conda environment and remove the conda environment which will be created.
# Check if we already have a miricle installation
if [ `conda env list | cut -d' ' -f 1 | grep '^'miricle$flavorName'$' | wc -l` -gt 0 ] ; then
  echoLog ""
  verboseEcho "Copy miricle$flavorName to miricle$flavorName.`date +%Y%m%d`"
  echoLog "${bold}Clone the old miricle$flavorName environment${normal}"
  conda create --yes --name miricle$flavorName.`date +%Y%m%d` --clone miricle$flavorName 2>&1 | tee -a $LOG/anaconda.log $LOG/log.txt > /dev/null
  verboseEcho "Remove the miricle$flavorName python environment"
  conda env remove --yes --name miricle$flavorName 2>&1 | tee -a $LOG/anaconda.log $LOG/log.txt > /dev/null
fi

# Check the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
  os="osx"
else
  os="linux"
fi

verboseEcho "Downloading conda packages from http://www.miricle.org/MIRICLE2/$flavor/$version/miricle-$os-py27.0.txt"
$download http://www.miricle.org/MIRICLE2/$flavor/$version/miricle-$os-py27.0.txt

echoLog "Creating the miricle$flavorName conda environment"
conda create --yes --name miricle$flavorName --file miricle-$os-py27.0.txt 2>&1 | tee -a $LOG/anaconda.log $LOG/log.txt > /dev/null
rm miricle-$os-py27.0.txt

# Install the datafiles
if [ ! -d $MIRICLE_ROOT ]; then
  mkdir $MIRICLE_ROOT
fi

cd $MIRICLE_ROOT

# Test if our reference exist or if it is older than the date of the distant file.
# The purpose is to avoid downloading pysynphot if nothing changed server side from our previous update
if [ ! -e "pysynphot_dl_date" ] || [ pysynphot_dl_date -ot http://www.miricle.org/MIRICLE/extra/pysynphot_dat.tar.gz ]; then
 echoLog "${bold}Installing the datafiles${normal}"
 rm -rf $MIRICLE_ROOT/cdbs
 cd $MIRICLE_ROOT
 $download http://www.miricle.org/MIRICLE/extra/pysynphot_dat.tar.gz
 tar zxf pysynphot_dat.tar.gz
 rm -f pysynphot_dat.tar.gz
 touch "pysynphot_dl_date" # Keep a trace of the date of download. When the file change on the server, we will download again
else
  echoLog "pysynphot datafiles are already installed."
fi


echoLog ""
echoLog "To use the $miricleInstall environment:"
echoLog " ${bold}export MIRICLE_ROOT=$MIRICLE_ROOT${normal}"
echoLog " ${bold}export PYSYN_CDBS=\$MIRICLE_ROOT/cdbs/${normal}"
echoLog ""
echoLog " ${bold}source activate miricle$flavorName${normal}"
echoLog ""
echoLog "To switch back to the system python version:"
echoLog " ${bold}source deactivate${normal}"
echoLog ""
