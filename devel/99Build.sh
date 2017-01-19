# Set up the anaconda environment
./00SetupAnaconda.sh

# Check out the conda-devel branch with a list of all conda packages to install
git clone https://github.com/IvS-KULeuven/MIRICLE2.git

git checkout conda-devel


mkdir -p /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}
cp miricle-*-py27.0.txt /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}


echo ${BUILD_NUMBER} >> /srv/www/www.miricle.org/MIRICLE2/devel/buildNumbers


# TODO: Install and test!
