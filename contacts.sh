#!/bin/bash
# Este script é referente ao trabalho da disciplina REDES III
# da UNP - Professor Ricardo Moreira
# Aluno Yan de Lima Justino - Matrícula 201206182
# Código original postado em : https://github.com/yanjustino/shellcontatos

#argumentos
OPTION=$1
VALUES=$2

#constantes
REGEX_DDD="\($2\)"
REGEX_NOME="[a-zA-Z] $2|$2 [a-zA-Z]"

function main(){
    if [[ $OPTION = '-i' ]]; then adicionar_contato
    elif [[ $OPTION = '-r' ]]; then remover_contato
    elif [[ $OPTION = '-h' ]]; then __echo_art
    elif [[ $OPTION = '--todos' || $OPTION = '-t' ]]; then buscar_todos_contatos
    elif [[ $OPTION = '--ddd' || $OPTION = '-d' ]]; then buscar_por_ddd
    elif [[ $OPTION = '--nome' || $OPTION = '-n' ]]; then buscar_por_nome_ou_sobrenome
    else
        __echo_art
    fi
}

# Adiciona um contato no arquivo contacts.db
function adicionar_contato(){
    echo "nome contato > "
    read text
    echo "telefone do contato > "
    read telefone

    echo "$text $telefone" >> "contacts.db"
    buscar_todos_contatos
}

# Remove uma contato do arquivo contacts.db
function remover_contato(){
    sed -i".bak" "/$VALUES/d" contacts.db
}

# exibe lista com todos os contatos do arquivo contacts.db
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

# Cover com helper da aplicação
__echo_art() {
    printf "%b" "\e[0;36m"
    echo "                                           "
    echo "    ____             __               _____"
    echo "   / __ \ ___   ____/ /___   _____   |__  /"
    echo "  / /_/ // _ \ / __  // _ \ / ___/    /_ < "
    echo " / _, _//  __// /_/ //  __/(__  )   ___/ / "
    echo "/_/ |_| \___/ \__,_/ \___//____/   /____/  "
    echo "                                           "
    printf "%b" "\e[0m"

    echo "HELPER DO PROGRAMA CONTATOS"
    echo ""
    echo "(1) Para selecionar todos os contatos use o comando 'contacts.sh -t'"
    echo "(1) Para selecionar todos os contatos use o comando 'contacts.sh --todos'"
    echo "(2) Para selecionar um contato por seu DDD use o comando 'contacts.sh -d <Numero do DDD>'"
    echo "(2) Para selecionar um contato por seu DDD use o comando 'contacts.sh --ddd <Numero do DDD>'"
    echo "(3) Para selecionar um contato por seu Nome ou sobrenome use o comando 'contacts.sh -n <Nome ou Sobrenome>'"
    echo "(3) Para selecionar um contato por seu Nome ou sobrenome use o comando 'contacts.sh --nome <Nome ou Sobrenome>'"
    echo "(4) Para inserir um contato use o comando 'contacts.sh -i"
    echo "(4) Para excluir um contato use o comando 'contacts.sh -r <Nome ou Sobrenome ou telefone>'"
    echo ""
}

main
