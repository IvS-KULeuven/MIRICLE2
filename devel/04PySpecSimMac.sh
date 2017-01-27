outputdir=$1

rm -rf jenkins
git clone -b jenkins https://github.com/IvS-KULeuven/MIRICLE2.git jenkins

rm -rf conda-devel
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda-devel
mv conda-devel/miricle-osx-py27.0.txt .

bash jenkins/devel/01TestDevelCondaPackageInstallationMac.sh

export PATH=/Users/jenkins/anaconda2/bin:$PATH

source activate miricle.devel

rm -rf pyspecsim
mkdir pyspecsim
cd pyspecsim
touch meta.yaml
echo "package:" > meta.yaml
echo "  name: pyspecsim" >> meta.yaml
version=`grep version ../lib/pySpecSim/__init__.py | sed 's/__version__ = "//g'  | sed 's/"//g'`echo "  version: \"$version\"" >> meta.yamlecho "" >> meta.yaml
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

rm -rf $outputdir/osx-64/pyspecsim-*
conda build pyspecsim --output-folder=$outputdir/

conda install $outputdir/osx-64/pyspecsim-$version-py27_0.tar.bz2
conda build purge
