import os
import paramiko
import random

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

    # Gera arquivo de backup compactado
    tar --exclude='*.*~' --exclude='*.tgz' --exclude='*.log' -czf "$FILE" /etc/network/interfaces /etc/hosts /etc/resolv.conf /etc/zabbix /ATI/sgd >/dev/null 
    """

    # Executa o comando remoto
    stdin, stdout, stderr = ssh.exec_command(cmd)
    print(stdout.read().decode())
    print(stderr.read().decode())

    # Obtem o nome do arquivo remoto
    remote_file = cmd.split("$FILE")[1].split('"')[1].strip()
    
    # Tenta fazer o download do arquivo
    try:
        sftp = ssh.open_sftp()
        sftp.get( remote_file, os.path.join(local_directory, remote_file))
        print(f"Backup transferido para {os.path.join(local_directory, remote_file)}")
        sftp.close()
    except FileNotFoundError:
        print(f"Arquivo remoto '{remote_file}' não encontrado.")
    
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
local_directory = "/USINAS/TESTE/BACKUP"
username = "root"
password = ""
ips_file_path = "ips.txt"  # Caminho para o arquivo de IPs

server_address = select_server_address_from_file(ips_file_path)
if server_address:
    # Chamada da função para fazer o backup
    backup_local_directory(local_directory, server_address, username, password, local_directory)
