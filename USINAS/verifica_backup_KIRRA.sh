#!/bin/bash

CLIENTE="KIRRA" # Substitua "nome_do_cliente" pelo nome real do cliente
DIRETORIO="/USINAS/$CLIENTE/BACKUP/"

# Data atual
data_atual=$(date +%Y-%m-%d)

# Verifica se a data atual é uma segunda-feira
if [ $(date +%u) -eq 1 ]; then
    data_verificacao=$data_atual
else
    # Obtém a data da última segunda-feira
    data_verificacao=$(date -d "last Monday" +%Y-%m-%d)
fi

# Verifica se o diretório existe
if [ -d "$DIRETORIO" ]; then
    # Lista backups (tar.gz) modificados na segunda-feira atual
    backups=$(find "$DIRETORIO" -name "*.tgz" -newermt "$data_verificacao" ! -newermt "$data_verificacao +1 day" -exec stat --format="%n - %y" {} +)

    if [ -n "$backups" ]; then
        echo "Backups encontrados para o cliente $CLIENTE na segunda-feira ($data_verificacao):"
        echo "$backups"
    else
        echo "Nenhum backup encontrado para o cliente $CLIENTE na segunda-feira ($data_verificacao)."
    fi
else
    echo "O diretório $DIRETORIO não existe."
fi

