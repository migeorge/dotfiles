# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git ruby rails ember-cli rake bower npm sudo colored-man-pages emoji-clock)

# User configuration

DISABLE_AUTO_TITLE=true

source $ZSH/oh-my-zsh.sh

# Magical colors
[ -z "$TMUX" ] && export TERM=xterm-256color

export EDITOR=vim

NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"

unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

export PATH="$HOME/.composer/vendor/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Mac OS Specific config
if [[ `uname` == 'Darwin' ]]
then
  export ANDROID_HOME=/usr/local/opt/android-sdk
  export PATH=${PATH}:${ANDROID_HOME}/tools
  export PATH=${PATH}:${ANDROID_HOME}/platform-tools

  # alias to nw
  alias nw="/Applications/nwjs.app/Contents/MacOS/nwjs"

  # alias firefox with remote debugger
  alias firefox-debug="/Applications/FirefoxDeveloperEdition.app/Contents/MacOS/firefox -start-debugger-server"

  export PATH="$HOME/neovim/bin:$PATH"

  # emscripten
  if [ -d "$HOME/emsdk" ]; then
    export PATH="$PATH:$HOME/emsdk:$HOME/emsdk/clang/fastcomp/build_incoming_64/bin:$HOME/emsdk/node/4.1.1_64bit/bin:$HOME/emsdk/emscripten/incoming:$HOME/emsdk/binaryen/master"
  fi
fi

# Linux specific config
if [[ `uname` == 'Linux' ]]
then
  # Android SDK Linux (installed with android studio)
  export PATH=${PATH}:${HOME}/Android/Sdk/platform-tools:${HOME}/Android/Sdk/tools
fi

# nodenv goodness
export PATH="$HOME/.nodenv/bin:$PATH"
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi

# Use the following alias to create (or connect to a current) tmux session with
# the same name as the base of your current directory

function dmux {
  SESSION_NAME=${PWD##*/}

  tmux has-session -t $SESSION_NAME 2>/dev/null
  if [ $? -eq 1 ]
  then
    tmux new -s $SESSION_NAME
  fi

  tmux attach -t $SESSION_NAME
}
export PATH="/usr/local/sbin:$PATH"

function docker-time {
  command /Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh
}

alias vim=nvim
alias et="ember test"
alias ets="ember test --server"

if [[ -f $HOME/.bin/alias ]]
then
  source $HOME/.bin/alias
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Go env
export GOPATH=$HOME/projects/go
export PATH=$GOPATH/bin:$PATH

########## Helper Functions ##########

ember() {
  if [ -f $(npm bin)/ember ]; then
    echo "using node_modules ember-cli"
    $(npm bin)/ember $@
  elif [ -f $(nodenv which ember) ]; then
    echo "using nodenv shim ember-cli"
    $(nodenv which ember) $@
  fi
}

rails() {
  if [ -f $(pwd)/bin/rails ]; then
    echo "using binstub"
    $(pwd)/bin/rails $@
  elif [ -f $(pwd)/Gemfile ]; then
    echo "using bundle exec"
    bundle exec rails $@
  elif [ -f $(rbenv which rails) ]; then
    echo "using rails managed by rbenv"
    $(rbenv which rails) $@
  else
    echo "computer cannot into rails :("
  fi
}

guard() {
  if [ -f $(pwd)/bin/guard ]; then
    echo "using binstub"
    $(pwd)/bin/guard $@
  elif [ -f Gemfile ]; then
    echo "using bundle exec"
    bundle exec guard $@
  elif [ -f $(rbenv which guard) ]; then
    echo "using rbenv shim"
    $(rbenv which guard) $@
  else
    echo "computer cannot into guard :("
  fi
}

rake() {
  if [ -f $(pwd)/bin/rake ]; then
    echo "using binstub"
    $(pwd)/bin/$@
  elif [ -f Gemfile ]; then
    echo "using bundle exec"
    bundle exec rake $@
  elif [ -f $(rbenv which rake) ]; then
    echo "using rbenv shim"
    $(rbenv which rake) $@
  else
    echo "computer cannot into rake :("
  fi
}

rspec() {
  if [ -f $(pwd)/bin/rspec ]; then
    echo "using binstub"
    $(pwd)/bin/rspec $@
  elif [ -f Gemfile ]; then
    echo "using bundle exec"
    bundle exec rspec $@
  elif [ -f $(rbenv which rspec) ]; then
    echo "using rbenv shim"
    $(rbenv which rspec) $@
  else
    echo "computer cannot into rspec :("
  fi
}

eval $(thefuck --alias)

export PATH="$HOME/.yarn/bin:$PATH"

source $HOME/.secrets
