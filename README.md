# configs
Configuration files that I share between computers. To use these files clone this repository into your root directory, and then follow the setup below for specific programs.
1. `cd ~`
1. `git clone https://github.com/colin99d/configs`

## Vim
These are the steps to use the .vimrc provided in this repository.
1. `vim ~/.vimrc`
1. Add the line `source ~/configs/.vimrc`

### You Complete Me
You complete me takes additional configuration, please do the following:
1. `pip install cmake`
1. `cd ~/.vim/bundle/YouCompleteMe`
1. `./install.py`

### Silver Searcher
Install Silver Search for the FZF Ag command to work
1. `brew install the_silver_searcher`

## ZSH
These are the steps to use the .zfunc provided in this repository.

1. `vim .zshrc`
1. Add the line `source ~/configs/.zfunc`

## Alacritty

1. `brew install alacritty`
1. vim ~/.alacritty.yml
1. Paste the lines `import:` and then `- ~/configs/alacritty.yml`

## Tmux

1. `brew install tmux`
1. vim `~/.tmux.conf`
1. Paste the line `source ~/configs/tmux.conf`
