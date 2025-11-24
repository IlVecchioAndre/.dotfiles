# .bashrc
PS1="\[\e[96m\]  \w\n\[\e[0m\]      >  "
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/bin:$PATH"
alias ls='ls --color=auto'

colorhex(){
    hex="${1#'#'}"
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    printf "\e[48;2;%d;%d;%dm HEX \e[0m\n" "$r" "$g" "$b" "$1"
}

alias ..='cd ..'
alias install='sudo dnf install'
#--logo-padding 7
fastfetch --logo-color-1 "#900000" --color-title reset_blue --logo-padding-right 8 --logo-padding-left 6

alias bau='cat ~/.config/sigjackcolori.txt'
alias rm='rm -i'
alias vim='vimx'
alias vimtex='vimx --servername VIM'
