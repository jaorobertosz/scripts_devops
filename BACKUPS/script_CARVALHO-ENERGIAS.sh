#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
CLIENTE='CARVALHO-ENERGIAS'
FILE="BKP_$SRV_$DATA.tgz"
<<<<<<< HEAD
BKPML_ETH1='172.28.4.251'
BKPML_ETH2='172.28.4.252'
BKPJEQT_ETH1='172.31.200.27'
BKPJEQT_ETH2='172.31.200.28'
USERZBX='suporteati'
BKPDIRUTR='/root/BACKUP/BKP_*'
BKPDIR=/USINAS/${CLIENTE}/BACKUP/
=======
>>>>>>> a347ff54d5ab2bc676416cd4e7180acdfb8a240c
CLIENTE="CARVALHO-ENERGIAS"
BKPETH1='172.28.4.251'
BKPETH2='172.28.4.252'
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
<<<<<<< HEAD

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
=======
>>>>>>> aab58864b61a8b5ec09ca092205b51080868beba

#	BACKUP MATEUS-LEME_ETH1
	echo "Realizando BACKUP ETH1"

	sleep 5s
	scp -p -qo ConnectTimeout=3 "$BKPETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5" 

#	BACKUP MATHEUS-LEME_ETH2
	echo "Realizando BACKUP ETH2"

	sleep 5s
	scp -p -qo ConnectTimeout=3 "$BKPETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" 
