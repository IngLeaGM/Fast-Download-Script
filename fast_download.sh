#!/bin/bash

# Este script de descargar varios archivos en secuencia rapidamente atravez
# de una direccion https usando wget.


ext=""
ext_option=1
ext_list=()

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

while (( ext_option != 0 ))
do
    echo "Que extensiones deseas descargar?"
    echo "(1) .mp4"
    echo "(2) .jpg"
    echo "(3) .svg"
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
        ext=".svg"
    fi

    if (( ext_option == 0 ))
    then
        break
    fi

    if (( ext_option < 0 || ext_option > 3 ))
    then
        echo "Opcion invalida"
        return 0
    fi

    add_ext ext_list "$ext"

done

read -p "Coloca el url: " url

if (( ${#ext_list[@]} > 1 ));
then
    ext_search="${ext_list[0]}"
    IFS=,
    ext_search="${ext_list[*]}"
    unset IFS

    #Verificacion de que no exista ningun espacio entre los elementos.
    ext_search="${ext_search// /}"

    echo "$ext_search"

    wget -r -np -nc -nd --show-progress -A $ext_search $url 2>/dev/null

else
    wget -r -np -nc -nd --show-progress -A ${ext_list[0]} $url 2>/dev/null

fi
