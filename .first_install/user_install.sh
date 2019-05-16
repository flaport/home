#!/usr/bin/env bash

# ---------------------------------------------------- #
# !!! NOTE THAT THIS SCRIPT SHOULD NOT BE SOURCED. !!! #
# ---------------------------------------------------- #

# ------ #
# CHECKS #
# ------ #

## Pre-installation checks
if [ $USER == root ]; then
    echo
    echo "first_install.sh should not be run as root / with sudo."
    echo "this script should be run normally by a user [with sudo privileges]."
    exit 1
fi

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    echo
    echo "first_install.sh should NOT be sourced."
    exit 1
else


# --------------- #
# ANACONDA PYTHON #
# --------------- #

CONDA="$HOME/.anaconda/bin/conda"

printf "installing anaconda python... "
if [ ! -d $HOME/.anaconda ]; then
    cd $HOME
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output miniconda.sh --silent
    sh miniconda.sh -b -p $HOME/.anaconda &> /dev/null
    rm miniconda.sh
    echo "installed."
else
    echo "already installed"
fi

# ---------------- #
# BASE ENVIRONMENT #
# ---------------- #

PIP="$HOME/.anaconda/bin/pip"
NPM="$HOME/.anaconda/bin/npm"

echo "installing base packages for environment: base [takes long!]"
$CONDA install -y -S jupyter ipykernel ipywidgets tqdm numpy pandas cython pillow scikit-learn matplotlib tensorflow keras h5py flask pandoc pylint mypy line_profiler pytz simplejson jupyterlab &> /dev/null

echo "installing pytorch for environment: base [takes long!]"
$CONDA install -y -S -c pytorch pytorch &> /dev/null

echo "installing octave for environment: base"
$PIP install octave_kernel &> /dev/null

# echo "installing matlab for environment: base"
# cd <matlabinstallation>/extern/engines/python
# sudo python setup.py install &> /dev/null
# cd $HOME
# $PIP install matlab_kernel &> /dev/null
# altair

echo "installing altair for environment: base"
$CONDA install -y -S -c conda-forge altair vega &> /dev/null

echo "installing plotly for environment: base"
$PIP install plotly &> /dev/null # plotting library

echo "installing grip for environment: base"
$PIP install grip &> /dev/null # markdown previews

echo "installing ipdb for environment: base"
$PIP install ipdb &> /dev/null # pdb in jupyter notebooks

echo "installing black for environment: base"
$PIP install black &> /dev/null # code formatting

echo "installing ueberzug for environment: base"
$PIP install ueberzug &> /dev/null # display images in terminal

echo "installing bayesian-optimization for environment: base"
$PIP install bayesian-optimization &> /dev/null # optimization of hyperparameters

echo "installing pygmo for environment: base"
$PIP install pygmo &> /dev/null # optimization of multi-variable functions

echo "installing google cloud api for environment: base"
$PIP install google-api-python-client google-auth-httplib2 google-auth-oauthlib &> /dev/null

echo "installing nodejs for environment: base"
$CONDA install -y -S nodejs=8 &> /dev/null

echo "installing jupyterhub for environment: base"
$CONDA install -y -S -c jupyterhub -y -c conda-forge &> /dev/null

echo "installing neovim support for environment: base"
$PIP install neovim &> /dev/null
$NPM install -g neovim &> /dev/null


# -------------------- #
# PYTHON 2 ENVIRONMENT #
# -------------------- #

PIP="$HOME/.anaconda/envs/py2/bin/pip"

echo "creating python 2 environment: py2"
if [ ! -d "$HOME/.anaconda/envs/py2" ]; then
    $CONDA create -y -n py2 python=2.7 &> /dev/null
fi
echo "installing base packages for environment: py2"
$CONDA install -y -S -n py2 ipykernel tqdm numpy pandas cython pillow scikit-learn matplotlib ipywidgets h5py flask pandoc pylint line_profiler pytz simplejson &> /dev/null
echo "installing pytorch for environment: py2"
$CONDA install -y -S -n py2 pytorch -c pytorch &> /dev/null
echo "installing ipykernel for environment: py2"
$HOME/.anaconda/envs/py2/bin/python -m ipykernel install --user --name python2 --display-name "Python 2"
mv $HOME/.local/share/jupyter/kernels/python2 $HOME/.anaconda/share/jupyter/kernels/python2
echo "installing altair for environment: py2"
$CONDA install -y -S -n py2 -c conda-forge altair vega &> /dev/null
echo "installing neovim support for environment: py2"
$PIP install neovim &> /dev/null


