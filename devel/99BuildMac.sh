# Set up the anaconda environment
./00SetupAnacondaMac.sh

rm -rf conda

# Check out the conda-devel branch with a list of all conda packages to install
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda

rm -rf /Users/jenkins/condaBuild
./02CrSimRampFitMac.sh /Users/jenkins/condaBuild/


rm -rf miri
svn checkout https://aeon.stsci.edu/ssb/svn/jwst/trunk/teams/miri
cd miri
rm -rf miri
mkdir miri
cd miri
touch meta.yaml
echo "package:" > meta.yaml
echo "  name: miri" >> meta.yaml
version=`grep version ../lib/__init__.py | sed "s/__version__ = '//g"  | sed "s/'//g"`
echo "  version: \"$version\"" >> meta.yaml
echo "" >> meta.yaml
echo "source:" >> meta.yaml
echo "  url: https://aeon.stsci.edu/ssb/svn/jwst/trunk/teams/miri" >> meta.yaml
echo "" >> meta.yaml
echo "requirements:" >> meta.yaml
echo "  build:" >> meta.yaml
echo "    - python" >> meta.yaml
echo "  run:" >> meta.yaml
echo "    - python" >> meta.yaml

cd ..

export PATH=/export/disk/anaconda.42/bin:$PATH

source activate miricle.devel

conda build miri --output-folder=/Users/jenkins/condaBuild

conda build purge

cd ..
