#!/bin/bash

VERS=$1

CopyDir=/local/backup/$VERS
ProgramDir=/opt/hcl/domino
DataDir=/local/notesdata
NSF_IND=/local/backup/nsf_files.ind
NTF_IND=/local/backup/ntf_files.ind

NOTES_DESIGN_FILES="names.nsf admin4.nsf log.nsf mail.box ddm.nsf events4.nsf da.nsf statrep.nsf schema.nsf"

CurrentUser=$(whoami)

if [ $CurrentUser != 'notes' ]
then
        echo "Please run this script with User 'notes'"
        exit 0
fi

echo "***"
echo "Systemtechnisch erforderliche Arbeiten starten"
echo "***"

cd $DataDir


for db in $NOTES_DESIGN_FILES
do
    if [ -e "$db" ]; then
        $ProgramDir/bin/design -f $db
    fi
done

sleep 30

$ProgramDir/bin/fixup names.nsf -f -j -v -l
$ProgramDir/bin/fixup admin4.nsf -f -j -v -l
sleep 1m

if [ -f "$NSF_IND" ];
then
   rm $NSF_IND
fi
ls *.nsf > $NSF_IND
$ProgramDir/bin/compact $NSF_IND -ODS

sleep 15


if [ -f "$NTF_IND" ];
then
   rm $NTF_IND
fi
ls *.ntf > $NTF_IND
$ProgramDir/bin/compact $NTF_IND -ODS

sleep 30

$ProgramDir/bin/updall names.nsf -RX
$ProgramDir/bin/updall admin4.nsf -RX
$ProgramDir/bin/updall schema.nsf -RX

echo "***"
echo "Systemtechnisch erforderliche Arbeiten abgeschlossen"
echo "***"
