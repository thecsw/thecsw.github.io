#!/bin/sh

setup_color() {
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    BOLD=$(printf '\033[1m')
    RESET=$(printf '\033[m')
}

show_message() {
    printf "$1"
    printf "$2\n"
    printf "$RESET"
}

step() {
    show_message $BOLD$GREEN "$1"
}

error() {
    show_message $BOLD$RED $1
}

setup_go_tools() {
    if ! command -v go &> /dev/null
    then
	error " ! golang installation not found, skipping..."
	exit
    fi
    go get -u golang.org/x/tools/...
}

main() {
    setup_color

    printf "$YELLOW"
    cat <<-'EOF'
    _____      	       	  __   	 _
		   / ___/____ _____  ____/ /_  _( )_____
		   \__ \/ __ `/	__ \/ __  / / /	/// ___/
		  ___/ / /_/ / / / / /_/ / /_/ / (__  )
		 /____/\__,_/_/	/_/\__,_/\__, /	/____/
		       	       	       	/____/
		       	       	       	       	       	  __
		     ___  ____ ___  ____ ___________ ____/ /
		    / _	\/ __ `__ \/ __	`/ ___/	___// __  /
		  _/  __/ / / /	/ / /_/	/ /__(__  )/ /_/ /
		 (_)___/_/ /_/ /_/\__,_/\___/____(_)__,_/


		 Welcome to Sandy's .emacs.d !
		 
		 What will happen now, I will download Sandy's .emacs.d and
		 setup the initial configuration for you. If you have some
		 commands installed, like golang, an attempt to install go tools
		 will be made

		 Sit back and relax


	EOF
    printf "$RESET"

    step " - Cloning .emacs.d ..."
    git clone https://github.com/thecsw/.emacs.d

    step " - Symlink .emacs ..."
    ln -s .emacs.d/.emacs .emacs

    step " - Setting up golang X tools (takes about a minute) ..."
    setup_go_tools
}

main
