psdir()
{
	echo "\[\033[34m\]\W\[\033[0m\]"
}

psusrhost()
{
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
		echo -e "\[\033[31m\]\u@\h:\[\033[0m\]"
	else
		echo -e "\[\033[32m\]\u@\h:\[\033[0m\]"
	fi;
}

psnetns ()
{
	netns=`ip netns identify $$`
	if [ -n "$netns" ]; then
		echo -e "\[\033[31m\](${netns})\[\033[0m\]"
	fi
}

if [ -f "/usr/share/git/completion/git-prompt.sh" ]; then
	source "/usr/share/git/completion/git-prompt.sh"
fi

psbranch()
{
	echo -e "$(__git_ps1 "[%s]")"
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vimdiff='nvim -d'

export PS1="$(psusrhost)$(psnetns)$(psdir)\$(psbranch)\[$(tput sgr0)\]$ "

# set vim commands in gnome shell
set -o vi

# My script path
export PATH="$HOME/bin:$PATH"

# Work profile
if [ -s $HOME/.bash_work_profile ]; then
	source $HOME/.bash_work_profile
fi

. "$HOME/.cargo/env"
export PATH=$HOME/.nimble/bin:$PATH
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
