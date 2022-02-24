# configs
Configuration files that I share between computers. To use these files clone this repository into your root directory, and then follow the setup below for specific programs.
1. `cd ~`
1. `git clone https://github.com/colin99d/configs`

## vim
These are the steps to use the .vimrc provided in this repository.
1. `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
1. `vim ~/.vimrc`
1. Add the line `source ~/configs/.vimrc`
1. Open vim and run `:PluginInstall`

## zsh
These are the steps to use the .zfunc provided in this repository.

1. `vim .zshrc`
1. Add the line `source ~/configs/.zfunc`
