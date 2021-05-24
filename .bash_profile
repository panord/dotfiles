__netns ()
{
	netns=`ip netns identify $$`
	if [ -n "$netns" ]; then
		echo "[ns::$netns]";
	fi
}

__branch_name ()
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

export PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[35m\]$(__netns)$(__branch_name)\[\033[0m\]\$ '

# set vim commands in gnome shell
set -o vi

# My script path
export PATH="$HOME/bin:$PATH"

# Work profile
if [ -s $HOME/.bash_work_profile ]; then
	source $HOME/.bash_work_profile
fi
