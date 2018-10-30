clear;
echo "-- Make sure you are running this from the repo path --\n";
echo "This script will install config files for the following:";
echo "-> neovim";
echo "-> tmux";
echo "-> zsh\n";
echo "These configs have the following expectations:";
echo "-> neovim is installed";
echo "-> tmux is installed";
echo "-> zsh and ohmyzsh is installed\n";
read -p "This will destroy and replace your config files, continue? [Y/n]" -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Remove existing config files
  rm -rf ~/.config/nvim
  rm -rf ~/.tmux.conf
  rm -rf ~/.zshrc

  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  mkdir -p ~/.config/nvim/_backup
  mkdir -p ~/.config/nvim/_temp

  # Symlink configs from this repo

  ln -s ${PWD}/.config/nvim/init.vim ~/.config/nvim/init.vim
  ln -s ${PWD}/.config/nvim/ftdetect/ ~/.config/nvim/ftdetect
  ln -s ${PWD}/shell/.zshrc ~/.zshrc
  ln -s ${PWD}/shell/.tmux.conf ~/.tmux.conf
fi
