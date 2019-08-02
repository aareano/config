# This script installs the basics

# Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew is installed."
fi

which -s pip3
if [[ $? != 0 ]] ; then
    echo "Installing pip3."
    brew install pip3
else
    echo "pip3 is installed."
fi

which -s powerline-shell
if [[ $? != 0 ]] ; then
    echo "Installing powerline-shell."
    brew install powerline-shell
else
    echo "powerline-shell is installed."
fi

echo "Now copy over the different configs you want."
