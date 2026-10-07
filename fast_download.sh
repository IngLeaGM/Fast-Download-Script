#!/bin/bash

# Este script de descargar varios archivos en secuencia rapidamente atravez
# de una direccion https usando wget.


ext=""
ext_option=1
ext_list=()

url_list=()
url_option="1"

add_ext(){

    local -n new_list=$1
    local new_value=$2

    for i in ${!new_list[@]}; do

        if [ "$new_value" == "${new_list[$i]}" ]
        then
            echo "Ya fue añadida la extension"  
            return 1
        fi
    done

    ext_list+=("$new_value") 

}

#Muestra las extensiones seleccionadas
ext_selected() {
    local -n ext_selected=$1

    if (( ${#ext_selected[@]} > 0 ));
    then

        echo "|-EXTENSIONES AÑADIDAS-|"

        for i in "${!ext_selected[@]}"; do
            echo ${ext_selected[$i]}
        done
    fi
}

add_url(){

    local -n new_list=$1
    local new_value=$2

    for i in ${!new_list[@]}; do

        if [ "$new_value" == "${new_list[$i]}" ]
        then
            echo "Ya fue añadida esa url"  
            return 1
        fi
    done

    url_list+=("$new_value") 

}

#Muestra las URLs seleccionadas
url_selected() {
    local -n url_selected=$1

    if (( ${#url_selected[@]} > 0 ));
    then

        echo "|-URLs AÑADIDAS-|"
        echo "${#url_selected[@]}"
    fi
}

ext_search_void() {

    ext_search=$1 
    local -n list=$2
    if (( ${#list[@]} > 1 ));
    then
        ext_search="${list[0]}"
        IFS=,
        ext_search="${list[*]}"
        unset IFS

        #Verificacion de que no exista ningun espacio entre los elementos.
        ext_search="${ext_search// /}"
    else
        ext_search="${list[0]}"
    fi
}

url_search_void() {

    url_search=$1
    local -n list=$2

    if (( ${#list[@]} > 1 ));
    then
        url_search="${list[0]}"
        IFS=" "
        url_search="${list[*]}"
        unset IFS

        url_search="$url_search"

    else
        url_search="${list[0]}"
    fi
}

while (( ext_option != 0 ))
do
    echo "Que extensiones deseas descargar?"
    echo "(1) .mp4"
    echo "(2) .jpg"
    echo "(3) .png"
    echo "(4) .svg"
    echo ""
    echo "(0) Continuar..."

    ext_selected ext_list

    read -p "Seleccion: " ext_option

    if (( ext_option == 1 ))
    then
        ext=".mp4"
    fi

    if (( ext_option == 2 ))
    then
        ext=".jpg"
    fi

    if (( ext_option == 3 ))
    then
        ext=".png"
    fi

    if (( ext_option == 4 ))
    then
        ext=".svg"
    fi

    if (( ext_option == 0 ))
    then
        break
    fi

    if (( ext_option < 0 || ext_option > 4 ))
    then
        echo "Opcion invalida"
        return 0
    fi

    add_ext ext_list "$ext"

done

while true
do
    echo "Añade las URLs"
    echo "(0) Continuar..."

    url_selected url_list

    read -p "Coloca el url: " url_option

    url_selected url_list

    if (( url_option == "0" ))
    then
        break
    fi

    add_url url_list "$url_option"

done

ext_search_void ext_search ext_list
url_search_void url_search url_list

wget -r -np -nc -nd --show-progress -A $ext_search $url_search 2>/dev/null

