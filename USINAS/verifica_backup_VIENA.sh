#!/bin/bash

CLIENTE="VIENA" # Substitua "nome_do_cliente" pelo nome real do cliente
DIRETORIO="/USINAS/$CLIENTE/BACKUP/"

# Obtém a data da última segunda-feira
data_segunda=$(date -d "last Monday" +%Y-%m-%d)

# Verifica se o diretório existe
if [ -d "$DIRETORIO" ]; then
    # Lista backups (tar.gz) modificados na última segunda-feira
    backups=$(find "$DIRETORIO" -name "*.tar.gz" -newermt "$data_segunda" ! -newermt "$data_segunda +1 week" -exec stat --format="%n - %y" {} +)

    if [ -n "$backups" ]; then
        echo "Backups encontrados para o cliente $CLIENTE na última segunda-feira ($data_segunda):"
        echo "$backups"
    else
        echo "Nenhum backup encontrado para o cliente $CLIENTE na última segunda-feira ($data_segunda)."
    fi
else
    echo "O diretório $DIRETORIO não existe."
fi
