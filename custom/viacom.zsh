function bastion () {
	if [[ -n $(tmux list-sessions 2>&1 | awk '{print $1}' | grep ^bastion:$) ]]
	then
		_zsh_tmux_plugin_run kill-session -t bastion
		echo 'killed previous session'
	fi
	_zsh_tmux_plugin_run new-session -d -s bastion
	_zsh_tmux_plugin_run send-keys -t bastion 'ssh araujor@bh.811.mtvi.com' C-m
	sleep 3
	_zsh_tmux_plugin_run send-keys -t bastion "$(security find-generic-password -wa ldap_password)" C-m
	sleep 1
	_zsh_tmux_plugin_run send-keys -t bastion "1" C-m
}

function initaws () {
    if [ ! $1 ]; then
        (>&2 echo "specify a host")
        return;
    fi

    host=$1

    ssh-copy-id -i ~/.ssh/araujor_rsa $host
    rsync -avz ~/Dropbox/.server_boilerplate/ araujor@$host:~
}

function getips () {
    if [ -z "$@" ]; then
        list=`cat ~/domains`
    else
        list="$@"
    fi

    ips=""
    for domain in `echo $list`; do
        for ip in `dig +short $domain | egrep '^\d'`; do
            ips="$ips\n$ip"
        done
    done

    echo $ips | sort | uniq | tr '\n' ' '
}
