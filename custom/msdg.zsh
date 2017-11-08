function msdg-ssh {

    if [ $1 ]; then
        env=$1
    else
        env="dev"
    fi

    echo "ssh login for $env"

    readme=$(cat $(git rev-parse --show-toplevel 2> /dev/null)/README.md 2> /dev/null)
    if [ $readme = "" ]; then
        echo "not a proper msdg git repo"
        return 0
    fi

    host=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?host: (.+?)\n/si;')
    user=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    pass=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?password: (.+?)\n/si;')

    print -z 'sshpass -p "'$pass'" ssh -oStrictHostKeyChecking=no '$user@$host
}

function msdg-mysql {

    if [ $1 ]; then
        env=$1
    else
        env="dev"
    fi
    echo "mysql login for $env"

    readme=$(cat $(git rev-parse --show-toplevel 2> /dev/null)/README.md 2> /dev/null)
    if [ $readme = "" ]; then
        echo "not a proper msdg git repo"
        return 0
    fi

    host=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?host: (.+?)\n/si;')
    user=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    pass=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?password: (.+?)\n/si;')

    ddbb_user=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    ddbb_pass=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?password: (.+?)\n/si;')
    ddbb_name=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?database: (.+?)\n/si;')

    port=$(gshuf -i 3400-4000 -n 1)

    print -z 'sshpass -p "'$pass'" ssh '$user@$host \''mysql -u'$ddbb_user' -p"'"$ddbb_pass"\" $ddbb_name\'
}

function msdg-mysqldump {

    if [ $1 ]; then
        env=$1
    else
        env="dev"
    fi
    echo "mysql dump for $env"

    readme=$(cat $(git rev-parse --show-toplevel 2> /dev/null)/README.md 2> /dev/null)
    if [ $readme = "" ]; then
        echo "not a proper msdg git repo"
        return 0
    fi

    host=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?host: (.+?)\n/si;')
    user=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    pass=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?password: (.+?)\n/si;')

    ddbb_user=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    ddbb_pass=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?password: (.+?)\n/si;')
    ddbb_name=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?database: (.+?)\n/si;')

    port=$(gshuf -i 3400-4000 -n 1)

    print -z 'sshpass -p "'$pass'" ssh '$user@$host \''mysqldump -u'$ddbb_user' -p"'"$ddbb_pass"\" $ddbb_name\'
}

function msdg-rsync {

    if [ $1 ]; then
        command=$1
    else
        command="from"
    fi

    if [ $2 ]; then
        env=$2
    else
        env="dev"
    fi

    echo "rsync for $env"

    readme=$(cat $(git rev-parse --show-toplevel 2> /dev/null)/README.md 2> /dev/null)
    if [ ${readme} = "" ]; then
        echo "not a proper msdg git repo"
        return 0
    fi

    host=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?host: (.+?)\n/si;')
    user=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    pass=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?password: (.+?)\n/si;')

    if [ ${command} = 'from' ]; then
        print -z 'sshpass -p "'$pass'" rsync -e "ssh -o StrictHostKeyChecking=no" -avz '$user@$host':httpdocs/ .'
    else
        print -z 'sshpass -p "'$pass'" rsync -e "ssh -o StrictHostKeyChecking=no" -avz . '$user@$host':httpdocs/'
    fi
}
