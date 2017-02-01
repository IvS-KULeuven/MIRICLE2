function checkError {
  if [ $? -ge "1" ] ; then
    exit 1
  fi
}

# Set up the anaconda environment
./00SetupAnaconda.sh
checkError

rm -rf conda

# Check out the conda-test branch with a list of all conda packages to install
git clone -b conda-test https://github.com/IvS-KULeuven/MIRICLE2.git conda

# Put the conda environment file in the correct directory
mkdir -p /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}
cp conda/miricle-*-py27.0.txt /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}

# Build cr_sim_ramp_fit
rm -rf cr_sim_ramp_fit
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/prototypes/cr_sim_ramp_fit
checkError

cd cr_sim_ramp_fit
mv ../02CrSimRampFit.sh .
./02CrSimRampFit.sh /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}
checkError

file=`ls /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/ | grep cr-sim-ramp-fit`

# Add cr-sim-ramp-fit to the install files
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/osx-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-osx-py27.0.txt

cd ..

# Build miri
rm -rf miri
svn checkout -r 4472 https://aeon.stsci.edu/ssb/svn/jwst/trunk/teams/miri
checkError

cd miri
mv ../03Miri.sh .
./03Miri.sh /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}
checkError

file=`ls /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/ | grep miri-`

# Add miri to the install files
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/osx-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-osx-py27.0.txt

cd ..

# Build pyspecsim
rm -rf pySpecSim

svn checkout -r 297 --username WimDeMeester https://forge.roe.ac.uk/svn/pySpecSim/trunk/pySpecSim
checkError

cd pySpecSim
mv ../04PySpecSim.sh .
./04PySpecSim.sh /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}
checkError

file=`ls /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/ | grep pyspecsim-`

# Add pyspecsim to the install files
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/osx-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-osx-py27.0.txt

cd ..


# Build mirisim
rm -rf mirisim

svn checkout -r 657 --username WimDeMeester https://forge.roe.ac.uk/svn/MIRISim/branches/testteam_beta_r6.0 mirisim
checkError

cd mirisim
mv ../05MiriSim.sh .
./05MiriSim.sh /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}
checkError

file=`ls /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/ | grep mirisim-`

# Add mirisim to the install files
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/linux-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/osx-64/$file" >> /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/miricle-osx-py27.0.txt

cd ..

# Create a file with the version number of the pysynphot data files

while read line; do
  version=$line
done < /srv/www/www.miricle.org/MIRICLE2/pysynphot_data/pysynphot_data_version

echo $version > /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}/pysynphot_data


# Copy the MAC installations to the correct directory
scp -r munki:/Users/jenkins/condaBuild/osx-64 /srv/www/www.miricle.org/MIRICLE2/test/${BUILD_NUMBER}
checkError

# TODO: Install and test!
