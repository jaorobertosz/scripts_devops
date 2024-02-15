#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
FILE="BKP_$SRV_$DATA.tgz"
BKPETH1='172.28.4.251'
BKPETH2='172.28.4.252'
BKPDIRUTR='/root/BACKUP/BKP_*'
BKPDIR='/USINAS/CARVALHO-ENERGIA/BACKUP/'
MSG1="SUCESSO NA COLETA DE BACKUP"
MSG2="FALHA AO GERAR BACKUP"
MSG3="BACKUP COLETADO E COPIADO PARA ATI COM SUCESSO"
MSG4="FALHA NA TRANSFERENCIA DO BACKUP PARA A ATI"

# Remover o backup anterior
if [ -e "$BKPDIR" ]; then
  rm -f "$BKPDIR"*
fi

#	BACKUP MATEUS-LEME_ETH1
	scp "$BKPETH1:$BKPDIRUTR" "$BKPDIR$FILE" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"

#	BACKUP MATHEUS-LEME_ETH2
	scp "$BKPETH2:$BKPDIRUTR" "$BKPDIR$FILE" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" 
