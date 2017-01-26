# Set up the anaconda environment
./00SetupAnacondaMac.sh

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda

rm -rf /Users/jenkins/condaBuild

# Build the packages
./02CrSimRampFitMac.sh /Users/jenkins/condaBuild/
./03MiriMac.sh /Users/jenkins/condaBuild/
