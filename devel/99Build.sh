# Set up the anaconda environment
./00SetupAnaconda.sh

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda

# Put the conda environment file in the correct directory
mkdir -p /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}
cp conda/miricle-*-py27.0.txt /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}


./02CrSimRampFit.sh /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

# Add cr-sim-ramp-fit to the install files
echo "http://www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/linux-64/cr-sim-ramp-fit-$version-py27_0.tar.bz2" >> /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/osx-64/cr-sim-ramp-fit-$version-py27_0.tar.bz2" >> /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/miricle-osx-py27.0.txt

./03Miri.sh /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}
echo "http://www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/linux-64/miri-$version-py27_0.tar.bz2" >> /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/osx-64/miri-$version-py27_0.tar.bz2" >> /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/miricle-osx-py27.0.txt

# Copy the MAC installations to the correct directory
scp -r munki:/Users/jenkins/condaBuild/osx-64 /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

# TODO: Install and test!
