# install anaconda python
cd ~
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output miniconda.sh
sh miniconda.sh -b -p $HOME/.anaconda
rm miniconda.sh

# remove ld binary that causes trouble for cython:
mv ~/.anaconda/compiler_compat/ld ~/.anaconda/compiler_compat/ld_disabled

# add anaconda to path
export $PATH="$HOME/.anaconda/bin:$PATH"

# install nodejs in our anaconda installation
conda install -y nodejs

# neovim anaconda python integration
pip install neovim
npm install -g neovim

# conda packages
conda install -y tqdm
conda install -y numpy
conda install -y pandas
conda install -y cython
conda install -y pillow
conda install -y scikit-learn
conda install -y matplotlib
conda install -y jupyter
conda install -y pytorch -c pytorch

# these need to be installed with conda-forge to make sure 
# nodejs is not downgraded
conda install -y jupyterlab -c conda-forge
conda install -y jupyterhub -c conda-forge
conda install -y ipywidgets
conda install -y ipykernel

# jupyter environments/kernels
# python 2
conda create -y -n py2 python=2.7 ipykernel tqdm numpy pandas cython pillow scikit-learn matplotlib ipywidgets
conda install -y -n py2 pytorch -c pytorch
$HOME/.anaconda/envs/py2/bin/python -m ipykernel install --user --name python2 --display-name "Python 2"
mv $HOME/.local/share/jupyter/kernels/python2 $HOME/.anaconda/share/jupyter/kernels/python2
# python 3.6
conda create -y -n py36 python=3.7 ipykernel tqdm numpy pandas cython pillow scikit-learn matplotlib ipywidgets tensorflow keras
conda install -y -n py36 pytorch -c pytorch
$HOME/.anaconda/envs/py36/bin/python -m ipykernel install --user --name python36 --display-name "Python 3.6"
mv $HOME/.local/share/jupyter/kernels/python36 $HOME/.anaconda/share/jupyter/kernels/python36
# r
conda create -y -c r -n r r-irkernel
cp -rf $HOME/.anaconda/envs/r/share/jupyter/kernels/ir $HOME/.anaconda/share/jupyter/kernels
home=$(echo $HOME | sed 's/\//\\\//g')
sed "0,/R/{s/R/$home\/.anaconda\/envs\/r\/bin\/R/}" $HOME/.anaconda/share/jupyter/kernels/ir/kernel.json > $HOME/.anaconda/share/jupyter/kernels/ir/kernel2.json
mv $HOME/.anaconda/share/jupyter/kernels/ir/kernel2.json $HOME/.anaconda/share/jupyter/kernels/ir/kernel.json
# julia
conda create -y -c conda-forge -n julia julia
$HOME/.anaconda/envs/julia/bin/julia -E 'using Pkg; Pkg.add("IJulia"); precompile'
$HOME/.anaconda/envs/julia/bin/julia -E 'using IJulia; installkernel("Julia")'
mv $HOME/.local/share/jupyter/kernels/julia* $HOME/.anaconda/share/jupyter/kernels/
# octave
pip install octave_kernel
# matlab
# cd /usr/local/MATLAB/R2018b/extern/engines/python
# python setup.py install
# cd ~
# pip install matlab_kernel

# pip packages
pip install grip
pip install ipdb
pip install black
pip install ueberzug

# jupyterlab extensions
jupyter labextension install jupyterlab_vim
jupyter labextension install @jupyterlab/plotly-extension
jupyter labextension install @jupyterlab/toc
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install https://github.com/lckr/jupyterlab-variableinspector
jupyter labextension install @jupyterlab/latex
pip install jupyterlab_latex
jupyter serverextension enable --py jupyterlab_latex
jupyter labextension install @jupyterlab/git
pip install jupyterlab_git
jupyter serverextension enable --py jupyterlab_git
jupyter labextension install @ryantam626/jupyterlab_code_formatter
pip install jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter
