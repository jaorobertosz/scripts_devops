#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
FILE="BKP_$SRV_$DATA.tgz"
CLIENTE='KIRRA'
BKPETH1='KIRRAETH1'
BKPETH2='KIRRAETH2'
USERZBX='suporteati'
BKPDIRUTR='/root/BACKUP/BKP_*'
BKPDIR='/USINAS/'$CLIENTE'/BACKUP/'
MSG1="SUCESSO NA COLETA DE BACKUP"
MSG2="FALHA AO GERAR BACKUP"
MSG3="BACKUP COLETADO E COPIADO PARA ATI COM SUCESSO"
MSG4="FALHA NA TRANSFERENCIA DO BACKUP PARA A ATI"
MSG5="ALTERAÇÃO DE PERMISSÃO REALIZADA"

# Remover o backup anterior
#if [ -e "$BKPDIR" ]; then
#  rm -f "$BKPDIR"*
#fi

#	BACKUP MATEUS-LEME_ETH1
	echo "Realizando BACKUP ETH1"

	sleep 5s
	scp -p -qo ConnectTimeout=3 "$BKPETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5" 
	
	sleep 5s
#	BACKUP MATHEUS-LEME_ETH2

	echo "Realizando BACKUP ETH2"

	sleep 5s
	scp -p -qo ConnectTimeout=3 "$BKPETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5" 
