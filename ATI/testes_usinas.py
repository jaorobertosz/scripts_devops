import subprocess
from datetime import datetime, timedelta
import paramiko

def obter_ultima_segunda():
    hoje = datetime.now()
    dias_passados = (hoje.weekday() - 0) % 7  # 0 = Segunda-feira
    ultima_segunda = hoje - timedelta(days=dias_passados)
    return ultima_segunda.strftime("%Y-%m-%d")

def executar_script_shell(cliente):
    comando = f"~/scripts_devops/USINAS/verifica_backup_{cliente}.sh"
    try:
        resultado = subprocess.check_output(comando, shell=True, text=True)
        return resultado.splitlines()
    except subprocess.CalledProcessError as e:
        print(f"Ocorreu um erro ao executar o script: {e}")
        return []

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

def execute_local_command(command):
    try:
        result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print("Resultado do comando local:")
        print(result.stdout)
        print(result.stderr)
    except Exception as e:
        print(f"Erro ao executar o comando local: {e}")

def execute_remote_command(host, username, password, command):
    try:
        # Estabeleça a conexão SSH
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh_client.connect(host, username=username, password=password)

        # Execute o comando remoto
        stdin, stdout, stderr = ssh_client.exec_command(command)
        output = stdout.read().decode()

        print(f"Resultado do comando remoto em {host}:")
        print(output)

    except Exception as e:
        print(f"Erro ao conectar ou executar o comando remoto em {host}: {e}")
    finally:
        # Feche a conexão SSH
        ssh_client.close()

def exibir_menu_opcoes():
    print("Selecione a operação desejada:")
    print("(1) Ping")
    print("(2) Teste de porta")
    print("(3) Ping e Teste de porta")
    print("(4) Testes remotos")
    print("(5) Comandos locais")
    print("(6) Verificar backups")

def main():
    exibir_menu_opcoes()
    opcao = input("Digite o número correspondente à opção desejada: ")

    if opcao == "6":
        clientes = {
            "1": "AEVO",
            "2": "ARAXA",
            "3": "CARAPRETA",
            "4": "CASAFORTE",
            "5": "ENERGEA",
            "6": "ENERSIDE",
            "7": "KIRRA",
            "8": "RIOPOTI",
            "9": "SOLCOPERNICO",
            "10": "TRINITY",
            "11": "VIENA",
            # Adicione mais clientes conforme necessário
        }

        print("Escolha um cliente para verificar o backup:")
        for key, value in clientes.items():
            print(f"({key}) {value}")

        opcao_cliente = input("Digite o número correspondente ao cliente: ")
        
        if opcao_cliente in clientes:
            cliente_selecionado = clientes[opcao_cliente]
            resultado_script = executar_script_shell(cliente_selecionado)

            if not resultado_script:
                print(f"Nenhum backup encontrado para o cliente {cliente_selecionado}.")
            else:
                print(f"Backups encontrados para o cliente {cliente_selecionado}:")
                for linha in resultado_script:
                    print(linha)
        else:
            print("Opção inválida. Por favor, escolha uma opção válida.")

    else:
        num_hosts = int(input("Digite o número de hosts que deseja testar: "))
        hosts = []
        for i in range(num_hosts):
            host = input(f"Digite o endereço IP do host {i + 1}: ")
            hosts.append(host)

        selected_tests = []

        if opcao == "1":
            selected_tests.append("Ping")
        elif opcao == "2":
            selected_tests.append("Teste de porta")
        elif opcao == "3":
            selected_tests.append("Ping e Teste de porta")
        elif opcao == "4":
            selected_tests.append("Testes remotos")
        elif opcao == "5":
            selected_tests.append("Comandos locais")
        else:
            print(f"Opção {opcao} não reconhecida.")

        for test in selected_tests:
            print(f"Executando teste: {test}")
            if test == "Ping":
                for host in hosts:
                    if test_ping(host):
                        print(f"{host} está respondendo ao ping.")
                    else:
                        print(f"{host} não está respondendo ao ping.")

            elif test == "Teste de porta":
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

            elif test == "Ping e Teste de porta":
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

            elif test == "Testes remotos":
                remote_username = input("Digite o nome de usuário para SSH: ")
                remote_password = input("Digite a senha para SSH: ")
                remote_command = input("Digite o comando remoto a ser executado: ")

                for host in hosts:
                    execute_remote_command(host, remote_username, remote_password, remote_command)

            elif test == "Comandos locais":
                num_commands = int(input("Digite o número de comandos que deseja executar localmente: "))
                commands = []
                for i in range(num_commands):
                    command = input(f"Digite o comando {i + 1} que deseja executar: ")
                    commands.append(command)
                for command in commands:
                    execute_local_command(command)

if __name__ == "__main__":
    main()