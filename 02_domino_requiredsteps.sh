CopyDir=/tmp/domino101_prebackup
ProgramDir=/opt/domino/lotus
DataDir=/local/notesdata
NSF_IND=$DataDir/nsf_files.ind
NTF_IND=$DataDir/notesdata/ntf_files.ind

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

$ProgramDir/bin/design -f names.nsf
$ProgramDir/bin/design -f admin4.nsf
$ProgramDir/bin/design -f log.nsf
$ProgramDir/bin/design -f mail.box
$ProgramDir/bin/design -f ddm.nsf
$ProgramDir/bin/design -f events4.nsf
$ProgramDir/bin/design -f da.nsf
$ProgramDir/bin/design -f statrep.nsf
$ProgramDir/bin/design -f schema.nsf

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