# ------------- #
# R ENVIRONMENT #
# ------------- #
echo "creating R environment: r"
if [ ! -d "$HOME/.anaconda/envs/r" ]; then
    $CONDA create -y -n r &> /dev/null
fi
echo "installing base packages for environment: r"
$CONDA install -y -S -n r -c r r-irkernel &> /dev/null
echo "installing ipykernel for environment: r"
cp -rf $HOME/.anaconda/envs/r/share/jupyter/kernels/ir $HOME/.anaconda/share/jupyter/kernels
home=$(echo $HOME | sed 's/\//\\\//g')
sed "0,/R/{s/R/$home\/.anaconda\/envs\/r\/bin\/R/}" $HOME/.anaconda/share/jupyter/kernels/ir/kernel.json > $HOME/.anaconda/share/jupyter/kernels/ir/kernel2.json
mv $HOME/.anaconda/share/jupyter/kernels/ir/kernel2.json $HOME/.anaconda/share/jupyter/kernels/ir/kernel.json

# ----------------- #
# JULIA ENVIRONMENT #
# ----------------- #
echo "creating Julia environment: r"
if [ ! -d "$HOME/.anaconda/envs/julia" ]; then
    $CONDA create -y -n julia &> /dev/null
fi
echo "installing base packages for environment: julia"
$CONDA install -y -S -n julia -c conda-forge julia &> /dev/null
$HOME/.anaconda/envs/julia/bin/julia -E 'using Pkg; Pkg.add("IJulia"); precompile' &> /dev/null
echo "installing ipykernel for environment: julia"
$HOME/.anaconda/envs/julia/bin/julia -E 'using IJulia; installkernel("Julia")' &> /dev/null
mv $HOME/.local/share/jupyter/kernels/julia* $HOME/.anaconda/share/jupyter/kernels/


# ----- #
# FIXES #
# ----- #

# remove $CONDA ld binary because it causes trouble for cython:
echo "disabling $CONDA ld binary in favor of the system one [fixes cython on arch linux] "
mv $HOME/.anaconda/compiler_compat/ld $HOME/.anaconda/compiler_compat/ld_disabled
mv $HOME/.anaconda/envs/py2/compiler_compat/ld $HOME/.anaconda/envs/py2/compiler_compat/ld_disabled
mv $HOME/.anaconda/envs/py36/compiler_compat/ld $HOME/.anaconda/envs/py36/compiler_compat/ld_disabled



# --------------------- #
# JUPYTERLAB EXTENSIONS #
# --------------------- #

JUPYTER = "$HOME/.anaconda/bin/jupyter"

# jupyterlab extensions
echo "installing jupyterlab vim extension"
$JUPYTER labextension install jupyterlab_vim &> /dev/null
echo "installing jupyterlab hub extension"
$JUPYTER labextension install @jupyterlab/hub-extension &> /dev/null
echo "installing jupyterlab plotly extension"
$JUPYTER labextension install @jupyterlab/plotly-extension &> /dev/null
echo "installing jupyterlab table of contents extension"
$JUPYTER labextension install @jupyterlab/toc &> /dev/null
echo "installing jupyterlab manager extension"
$JUPYTER labextension install @jupyter-widgets/jupyterlab-manager &> /dev/null
echo "installing jupyterlab variable inspector extension"
$JUPYTER labextension install @lckr/jupyterlab_variableinspector &> /dev/null
echo "installing jupyterlab latex extension"
$JUPYTER labextension install @jupyterlab/latex &> /dev/null
$PIP install jupyterlab_latex &> /dev/null
$JUPYTER serverextension enable --py jupyterlab_latex &> /dev/null
echo "installing jupyterlab git extension"
$JUPYTER labextension install @jupyterlab/git &> /dev/null
$PIP install jupyterlab_git &> /dev/null
$JUPYTER serverextension enable --py jupyterlab_git &> /dev/null
echo "installing jupyterlab code formatter extension"
$JUPYTER labextension install @ryantam626/jupyterlab_code_format &> /dev/null
$PIP install jupyterlab_code_formatter &> /dev/null
$JUPYTER serverextension enable --py jupyterlab_code_formatter &> /dev/null

#-------------------------------------
fi # stop if