# Set up the anaconda environment
./00SetupAnaconda.sh

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda

# Put the conda environment file in the correct directory
mkdir -p /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}
cp conda/miricle-*-py27.0.txt /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

rm -rf cr_sim_ramp_fit
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/prototypes/cr_sim_ramp_fit
cd cr_sim_ramp_fit
rm -rf cr-sim-ramp-fit
mkdir cr-sim-ramp-fit
cd cr-sim-ramp-fit
touch meta.yaml
echo "package:" > meta.yaml
echo "  name: cr-sim-ramp-fit" >> meta.yaml
version=`grep version ../defsetup.py | sed "s/     'version' : '//g"  | sed "s/',//g"`
echo "  version: \"$version\"" >> meta.yaml
echo "" >> meta.yaml
echo "source:" >> meta.yaml
echo "  url: https://aeon.stsci.edu/ssb/svn/jwst/trunk/prototypes/cr_sim_ramp_fit" >> meta.yaml
echo "" >> meta.yaml
echo "requirements:" >> meta.yaml
echo "  build:" >> meta.yaml
echo "    - python" >> meta.yaml
echo "  run:" >> meta.yaml
echo "    - python" >> meta.yaml


cd ..


export PATH=/export/disk/anaconda.42/bin:$PATH

source activate root

conda build cr-sim-ramp-fit --output-folder=/srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

echo "http://www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/linux-64/cr-sim-ramp-fit-$version-py27_0.tar.bz2" >> /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/miricle-linux-py27.0.txt
echo "http://www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/osx-64/cr-sim-ramp-fit-$version-py27_0.tar.bz2" >> /srv/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}/miricle-osx-py27.0.txt

conda build purge

# Copy the MAC installations to the correct directory
scp -r munki:/Users/jenkins/condaBuild/osx-64 /srw/www/www.miricle.org/MIRICLE2/devel/${BUILD_NUMBER}

# TODO: Install and test!
