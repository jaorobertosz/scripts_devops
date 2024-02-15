#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
FILE=BKP_"$SRV"_"$DATA".tgz
MSG1="SUCESSO GERACAO DO BACKUP $FILE"
MSG2="FALHA AO GERAR BACKUP"
MSG3="BACKUP $FILE GERADO E COPIADO PARA ATI COM SUCESSO"
MSG4="FALHA NA TRANSFERENCIA DO BACKUP PARA A ATI"
BKPDIR="/root/BACKUP/"

# Remover o backup anterior
if [ -e "$BKPDIR" ]; then
  rm -f "$BKPDIR"*
fi

# Gera arquivo de backup compactado
tar --exclude='*.*~' --exclude='*.tgz' --exclude='*.log' -czf "$BKPDIR$FILE" /etc/network/interfaces /etc/hosts /etc/resolv.conf /etc/zabbix /ATI/sgd >/dev/null 2>&1 && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG1" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG2"

