outputdir=$1

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
scipyversion=`grep scipy ../miricle-linux-py27.0.txt | sed "s/https:\/\/repo.continuum.io\/pkgs\/free\/linux-64\/scipy-//g" | sed "s/-np111py27_0.tar.bz2//g"`
echo "    - scipy $scipyversion" >> meta.yaml
asdfversion=`grep asdf ../miricle-linux-py27.0.txt | sed "s/http:\/\/ssb.stsci.edu\/conda-dev\/linux-64\/asdf-//g" | sed "s/-np111py27_0.tar.bz2//g"`
echo "    - asdf $asdfversion" >> meta.yaml
jwstversion=`grep jwst ../miricle-linux-py27.0.txt | sed "s/http:\/\/ssb.stsci.edu\/conda-dev\/linux-64\/jwst-//g" | sed "s/-np111py27_0.tar.bz2//g"`
echo "    - jwst $jwstversion" >> meta.yaml
echo "  run:" >> meta.yaml
echo "    - python" >> meta.yaml

cd ..

# TODO: Fix these errors in svn
rm datamodels/doc/source/tutorial/tutorial
rm datamodels/doc/source/pyplot/pyplot

rm -rf $outputdir/linux-64/miri-*
conda build miri --output-folder=$outputdir/

conda install $outputdir/miri-$version-py27_0.tar.bz2
conda build purge
