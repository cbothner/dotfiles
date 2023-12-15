#! /bin/zsh

cd "${0%/*}"

touch ~/setup-in-progress

# Link dotfiles
#
echo
echo Linking dotfiles
echo ----------------
echo

for dotfile in src/**/*; do
	destination=~/.${dotfile:4} # Remove src/ and prepend ~/.

	if [ -d "$dotfile" ] && [ ! -d "$destination" ]; then
		mkdir $destination
	fi

	if [ -f "$dotfile" ]; then
		echo "--- $dotfile -> $destination"
		ln -sf ${dotfile:P} "$destination"
	fi
done

# Install dependencies
#
echo
echo Installing dependencies
echo -----------------------
echo

if command -v apt-get &> /dev/null; then
  sudo apt-get update
fi

if [[ uname -eq "Darwin" ]] && ! command -v brew &> /dev/null; then
  # Install homebrew
  echo --- Installing homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
fi

function install {
  if ! command -v name &> /dev/null; then
    if command -v apt-get &> /dev/null; then
      sudo apt-get install -y $1
    elif command -v brew &> /dev/null; then
      brew install $1
    fi
  fi
  echo "--- $1 installed"
}

# Prezto (https://github.com/sorin-ionescu/prezto)
if [ ! -d "$HOME/.zprezto" ]; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi
echo --- Prezto installed
echo

# LS_COLORS (https://github.com/trapd00r/LS_COLORS)
curl -so ~/.LS_COLORS https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS
echo --- LS_COLORS definitions downloaded
if command -v brew &> /dev/null; then
  brew install coreutils
  echo --- coreutils installed
fi
echo

install bat

# bat uses a different name on Ubuntu
if [ -f /usr/bin/batcat ]; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
fi

install hub

# Neovim
if command -v apt-get &> /dev/null; then
  # Uninstall any old version of neovim which was installed from the wrong
  # repository
  if command -v nvim &> /dev/null; then
    if [[ $(nvim -v | grep -oP "(?<=NVIM v)\d+\.\d+") -lt 0.7 ]]; then
      sudo apt-get remove -y neovim neovim-runtime
    fi
  fi

  # Add the unstable repository so we can get the newest version with that lsp
  # goodness
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt-get update
fi
install neovim

# Configure nvim. Do this after all the other apt-get users because it holds the
# dpkg lock beyond the lifespa of the command
curl -fLso ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall
echo --- neovim configured
echo

install rg

if [[ $SPIN ]]; then
  git config --global user.email "cameron.bothner@shopify.com"
  git config --global user.name "Cameron Bothner"
  git config --global --unset-all credential.helper
fi

rm -f ~/setup-in-progress
