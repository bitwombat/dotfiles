#echo "Hello from local bashrc"

alias momvnc="ssh margaret@moms -f /home/margaret/bin/vnc ; sleep 2 ; xtightvncviewer -encodings tight -compresslevel 9 -quality 1 -depth 8 :1 < /dev/null"
alias dadvnc="ssh chris@dads -f /home/chris/bin/vnc ; sleep 2 ; xtightvncviewer -encodings tight -compresslevel 9 -quality 1 :3 < /dev/null"
alias jillvnc="ssh jbell@jills -f /home/jbell/bin/vnc ; sleep 2 ; xtightvncviewer -encodings tight -compresslevel 9 -quality 1 :1 < /dev/null"
alias ufvnc="vncviewer localhost::5500"
alias macvnc="xtightvncviewer mac:0"

alias truecrypt="truecrypt -t"

alias vless='vim -u /usr/share/vim/vimcurrent/macros/less.vim'

alias o="xdg-open"

export BASH_ENV=$HOME/.bashrc
export USERNAME=""

# Higher priority paths
export PATH=/home/gbell2/bin:/opt/bin:$PATH

# Lower priority paths
export PATH=$PATH:/bin:/root/bin:/usr/local/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin

function scr() {
    if [ $1 ]; then
        screen -c $1
    else
        scr_files=$(ls -1 *.scr 2>/dev/null )
        scr_count=$(echo $scr_files | wc -w)
        if [ $scr_count -gt 1 ]; then
            echo "More than 1 .scr file to choose from.  That's too many. " $scr_files
        elif [ $scr_count -eq 0 ]; then
            echo "I see no .scr files"
        else
            screen -c $scr_files
        fi
    fi
}

function go_camera() {
  cd /pics
  last_dir=$(ls -lvd camera/20* | sed -s 's/camera.*\///' | cut -c 48- | sort | tail -1)
  last_dir_lineno=$(ls -ld camera/20* | grep -Tn $last_dir | cut -f 1 | sed -e 's/ *//g')
  last=$(ls -ld camera/20* | sed -n ${last_dir_lineno}p | cut -c 47-)
  cd $last
}

function cdwp() {
    [ -e public_html ] && cd public_html
}

function cdwpu() {
    [ -e public_html ] && cd public_html
    cd wp-content/uploads
}

function cdwpt() {
    [ -e public_html ] && cd public_html
    cd wp-content/themes
    project=$(pwd | awk -F'/' '{print $(NF-3)}')
    if [ -e $project ]; then
        cd $project
    fi
    ls -l
}

function cdwpp() {
    [ -e public_html ] && cd public_html
    cd wp-content/plugins
    ls -l
}

alias plocate="locate -d /var/lib/locate/personal.db"

export COURSERA_EMAIL=gbell_spamless@yahoo.com
export COURSERA_PASS=E3au4jUmKm

alias aud="audacious"

alias term_purple='term purple'
alias term_green='term green'
alias term_red='term red'
alias term_teal='term teal'
alias term_grey='term grey'
alias term_blue='term blue'

alias ssh='term_teal; ssh'
alias su='term root ; su'

alias cde='cd /1_EIT/0_units/'
