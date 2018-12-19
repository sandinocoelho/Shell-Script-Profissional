#!/bin/bash
#usuarios.sh
#
# mostra os logins e nomes de usuarios do sistema
# Obs: Lẽ dados do arquivo /etc/passwd
# 
# Versão 1: Mostra os usuários e nomes separados por TAB
# Versão 2: Adicionado suporte a opção -h
# Versão 3: Adiocionado suporte a -V e opçṍes inválidas
# Versão 4: arrumado o bug quando não tem opções, basename no nome do programa,
#           -V extraindo direto do cabeçalho, adicionado --help e --version
# Versão 5: Implementado o -s, --sort que ordena o resultado por ordem alfabética
# Versão 6: Adicionadas opções -r, --reverse, -u, --uppercase e loop de multiplos parametros
# Versão 7: adicionado o -d, --delimiter
#
# Sandino, Dezembro de 2018
# 

ordenar=0           #Chave para ordenar a saida
inverter=0          #chave para inverter a ordem da listagem
maiusculas=0        #chave para converter em maiusculas
delimitador='\t'    #Delimitador padrão TAB

MENSAGEM_USO="
Uso: $(basename "$0") [OPÇÕES]

OPÇÕES:
    -d, --delimiter C   Usa o caractere C como delimitador
    -h, --help          Mostra esta tela de ajuda e sai
    -V, --version       Mostra a versão do programa e sai
    -s, --sort          Ordena o resultado por ordem alfabética
    -r, --reverse       Inverte a listagem
    -u, --uppercase     Mostra a listagem em maiúsculas
"

#Tratamento das opções de linha de comando
while test -n "$1"
do

    case "$1" in
        -h | --help)
            echo "$MENSAGEM_USO"
            exit 0
        ;;

        -V | --version)
            echo -n $(basename "$0")
            # Extrai a versão diretamente do cabeçalho do programa
            grep "^# Versão " "$0" | tail -1 | cut -d : -f 1 | tr -d \#
            exit 0
        ;;

        #Opções que Ligam/desligam as chaves
        -s | --sort)        ordenar=1       ;;
        -u | --uppercase)   maiusculas=1    ;;
        -r | --reverse)     inverter=1      ;;

        # Checa a chave de delimitador
        -d | --delimiter)
            shift
            delimitador="$1"

            if test -z "$delimitador"
            then
                echo "Faltou um argumento para -d"
                exit 1
            fi
        ;;
        # Testa se a opção é inválida
        *)
            if test -n "$1"
            then
                echo "Opção inválida: $1"
                echo "Use --help para ajuda."
                exit 1
            fi
        ;;
    esac
    
    #Opção $1 já tratada, a fila anda
    shift
done


# Extrai a listagem
lista=$(cut -d : -f 1,5 /etc/passwd)

#Ordena a listagem se necessário
test "$ordenar" = 1 && lista=$(echo "$lista" | sort)

# Inverte a listagem se necessário
test "$inverter" = 1 && lista=$(echo "$lista" | tac)

# Converte em maiusculo a listagem se necessário
test "$maiusculas" = 1 && lista=$(echo "$lista" | tr a-z A-Z)

#Exibe o resultado para o usuário
echo "$lista" | tr : "$delimitador"