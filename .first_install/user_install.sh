#!/usr/bin/env bash
# install anaconda python
cd ~
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output miniconda.sh
sh miniconda.sh -b -p $HOME/.anaconda
rm miniconda.sh

# add anaconda to path
export $PATH="$HOME/.anaconda/bin:$PATH"

# neovim anaconda python integration
pip install neovim
npm install -g neovim

# conda packages
conda install -y jupyter ipykernel ipywidgets tqdm numpy pandas cython pillow scikit-learn matplotlib tensorflow keras h5py flask pandoc pylint mypy line_profiler pytz simplejson jupyterlab
conda install -y pytorch -c pytorch

# jupyter environments/kernels
# python 2
conda create -y -n py2 python=2.7 ipykernel tqdm numpy pandas cython pillow scikit-learn matplotlib ipywidgets h5py flask pandoc pylint line_profiler pytz simplejson
conda install -y -n py2 pytorch -c pytorch
$HOME/.anaconda/envs/py2/bin/python -m ipykernel install --user --name python2 --display-name "Python 2"
mv $HOME/.local/share/jupyter/kernels/python2 $HOME/.anaconda/share/jupyter/kernels/python2
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
# cd <matlabinstallation>/extern/engines/python
# sudo python setup.py install
# cd ~
# pip install matlab_kernel

# altair
conda install -y altair vega -c conda-forge
conda install -y -n py2 altair vega -c conda-forge
conda install -y -n py36 altair vega -c conda-forge

# remove ld binary that causes trouble for cython:
mv ~/.anaconda/compiler_compat/ld ~/.anaconda/compiler_compat/ld_disabled
mv ~/.anaconda/envs/py2/compiler_compat/ld ~/.anaconda/envs/py2/compiler_compat/ld_disabled
mv ~/.anaconda/envs/py36/compiler_compat/ld ~/.anaconda/envs/py36/compiler_compat/ld_disabled

# pip packages
pip install plotly # plotting library
pip install grip # markdown previews
pip install ipdb # pdb in jupyter notebooks
pip install black # code formatting
pip install ueberzug # display images in terminal
pip install bayesian-optimization # optimization of hyperparameters
pip install pygmo # optimization of multi-variable functions

# google
pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib

# install nodejs in our anaconda installation
conda install -y nodejs=8
conda install jupyterhub -y -c conda-forge

# jupyterlab extensions
jupyter labextension install jupyterlab_vim
jupyter labextension install @jupyterlab/hub-extension
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
