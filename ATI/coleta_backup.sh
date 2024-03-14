#!/bin/bash

#	SCRIPT PARA COLETA DE BACKUPS DOS CLIENTES

BKPDIR='/scripts_devops/BACKUPS/'


cd $BKPDIR 

echo "Executando Backup"
sleep 5s
echo "BACKUP CARVALHO-ENERGIAS"
./script_CARVALHO-ENERGIAS.sh

sleep 5s
echo "BACKUP ENERSIDE"
./script_ENERSIDE.sh

sleep 5s
echo "BACKUP KIRRA"
./script_KIRRA.sh

sleep 5s
echo "BACKUP E1ENERGIAS"
./script_E1ENERGIAS.sh

sleep 5s
echo "BACKUP TRINITY"
./script_TRINITY.sh
