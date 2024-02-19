import subprocess
from datetime import datetime, timedelta

def obter_ultima_segunda():
    hoje = datetime.now()
    dias_passados = (hoje.weekday() - 0) % 7  # 0 = Segunda-feira
    ultima_segunda = hoje - timedelta(days=dias_passados)
    return ultima_segunda.strftime("%Y-%m-%d")

def executar_script_shell(cliente):
    comando = f"~/SCRIPTS/USINAS/verifica_backup_{cliente}.sh"
    try:
        resultado = subprocess.check_output(comando, shell=True, text=True)
        return resultado.splitlines()
    except subprocess.CalledProcessError as e:
        print(f"Ocorreu um erro ao executar o script: {e}")
        return []

def verificar_backup_por_usina(usinas_clientes):
    resultado_usinas_sem_backup = []

    for cliente, usinas in usinas_clientes.items():
        resultado_script = executar_script_shell(cliente)

        if not resultado_script:
            print(f"Nenhum backup encontrado para o cliente {cliente}.")
            continue

        for usina in usinas:
            usina_encontrada = False
            for linha in resultado_script:
                if usina in linha:
                    usina_encontrada = True
                    break

            if not usina_encontrada:
                resultado_usinas_sem_backup.append((cliente, usina))

    if resultado_usinas_sem_backup:
        for cliente, usina in resultado_usinas_sem_backup:
            print(f"A usina '{usina}' do cliente '{cliente}' não teve backup realizado.")
    else:
        print("Todos os backups foram realizados para as usinas especificadas.")

def exibir_menu_clientes():
    print("Selecione qual cliente deseja ver backup:")
    print("(1) AEVO")
    print("(2) ARAXA")
    print("(3) CARAPRETA")
    print("(4) CASAFORTE")
    print("(5) ENERGEA")
    print("(6) ENERSIDE")
    print("(7) KIRRA")
    print("(8) RIOPOTI")
    print("(9) SOLCOPERNICO")
    print("(10) TRINITY")
    print("(11) VIENA")
    # Adicione mais clientes conforme necessário

    opcao = input("Escolha uma opção: ")
    return opcao

def main():
    opcao = exibir_menu_clientes()

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

    opcao = exibir_menu_clientes()

    if opcao in clientes:
        cliente_selecionado = clientes[opcao]
        usinas_clientes = {
            cliente_selecionado: ['usina1', 'usina2']  # Adicione as usinas para cada cliente
        }
        verificar_backup_por_usina(usinas_clientes)
    else:
        print("Opção inválida. Por favor, escolha uma opção válida.")

if __name__ == "__main__":
    main()