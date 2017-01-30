function checkError {
  if [ $? -ge "1" ] ; then
    exit 1
  fi
}

# Set up the anaconda environment
./00SetupAnacondaMac.sh
checkError

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda
checkError

rm -rf /Users/jenkins/condaBuild

# Build the packages
rm -rf cr_sim_ramp_fit
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/prototypes/cr_sim_ramp_fit
checkError

cd cr_sim_ramp_fit
mv ../02CrSimRampFitMac.sh .
./02CrSimRampFitMac.sh /Users/jenkins/condaBuild/
checkError

cd ..
rm -rf miri
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/teams/miri
checkError

cd miri
mv ../03MiriMac.sh .
./03MiriMac.sh /Users/jenkins/condaBuild/
checkError
cd ..

# Build pyspecsim
rm -rf pySpecSim
svn checkout --username WimDeMeester https://forge.roe.ac.uk/svn/pySpecSim/trunk/pySpecSim
checkError

cd pySpecSim
mv ../04PySpecSimMac.sh .
./04PySpecSimMac.sh /Users/jenkins/condaBuild/
checkError

cd ..

# Build mirisim
rm -rf mirisim
svn checkout --username WimDeMeester https://forge.roe.ac.uk/svn/MIRISim/trunk/ mirisim
checkError

cd mirisim
mv ../05MiriSimMac.sh .
./05MiriSimMac.sh /Users/jenkins/condaBuild/
checkError

cd ..
