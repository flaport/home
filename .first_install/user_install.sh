# install anaconda python
cd ~
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output miniconda.sh
sh miniconda.sh -b -p $HOME/.anaconda
rm miniconda.sh

# remove ld binary that causes trouble for cython:
mv ~/.anaconda/compiler_compat/ld ~/.anaconda/compiler_compat/ld_disabled

# add anaconda to path
export $PATH="$HOME/.anaconda/bin:$PATH"
conda init bash
conda init fish

# install nodejs in our anaconda installation
conda install -y nodejs

# neovim anaconda python integration
pip install neovim
npm install -g neovim

# conda packages
conda install -y numpy
conda install -y pandas
conda install -u cython
conda install -y scikit-learn
conda install -y matplotlib
conda install -y jupyter

# these need to be installed with conda-forge to make sure 
# nodejs is not downgraded
conda install -y jupyterlab -c conda-forge
conda install -y jupyterhub -c conda-forge
conda install -y ipywidgets
conda install -y ipykernel

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

# pip packages
pip install grip
pip install ipdb
pip install black
pip install octave_kernel
pip install ueberzug
