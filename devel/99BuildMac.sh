# Set up the anaconda environment
./00SetupAnacondaMac.sh

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda

rm -rf /Users/jenkins/condaBuild

# Build the packages
rm -rf cr_sim_ramp_fit
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/prototypes/cr_sim_ramp_fit
cd cr_sim_ramp_fit
mv ../02CrSimRampFitMac.sh .
./02CrSimRampFitMac.sh /Users/jenkins/condaBuild/

cd ..
rm -rf miri
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/teams/miri
cd miri
mv ../03MiriMac.sh .
./03MiriMac.sh /Users/jenkins/condaBuild/


# Build pyspecsim
cd ..
rm -rf pySpecSim
svn checkout --username WimDeMeester https://forge.roe.ac.uk/svn/pySpecSim/trunk/pySpecSim
cd pySpecSim
mv ../04PySpecSimMac.sh .
./04PySpecSimMac.sh /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

cd ..
