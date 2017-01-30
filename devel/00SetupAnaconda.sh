function checkError {
  if [ $? -ge "1" ] ; then
    exit 1
  fi
}

export PATH=/export/disk/anaconda.42/bin:$PATH

source activate root

conda install conda-build
checkError
conda upgrade conda
checkError
conda upgrade conda-build
checkError

for env in `conda env list | grep miricle | awk '{print $1}'`
do
  echo "${bold}Removing $env${normal}"
  conda env remove -q --yes --name $env
  checkError
done
