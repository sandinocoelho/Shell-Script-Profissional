#!/bin/bash
# grita.sh
#
# Exemplo de Debug Categorizado em 3 níveis


DEBUG=${1:-0} #Passe o nível pelo $1

#Função de depuração
Debug(){
    [ $1 -le $DEBUG ] && echo -e "--- DEBUG -{ $*"
}

Debug 1 "Início do Programa"

i=0
max=5
echo "Contando até $max"

Debug 2 "Entrando no WHILE"

while [ $i -ne $max ]; do

    Debug 3 "Valor de \$i antes de incrementar: $i"
    let i=$i+1
    Debug 3 "Valor de \$i depois de incrementar: $i"

    echo "$i..."
done

Debug 2 "Sai do WHILE"

echo "Ufa, terminei!!"

Debug 1 "Fim do Programa"