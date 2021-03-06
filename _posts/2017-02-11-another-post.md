---
title: This is another post
updated: 2017-04-09 23:00
tags: [other, liquid, terminal, more, stuff, download]
description: How to use markdown and liquid to render images belonging to a post.
---

Hello again!

You can use markdown as well as liquid to render local images. The preferred
method in this case is to use liquid so that all "good" CSS rules get applied.

![ter]({{ site.baseurl }}/media/2017-02-11-another-post/terminal.png)

{% include image.html file="terminal.png" alt="example" caption="An example caption. This caption is very long so that we can check for possible overflows..." %}

Some other text below the caption. Is this rendered fine?

{% include image.html file="terminal.png" alt="ter" %}

This is the liquid tag for the last case:

```liquid
{% raw %}
{% include image.html file="terminal.png" alt="example" caption="An example caption. This caption is very long so that we can check for possible overflows..." %}
{% endraw %}
```

`This is some text in <code> tags,` while this is some adjacent normal text.

This is the source code of [QVM](https://raw.githubusercontent.com/frnmst/qvm/master/qvm)

```
#!/usr/bin/env sh

# qvm - Trivial management of 64 bit virtual machines with qemu.
#
# Written in 2016 by Franco Masotti/frnmst <franco.masotti@student.unife.it>
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the public
# domain worldwide. This software is distributed without any warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.

program_name="$0"
local_path="${program_name%/qvm}"

help()
{
    cat <<-EOF
Usage: qvm [OPTION]
Trivial management of 64 bit virtual machines with qemu.

Options:
    -a, --attach                connect to SSH locally
        --attach-remote         connect to SSH remotely
    -b, --backup                backup vhd
    -c, --create                create new vhd
    -d, --delete                delete vhd backup
        --delete-orig           delete original vhd
    -h, --help                  print this help
    -i, --install               install img on vhd
        --install-vnc           install img on vhd via vnc
    -n, --run-nox               run vm without opening a graphical window
                                (useful for background jobs like SSH)
        --run-nox-orig          run-orig and run-nox combined
    -s, --mkdir-shared          create shared directory
    -r, --remote                connect to a vnc instance via ssh
    -x, --run                   run vm
        --run-vnc               run vm with vnc
        --run-orig              run from original vhd
        --run-orig-vnc          run from original vhd with vnc


Only a single option is accepted.
By default, the backup vhd is run.

CC0
Written in 2016 by Franco Masotti/frnmst <franco.masotti@student.unife.it>
EOF
}

unrecognized_option()
{
    printf "%s\n" "Try 'qvm --help' for more information"
} 1>&2-

attach()
{
    local argc="$1"
    local address=""

    if [ "$argc" = "locally" ]; then
        address="127.0.0.1"
    elif [ "$argc" = "remotely" ]; then
        address="$host_ip_address"
    fi

    ssh -p "$ssh_host_port" -l "$ssh_guest_username" "$address"
}

backup()
{
    qemu-img create -f "$vhd_type" \
-b "$vhd_name" \
"$vhd_name".mod
}

create()
{
    qemu-img create -f "$vhd_type" \
"$vhd_name" \
"$vhd_size"
}

delete()
{
    local argc="$1"
    local vhd=""

    if [ "$argc" = "orig" ]; then
        vhd="$vhd_name"
    else
        vhd=""$vhd_name".mod"
    fi

    rm "$vhd"
}

installs()
{
    local argc1="$1"
    local enable_vnc=""

    if [ "$argc1" = "vnc" ]; then
        enable_vnc="-monitor pty -vnc 127.0.0.1:0"
    fi

    qemu-system-x86_64 -m "$vm_memory" \
-device e1000,netdev=user.0 \
-netdev user,\
id=user.0,hostfwd=tcp::"$ssh_host_port"-:"$ssh_guest_port" \
-enable-kvm \
$enable_vnc \
-cdrom "$img_name" \
-boot order=d \
"$vhd_name" &
}

shared()
{
    mkdir -p "$shared_data_path"
}

run()
{
    local argc1="$1"
    local argc2="$2"
    local vhd=""
    local display=""
    local enable_vnc=""

    if [ "$argc1" = "none" ]; then
        display="none"
    elif [ "$argc1" = "gtk" ]; then
        display="gtk"
    elif [ "$argc1" = "vnc" ]; then
        display="none"
        enable_vnc="-monitor pty -vnc 127.0.0.1:0"
    fi

    if [ "$argc2" = "orig" ]; then
        vhd="$vhd_name"
    else
        vhd=""$vhd_name".mod"
    fi

    export QEMU_AUDIO_DRV=alsa

    qemu-system-x86_64 \
-m "$vm_memory" \
-enable-kvm \
$enable_vnc \
-device e1000,netdev=user.0 \
-netdev user,\
id=user.0,hostfwd=tcp::"$host_port"-:"$guest_port",\
hostfwd=tcp::"$ssh_host_port"-:"$ssh_guest_port" \
-virtfs local,path="$shared_data_path",\
security_model=none,mount_tag="$mount_tag" \
-soundhw ac97 \
-display "$display" \
-drive file="$vhd" &
}

remote()
{
    ssh -N -f -L 5901:127.0.0.1:5900 "$host_username"@"$host_ip_address"
    vncviewer 127.0.0.1:1
}

main()
{
    local argc="$1"
    local options="abcdhinrx"
    local long_options="attach,backup,create,delete,delete-orig,\
help,install,run,run-orig,run-nox,run-nox-orig,run-vnc,run-orig-vnc,remote,install-vnc,\
attach-remote"
    local opts
    local opt

    [ -z "$argc" ] && argc="-x"

    opts="$(getopt --options $options --longoptions $long_options -- $argc)"

    [ $? -ne 0 ] && unrecognized_option && return 1

    eval set -- "$opts"

    # Source variables globally.
    . "${local_path}"/configvmrc

    for opt in $opts; do
        case "$opt" in
            -- )                                        ;;
            -a | --attach )             attach locally  ;;
                 --attach-remote )      attach remotely ;;
            -b | --backup )             backup          ;;
            -c | --create )             create          ;;
            -d | --delete )             delete          ;;
                 --delete-orig )        delete orig     ;;
            -h | --help )               help            ;;
            -i | --install )            installs        ;;
                 --install-vnc )        installs vnc    ;;
            -n | --run-nox )            run none        ;;
                 --run-nox-orig )       run none orig   ;;
            -r | --remote )             remote          ;;
            -s | --mkdir-shared )       shared          ;;
            -x | --run )                run gtk         ;;
                 --run-orig )           run gtk orig    ;;
                 --run-vnc )            run vnc         ;;
                 --run-orig-vnc )       run vnc orig    ;;

        esac
    done
}

main "$*"
```
