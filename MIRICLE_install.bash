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
     echo "Verbose mode"
     verbose=1
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

#echo $flavor
#echo "Version $version"
