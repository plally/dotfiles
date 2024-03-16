export DOT=$HOME/dotfiles

stow -v -t ~/.config config
stow -v -t ~ home

touch ~/.gitconfig.local


