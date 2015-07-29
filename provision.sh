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
    brew cask install charles
    brew cask install virtualbox
    brew cask install vagrant
    brew cask install utorrent
    brew cask install spotify

    # Set a nice vim config...
    cat assets/vim.cfg >> ~/.vimrc

    # Set a nice bash config
    cat assets/bashrc.cfg >> ~/.bashrc
}

function copy_settings(){
    cp ~/.vimrc ./assets/vim.cfg
    cp ~/.bashrc ./assets/bashrc.cfg
}

function usage(){
    printf "\n---------------------------------------------"
    printf "\nUSAGE:\n $0 (--copy-current | --write-settings)"
    printf "\n---------------------------------------------"
    printf "\n--copy-current     copies the current settings to the cfg files in /assets/*.cfg, for use in re-provisioning later."
    printf "\n--run              runs the provisioning script to set bashrc, vimrc and runs the installers set in provision.sh run()\n\n"
}

if [[ $EUID -ne 0 ]]
then
    echo "This provisioner requires root access."
    exit 1
    usage
fi

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
