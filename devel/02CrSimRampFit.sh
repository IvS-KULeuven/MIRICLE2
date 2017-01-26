rm -rf jenkins
git clone -b jenkins https://github.com/IvS-KULeuven/MIRICLE2.git jenkins

rm -rf conda-devel
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda-devel
mv conda-devel/miricle-linux-py27.0.txt .

bash jenkins/devel/01TestDevelCondaPackageInstallation.sh

export PATH=/export/disk/anaconda.42/bin:$PATH

source activate miricle.devel

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
echo "  path: ../" >> meta.yaml
echo "" >> meta.yaml
echo "build:" >> meta.yaml
echo "  script: python setup.py install" >> meta.yaml
echo "" >> meta.yaml
echo "requirements:" >> meta.yaml
echo "  build:" >> meta.yaml
echo "    - python" >> meta.yaml
echo "  run:" >> meta.yaml
echo "    - python" >> meta.yaml

cd ..
conda build cr-sim-ramp-fit --output-folder=/tmp/

conda install /tmp/linux-64/cr-sim-ramp-fit-$version-py27_0.tar.bz2
conda build purge

exit 5
