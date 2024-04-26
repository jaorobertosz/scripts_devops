#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
CLIENTE='CARAPRETA'
FILE="BKP_$SRV_$DATA.tgz"
BKP_ETH1='SANTAMONICAETH1'
BKP_ETH2='SANTAMONICAETH2'
USERZBX='suporteati'
BKPDIRUTR=/root/BACKUP/BKP_*
BKPDIR=/USINAS/${CLIENTE}/BACKUP/
MSG1="SUCESSO NA COLETA DE BACKUP"
MSG2="FALHA AO GERAR BACKUP"
MSG3="BACKUP COLETADO E COPIADO PARA ATI COM SUCESSO"
MSG4="FALHA NA TRANSFERENCIA DO BACKUP PARA A ATI"
MSG5="ALTERAÇÃO DE PERMISSÃO REALIZADA"

# Remover o backup anterior
#if [ -e "$BKPDIR" ]; then
#  rm -f "$BKPDIR"*
#fi

#	BACKUP ETH1
	
	echo "Realizando BACKUP ETH1"
	sleep 5s
	scp "$BKP_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"


#	BACKUP ETH2

	echo "Realizando BACKUP ETH2"
	sleep 5s
	scp "$BKP_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"

