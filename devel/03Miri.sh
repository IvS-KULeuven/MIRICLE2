rm -rf jenkins
git clone -b jenkins https://github.com/IvS-KULeuven/MIRICLE2.git jenkins

rm -rf conda-devel
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda-devel
mv conda-devel/miricle-linux-py27.0.txt .

bash jenkins/devel/01TestDevelCondaPackageInstallation.sh

export PATH=/export/disk/anaconda.42/bin:$PATH

source activate miricle.devel


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
conda build miri --output-folder=/tmp/

conda install /tmp/linux-64/miri-$version-py27_0.tar.bz2
conda build purge
