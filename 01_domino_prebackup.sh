#!/bin/bash

VERS=$1

NOTES_ADMIN_FILES="admin4.nsf catalog.nsf certlog.nsf ddm.nsf events4.nsf inetlockout.nsf names.nsf ressourcen.nsf webadmin.nsf"

NOTES_CONFIG_FILES="bookmark.nsf busytime.nsf cldbusy.nsf da.nsf domcfg.nsf homepage.nsf schema.nsf"

NOTES_MAIL_FILES="mail.box mail1.box mail2.box mail3.box"

if [ ! -e "/local/backup" ]; then
    mkdir -p /local/backup
    chown notes:notes /local/backup
    chmod 770 /local/backup
fi

CopyDir=/local/backup/$VERS
ProgramDir=/opt/ibm/domino/
DataDir=/local/notesdata

mkdir -p $CopyDir
chown notes:notes $CopyDir
chmod 770 $CopyDir

echo "***"
echo "Sicherung der systemnahen Datenbanken startet"
echo "***"
echo ""

cp $DataDir/*.ntf $CopyDir/
cp $DataDir/*.id $CopyDir/
cp $DataDir/*.sid $CopyDir/

for db in $NOTES_ADMIN_FILES
do
    if [ -e $DataDir/"$db" ]; then
        cp $DataDir/"$db" $CopyDir/
    fi
done

for db in $NOTES_CONFIG_FILES
do
    if [ -e $DataDir/"$db" ]; then
        cp $DataDir/"$db" $CopyDir/
    fi
done

for db in $NOTES_MAIL_FILES
do
    if [ -e $DataDir/"$db" ]; then
        cp $DataDir/"$db" $CopyDir/
    fi
done

echo "***"
echo "Sicherung der systemnahen Datenbanken abgeschlossen"
echo "***"
