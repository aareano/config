# This script installs the basics

# Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew is installed."
fi

which -s pip3
if [[ $? != 0 ]] ; then
    echo "Installing pip3..."
    brew install pip3
else
    echo "pip3 is installed."
fi

which -s powerline-shell
if [[ $? != 0 ]] ; then
    echo "Installing powerline-shell..."
    brew install powerline-shell
else
    echo "powerline-shell is installed."
fi

if [ -f ~/.git-completion ]; then
    echo "~/.git-completion exists"
else
    echo "Setting up git auto-completion..."
    curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > ~/.git-completion
fi

echo "Now copy over the different configs you want from the folders in this repo."
