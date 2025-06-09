#!/bin/bash

if [ -z $(id -u notes 2>/dev/null) ]; then
   groupadd notes
   useradd notes -g notes -m
fi

if [ ! -e "/local" ]; then
    mkdir -p "/local"
    chown notes:notes /local
    chmod 777 /local
fi

if [ ! -e "/local/notesdata" ]; then
    mkdir -p /local/notesdata
    chown notes:notes /local/notesdata
    chmod 770 /local/notesdata
fi

if [ ! -e "/local/dl" ]; then
    mkdir -p "/local/dl"
    chown notes:notes /local/dl
    chmod 777 /local/dl
fi

if [ ! -e "/local/translog" ]; then
    mkdir -p /local/translog
    chown notes:notes /local/translog
    chmod 770 /local/translog
fi

if [ ! -e "/local/daos" ]; then
    mkdir -p /local/daos
    chown notes:notes /local/daos
    chmod 770 /local/daos
fi

if [ ! -e "/local/ft" ]; then
    mkdir -p /local/ft
    chown notes:notes /local/ft
    chmod 770 /local/ft
fi

if [ ! -e "/local/nif" ]; then
    mkdir -p /local/nif
    chown notes:notes /local/nif
    chmod 770 /local/nif
fi

if [ ! -e "/local/backup" ]; then
    mkdir -p /local/backup
    chown notes:notes /local/backup
    chmod 770 /local/backup
fi