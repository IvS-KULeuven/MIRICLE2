export PATH=/export/disk/anaconda.42/bin:$PATH

source activate root

conda install conda-build
conda upgrade conda
conda upgrade conda-build

for env in `conda env list | grep miricle | awk '{print $1}'`
do
  echo "${bold}Removing $env${normal}"
  conda env remove -q --yes --name $env
done

