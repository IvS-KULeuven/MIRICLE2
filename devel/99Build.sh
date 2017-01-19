# Set up the anaconda environment
./00SetupAnaconda.sh

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda

# Put the conda environment file in the correct directory
mkdir -p /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}
cp conda/miricle-*-py27.0.txt /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

# TODO: Install and test!
