#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
CLIENTE='CARVALHO-ENERGIAS'
FILE="BKP_$SRV_$DATA.tgz"
BKPML_ETH1='MATEUSLEME-CARVALHO-ETH1'
BKPML_ETH2='MATEUSLEME-CARVALHO-ETH2'
BKPJEQT_ETH1='JEQUITIBA-CARVALHO-ETH1'
BKPJEQT_ETH2='JEQUITIBA-CARVALHO-ETH2'
USERZBX='suporteati'
BKPDIRUTR='/root/BACKUP/BKP_*'
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
	
	sleep 5s
	scp "$BKPML_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"

	sleep 5s
       scp "$BKPJEQT_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"	

#	BACKUP ETH2

	sleep 5s
	scp "$BKPML_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"

	sleep 5s	
	scp "$BKPJEQT_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"

