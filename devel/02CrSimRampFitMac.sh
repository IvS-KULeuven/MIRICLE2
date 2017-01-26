outputdir=$1

rm -rf jenkins
git clone -b jenkins https://github.com/IvS-KULeuven/MIRICLE2.git jenkins

rm -rf conda-devel
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda-devel
mv conda-devel/miricle-osx-py27.0.txt .

bash jenkins/devel/01TestDevelCondaPackageInstallationMac.sh

export PATH=/Users/jenkins/anaconda2/bin:$PATH

source activate miricle.devel

# We add the stsci conda-dev channel to be able to install stscitools
conda config --add channels http://ssb.stsci.edu/conda-dev/

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
stsciversion=`grep stsci.tools ../miricle-linux-py27.0.txt | sed "s/http:\/\/ssb.stsci.edu\/conda-dev\/linux-64\/stsci.tools-//g" | sed "s/-np111py27_0.tar.bz2//g"`
echo "    - stsci.tools $stsciversion" >> meta.yaml
echo "  run:" >> meta.yaml
echo "    - python" >> meta.yaml

cd ..
rm -rf $outputdir/osx-64/cr-sim-ramp-fit*
conda build cr-sim-ramp-fit --output-folder=$outputdir/

conda install $outputdir/osx-64/cr-sim-ramp-fit-$version-py27_0.tar.bz2
conda build purge
