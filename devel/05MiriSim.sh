function checkError {
  if [ $? -ge "1" ] ; then
    exit 1
  fi
}
outputdir=$1

rm -rf jenkins
git clone -b jenkins https://github.com/IvS-KULeuven/MIRICLE2.git jenkins

rm -rf conda-devel
git clone -b conda-devel https://github.com/IvS-KULeuven/MIRICLE2.git conda-devel
mv conda-devel/miricle-linux-py27.0.txt .

bash jenkins/devel/01TestDevelCondaPackageInstallation.sh

export PATH=/export/disk/anaconda.42/bin:$PATH

source activate miricle.devel


rm -rf build
mkdir build
mkdir build/mirisim
cd build/mirisim
touch meta.yaml
echo "package:" > meta.yaml
echo "  name: mirisim" >> meta.yaml
version=`grep "__version__ =" ../../mirisim/lib/__init__.py | sed 's/__version__ = "//g'  | sed 's/"//g'`
echo "  version: \"$version\"" >> meta.yaml
echo "" >> meta.yaml
echo "source:" >> meta.yaml
echo "  path: ../../" >> meta.yaml
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

rm -rf $outputdir/linux-64/mirisim-*
conda build mirisim --output-folder=$outputdir/
checkError

conda install $outputdir/linux-64/mirisim-$version-py27_0.tar.bz2
checkError

conda build purge
checkError

# The miri package is installed, we now start building the documentation
source deactivate
rm -rf *.rst conf.py make.bat Makefile _build _static _templates
sphinx-apidoc -F -o . .
checkError

sed -e "s/TODAY/`date +"%Y%m%d"`/g" /srv/www/www.miricle.org/doc/confmirisim.py > conf.py

export PATH=/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin

make html
checkError

make latexpdf
checkError
