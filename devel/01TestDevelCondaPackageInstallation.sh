function checkError {
  if [ $? -ge "1" ] ; then
    exit 1
  fi
}

export PATH=/export/disk/anaconda.42/bin:$PATH

source activate root

for env in `conda env list | grep miricle | awk '{print $1}'`
do
  echo "Removing $env"
  conda env remove --yes --name $env
  checkError
done

conda create --yes --name miricle.devel --file miricle-linux-py27.0.txt
checkError

source activate miricle.devel
checkError
