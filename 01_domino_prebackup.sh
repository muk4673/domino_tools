#!/bin/sh

CopyDir=/tmp/domino101_prebackup
ProgramDir=/opt/ibm/domino/
DataDir=/notesdata

echo "***"
echo "Sicherung der systemnahen Datenbanken startet"
echo "***"
echo ""

mkdir $CopyDir

cp $DataDir/*.ntf $CopyDir/
cp $DataDir/*.id $CopyDir/
cp $DataDir/*.sid $CopyDir/
cp $DataDir/admin4.nsf $CopyDir/
cp $DataDir/bookmark.nsf $CopyDir/
cp $DataDir/busytime.nsf $CopyDir/
cp $DataDir/catalog.nsf $CopyDir/
cp $DataDir/certlog.nsf $CopyDir/
cp $DataDir/cldbdir.nsf $CopyDir/
cp $DataDir/clubusy.nsf $CopyDir/
cp $DataDir/da.nsf $CopyDir/
cp $DataDir/ddm.nsf $CopyDir/
cp $DataDir/domcfg.nsf $CopyDir/
cp $DataDir/events4.nsf $CopyDir/
cp $DataDir/homepage.nsf $CopyDir/
cp $DataDir/inetlockout.nsf $CopyDir/
cp $DataDir/mail.box $CopyDir/
cp $DataDir/names.nsf $CopyDir/
cp $DataDir/ressourcen.nsf $CopyDir/
cp $DataDir/schema.nsf $CopyDir/
cp $DataDir/webadmin.nsf $CopyDir/

echo "***"
echo "Sicherung der systemnahen Datenbanken abgeschlossen"
echo "***"
