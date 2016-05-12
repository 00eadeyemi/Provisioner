function run(){
    # Hide desktop icons.
    defaults write com.apple.finder CreateDesktop -bool false && killall Finder

    # Install brew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install GIT. Should avoid any issues if a fresh install with no xcode-tools
    brew install caskroom/cask/brew-cask
    brew cask install git

    # Agree to xcode licenses otherwise /0 :s
    sudo xcodebuild -license

    # Set up brew tools.
    brew install wget
    brew install ruby
    brew install node

    # Install some stuff...
    brew cask install google-chrome
    brew cask install github-desktop
    brew cask install atom
    brew cask install charles
    brew cask install virtualbox
    brew cask install vagrant
    brew cask install utorrent
    brew cask install spotify
    brew cask install phpstorm

    # Set a nice vim config...
    cat assets/vim.cfg >> ~/.vimrc

    # Set a nice bash config
    cat assets/bash_profile.cfg >> ~/.bash_profile
}

function copy_settings(){
    cp ~/.vimrc ./assets/vim.cfg
    cp ~/.bash_profile ./assets/bash_profile.cfg
}

function usage(){
    printf "\n---------------------------------------------"
    printf "\nUSAGE:\n $0 (--copy-current | --write-settings)"
    printf "\n---------------------------------------------"
    printf "\n--copy-current     copies the current settings to the cfg files in /assets/*.cfg, for use in re-provisioning later."
    printf "\n--run              runs the provisioning script to set bash_profile, vimrc and runs the installers set in provision.sh run()\n\n"
}

if [ $# -eq 0 ]
    then
        usage  
fi

case $1 in
    "--copy-current" )
        copy_settings && echo "Done." ;;
    "--run" )
        run ;;
esac
