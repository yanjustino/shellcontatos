#!/bin/bash
# Este script é referente ao trabalho da disciplina REDES III
# da UNP - Professor Ricardo Reis
# Aluno Yan de Lima Justino - Matrícula 201206182

#argumentos
OPTION=$1
VALUES=$2

#constantes
REGEX_DDD="\($2\)"
REGEX_NOME="[a-zA-Z] $2|$2 [a-zA-Z]"

function main(){
    if [[ $OPTION = '-i' ]]; then adicionar_contato
    elif [[ $OPTION = '-r' ]]; then remover_contato
    elif [[ $OPTION = '--todos' || $OPTION = '-t' ]]; then buscar_todos_contatos
    elif [[ $OPTION = '--ddd' || $OPTION = '-d' ]]; then buscar_por_ddd
    elif [[ $OPTION = '--nome' || $OPTION = '-n' ]]; then buscar_por_nome_ou_sobrenome
    else
        echo "Comando não reconhecido ou não informado!"           
    fi
}

# Adiciona um contato no arquivo contacts.db
function adicionar_contato(){
    echo $VALUES >> "contacts.db"
}

function remover_contato(){
    sed -i".bak" "/$VALUES/d" contacts.db
}

# Remove uma contato do arquivo contacts.db
function buscar_todos_contatos(){
    while read line
    do
        name=$line
        echo "$name"
    done < "contacts.db" 
}

# Função para recuperar contatos por DDD
function buscar_por_ddd(){
    while read line
    do   
        name=$line
        if [[ $name =~ $REGEX_DDD ]]; then
            echo "$name"
        fi
    done < "contacts.db"     
}

# Função para recuperar contatos por Nome ou Sobrenome
function buscar_por_nome_ou_sobrenome(){
    while read line
    do   
        name=$line    
        if [[ $name =~ $REGEX_NOME ]]; then
            echo "$name"
        fi
    done < "contacts.db"     
}

main