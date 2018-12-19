#!/bin/bash
# grita.sh
#
# Mostra uma palavra (#TXT) em maiúsculas e com exclamações
# Exemplo: foo -> !!!!!FOO!!!!!
#
#
#
DEBUG=1

#Função de depuração
Debug(){
    [ "$DEBUG" = 1 ] && echo -e "\033[33;1m$*\033[m"
}

TXT="gritaria"

TXT="     $TXT     " #Adiciona 5 espaços ao redor

Debug  "TXT com espaços: [$TXT]"
TXT=$(echo "$TXT" | tr ' ' '!') #Troca espaços por exclamações
Debug "TXT com exclamações: [$TXT]"

TXT=$(echo $TXT | tr a-z A-Z) #Deixa o texto em maiúsculas
echo "$TXT"