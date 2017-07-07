#!/usr/bin/env bash

if [ $# -eq 1 ] ; then
    fileName="${1}"

    tree=$(pstree -p | grep $$)
    n=$(echo ${tree} | awk -F'-[-+]-' '{ print NF }')
    tokens=($(echo "$tree" | awk -F'-[-+]-' '{
        for(i = 1; i <= NF; i++ ) {
            print $i
        }
    }'))
    pid=-1
    for token in ${tokens[@]} ; do
        #echo ${token}
        if [[ "${token}" =~ (.+)konsole\([0-9]*\) ]]; then
            pid=($(echo "$token" | sed '/konsole/s/[-+|]//g' | 
                sed '/konsole(/s/konsole(//' |
                sed '/)/s/)//')) 
            break
        fi
    done

    if [ $pid -gt -1 ] ; then
        qdbus org.kde.konsole-${pid} $KONSOLE_DBUS_SESSION setTabTitleFormat 1 ""
        qdbus org.kde.konsole-${pid} $KONSOLE_DBUS_SESSION setTitle 1 "nvim - ${fileName}"
    fi
fi
