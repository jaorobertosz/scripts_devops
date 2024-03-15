import os
import paramiko
import random
import subprocess

def run_command(command):
    subprocess.run(command, shell=True, check=True)

def backup_local_directory(local_dir, server_address, username, password, local_directory):
    # Verifica se o diretório local existe
    if not os.path.exists(local_directory):
        print(f"Diretório local '{local_directory}' não encontrado.")
        return
    
    # Estabelece uma conexão SSH com timeout
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(server_address, username=username, password=password, timeout=10)
    
    # Comando remoto para gerar o backup
    cmd = """
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
    """

    # Executa o comando remoto
    stdin, stdout, stderr = ssh.exec_command(cmd)
    print(stdout.read().decode())
    print(stderr.read().decode())

    # Transferência do arquivo gerado para o diretório local
    sftp = ssh.open_sftp()
    remote_file = "/root/BACKUP/" + cmd.split("$FILE")[1].split(" ")[0]
    local_file = os.path.join(local_directory, os.path.basename(remote_file))
    sftp.get(remote_file, local_file)
    sftp.close()
    
    print(f"Backup transferido para {local_file}")

    ssh.close()

def select_server_address_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            ips = file.read().splitlines()
            return random.choice(ips)
    except FileNotFoundError:
        print(f"Arquivo '{file_path}' não encontrado.")
        return None

# Configurações
local_directory = "/home/souza/BACKUP"
username = "sysadm"
password = "$3cur1ty"
ips_file_path = "ips.txt"  # Caminho para o arquivo de IPs

# Seleciona um IP aleatório do arquivo
server_address = select_server_address_from_file(ips_file_path)
if server_address:
    # Chamada da função para fazer o backup
    backup_local_directory(local_directory, server_address, username, password, local_directory)