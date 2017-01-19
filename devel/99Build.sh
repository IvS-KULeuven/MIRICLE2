# Set up the anaconda environment
./00SetupAnaconda.sh

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git

ls

mkdir -p /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}
cp MIRICLE2/miricle-*-py27.0.txt /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

ls

echo ${BUILD_NUMBER} >> /srv/www/www.miricle.org/MIRICLE2/devel/buildNumbers


# TODO: Install and test!
