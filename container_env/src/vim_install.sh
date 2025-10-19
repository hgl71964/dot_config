#! /bin/bash

# this scripts install common software

# the current script path
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# ---------------------------------------------------------------------------------------
# build vim from source if needed
# https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source

# make .vim

if [ ! -d "$.vim" ]; then
    mkdir -p .vim/pack/autoplugs/start
fi

# ---------------------------------------------------------------------------------------
# basic package

# git clone will fail if folder already exists
git clone --depth=1 https://github.com/morhetz/gruvbox.git .vim/pack/autoplugs/start/gruvbox
git clone --depth=1 https://github.com/mg979/vim-visual-multi.git .vim/pack/autoplugs/start/visual_multi
# ---------------------------------------------------------------------------------------
# for fizzy file search

git clone --depth=1 https://github.com/Yggdroot/LeaderF.git .vim/pack/autoplugs/start/LeaderF

#
# ---------------------------------------------------------------------------------------
# for async git diff

git clone --depth=1 https://github.com/mhinz/vim-signify.git .vim/pack/autoplugs/start/vim-signify

# ---------------------------------------------------------------------------------------
# for nerdtree

git clone --depth=1 https://github.com/preservim/nerdtree.git .vim/pack/autoplugs/start/nerdtree
#---------------------------------------------------------------------------------------
# for MLIR-syntax
git clone --depth=1 https://github.com/llvm/llvm-project.git
cp -r llvm-project/mlir/utils/vim/ .vim/pack/autoplugs/start/mlir

# ---------------------------------------------------------------------------------------
# for YCM in vim

# git clone --depth=1 --recurse-submodules https://github.com/ycm-core/YouCompleteMe.git .vim/pack/autoplugs/start/ycm
# apt install build-essential cmake vim-nox python3-dev --yes
# apt install mono-complete golang nodejs default-jdk npm --yes
#
# # need to go to ycm dir to run git submodule update
# cd ~/.vim/pack/autoplugs/start/ycm
# git submodule update --init --recursive
# cd ~
#
# python3 ~/.vim/pack/autoplugs/start/ycm/install.py --all

#echo 'let g:ycm_autoclose_preview_window_after_insertion = 1' >> ~/.vimrc  # the window of a function description auto-close

# ---------------------------------------------------------------------------------------
# for python syntax highlight in vim

git clone --depth=1 https://github.com/vim-python/python-syntax.git .vim/pack/autoplugs/start/python-syntax
#echo 'let g:python_highlight_all = 1' >> ~/.vimrc

