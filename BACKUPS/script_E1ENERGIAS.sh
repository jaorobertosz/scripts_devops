#!/bin/bash

SRV=$(hostname)
DATA=$(date +%d%m%Y%H%M)
FILE="BKP_$SRV_$DATA.tgz"
CLIENTE='E1ENERGIAS'
BKPCHP01_ETH1='CACHOEIRA240ETH1'
BKPCHP01_ETH2='CACHOEIRA240ETH2'
BKPCHP02_ETH1='CACHOEIRA300ETH1'
BKPCHP02_ETH2='CACHOEIRA300ETH2'
BKPCHP03_ETH1='CACHOEIRA600ETH1'
BKPCHP03_ETH2='CACHOEIRA600ETH2'
BKPPRE01_ETH1='PORTOREALETH1'
BKPPRE01_ETH2='PORTOREALETH2'
BKPVAL0_ETH1='VALECAETH1'
BKPVAL0_ETH2='VALECAETH2'
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

#	BACKUP ETH1
	echo "Realizando BACKUP ETH1"

	sleep 5s

	scp -p -qo ConnectTimeout=3 "$BKPCHP01_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"
        
	sleep 5s

	scp -p -qo ConnectTimeout=3 "$BKPCHP02_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"
	
	sleep 5s

	scp -p -qo ConnectTimeout=3 "$BKPCHP03_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"

	sleep 5s

	scp -p -qo ConnectTimeout=3 "$BKPPRE01_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"

	sleep 5s
	
	scp -p -qo ConnectTimeout=3 "$BKPVAL0_ETH1:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4" && chown "$USERZBX". "$BKPDIR" -R && echo "$DATA - $MSG5"


#	BACKUP ETH2
	
	echo "Realizando BACKUP ETH2"

	sleep 5s

	scp -p -qo ConnectTimeout=3 "$BKPCHP01_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"

	sleep 5s
       
	scp -p -qo ConnectTimeout=3 "$BKPCHP02_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"
       
	sleep 5s

        scp -p -qo ConnectTimeout=3 "$BKPCHP03_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"

	sleep 5s

        scp -p -qo ConnectTimeout=3 "$BKPVAL0_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"
    
	sleep 5s

	scp -p -qo ConnectTimeout=3 "$BKPCHP03_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"

	sleep 5s

    scp -p -qo ConnectTimeout=3 "$BKPVAL0_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"

    	sleep 5s

    scp -p -qo ConnectTimeout=3 "$BKPPRE01_ETH2:$BKPDIRUTR" "$BKPDIR" && echo "$(date +%d%m%Y%H%M) - $MSG1" && echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG3" || echo "$(date +%d/%m/%Y-%H:%M:%S) - $MSG4"
