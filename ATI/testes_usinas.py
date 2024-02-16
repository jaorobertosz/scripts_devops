import subprocess
import paramiko

def test_ping(host):
    try:
        subprocess.check_output(["ping", "-c", "1", host])
        return True
    except subprocess.CalledProcessError:
        return False

def test_port(host, port):
    try:
        command = f"nc -zvnw5 {host} {port}"
        result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        
        if "succeeded" in result.stderr:
            return True
        elif "refused" in result.stderr:
            return "refused"
        else:
            return False
    except Exception as e:
        print(f"Erro ao testar porta: {e}")
        return False

def test_ping_and_ports(host, ports):
    is_ping_successful = test_ping(host)
    open_ports = []
    refused_ports = []

    for port in ports:
        result = test_port(host, port)
        if result is True:
            open_ports.append(port)
        elif result == "refused":
            refused_ports.append(port)

    return is_ping_successful, open_ports, refused_ports

def execute_remote_command(host, username, password, command):
    try:
        # Estabeleça a conexão SSH
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh_client.connect(host, username=username, password=password)

        # Execute o comando remoto
        stdin, stdout, stderr = ssh_client.exec_command(command)
        output = stdout.read().decode()

        print("Resultado do comando remoto:")
        print(output)

    except Exception as e:
        print(f"Erro ao conectar ou executar o comando remoto: {e}")
    finally:
        # Feche a conexão SSH
        ssh_client.close()

def remote_tests(host, username, password, command):
    try:
        # Estabeleça a conexão SSH
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh_client.connect(host, username=username, password=password)

        # Execute o comando de limpeza de memória
        stdin, stdout, stderr = ssh_client.exec_command(command)
        output = stdout.read().decode()

        print("Resultado do comando de limpeza de memória:")
        print(output)

    except Exception as e:
        print(f"Erro ao conectar ou executar o comando: {e}")
    finally:
        # Feche a conexão SSH
        ssh_client.close()
        
def execute_local_command(command):
    try:
        result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print("Resultado do comando local:")
        print(result.stdout)
        print(result.stderr)
    except Exception as e:
        print(f"Erro ao executar o comando local: {e}")

def main():
    num_hosts = int(input("Digite o número de hosts que deseja testar: "))
    hosts = []
    for i in range(num_hosts):
        host = input(f"Digite o endereço IP do host {i + 1}: ")
        hosts.append(host)

    print("Qual teste deseja realizar?")
    print("(1) Ping")
    print("(2) Teste de porta")
    print("(3) Ping e Teste de porta")
    print("(4) Testes remotos")
    print("(5) Comandos locais")
    test_type = input("Digite o número correspondente à opção desejada: ")

    if test_type == "1":
        for host in hosts:
            if test_ping(host):
                print(f"{host} está respondendo ao ping.")
            else:
                print(f"{host} não está respondendo ao ping.")
    elif test_type == "2":
        num_ports = int(input("Digite o número de portas que deseja testar: "))
        ports = []
        for i in range(num_ports):
            port = int(input(f"Digite a porta {i + 1} que deseja testar: "))
            ports.append(port)
        
        for host in hosts:
            for port in ports:
                result = test_port(host, port)
                if result is True:
                    print(f"A porta {port} em {host} está aberta.")
                elif result == "refused":
                    print(f"A porta {port} em {host} foi recusada.")
                else:
                    print(f"A porta {port} em {host} está fechada.")
    elif test_type == "3":
        num_ports = int(input("Digite o número de portas que deseja testar: "))
        ports = []
        for i in range(num_ports):
            port = int(input(f"Digite a porta {i + 1} que deseja testar: "))
            ports.append(port)
        
        for host in hosts:
            is_ping_successful, open_ports, refused_ports = test_ping_and_ports(host, ports)
            if is_ping_successful:
                print(f"{host} está respondendo ao ping.")
            else:
                print(f"{host} não está respondendo ao ping.")
            
            if open_ports:
                print(f"As seguintes portas em {host} estão abertas: {', '.join(map(str, open_ports))}")
            else:
                print(f"Todas as portas em {host} estão fechadas.")
            
            if refused_ports:
                print(f"As seguintes portas em {host} foram recusadas: {', '.join(map(str, refused_ports))}")
    
    elif test_type == "4":
        # Configurar informações de conexão para testes remotos
        remote_username = input("Digite o nome de usuário para SSH: ")
        remote_password = input("Digite a senha para SSH: ")
        remote_command = input("Digite o comando remoto a ser executado: ")

        for host in hosts:
            execute_remote_command(host, remote_username, remote_password, remote_command)

    elif test_type == "5":
        # Executar comandos locais
        num_commands = int(input("Digite o número de comandos que deseja executar: "))
        for i in range(num_commands):
            command = input(f"Digite o comando {i + 1} que deseja executar: ")
            execute_local_command(command)
    
    else:
        print("Opção de teste não reconhecida. Escolha '1' para ping, '2' para teste de porta, '3' para ping e teste de porta, '4' para testes remotos (Limpeza de memória), ou '5' para comandos locais.")

if __name__ == "__main__":
    main()