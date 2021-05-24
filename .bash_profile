psdir()
{
	echo "\e[34m\w\e[0m"
}

psusrhost()
{
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
		echo -e "\e[31m\u@\h:\e[0m"
	else
		echo -e "\e[32m\u@\h:\e[0m"
	fi;
}

psnetns ()
{
	netns=`ip netns identify $$`
	if [ -n "$netns" ]; then
		echo "[ns::$netns]";
	fi
}

psbranch()
{
	branch=`git branch 2>/dev/null |grep \* |sed 's/\* \(.\+\)/\1/'`
	if [ -n "$branch" ]; then
		echo "[$branch]";
	fi
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export PS1="$(psusrhost)$(psdir)$(psnetns)$(psbranch)\[$(tput sgr0)\]$ "

# set vim commands in gnome shell
set -o vi

# My script path
export PATH="$HOME/bin:$PATH"

# Work profile
if [ -s $HOME/.bash_work_profile ]; then
	source $HOME/.bash_work_profile
fi
