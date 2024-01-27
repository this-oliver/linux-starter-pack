# capture theme name in first argument
theme=$1

echo "installing oh-my-zsh..."

# update
sudo apt update

# install zsh
sudo apt install zsh

# make zsh default shell
chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# if theme is provided, set theme
if [ "$theme" != "" ]; then
    sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"$theme\"/g" ~/.zshrc
fi

echo "Oh-my-zsh installed successfully (restart terminal to see changes)"