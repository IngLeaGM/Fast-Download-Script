#!/bin/bash

# Este script de descargar varios archivos en secuencia rapidamente atravez
# de una direccion https usando wget.


ext=""

echo "Que extension desea descargar?"
echo "(1) .mp4"
echo "(2) .jpg"
echo "(3) .svg"

read -p "Seleccion: " ext_option

if (( ext_option < 1 || ext_option > 3 ))
then
    echo "Opcion invalida"
    exit 1
fi

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

read -p "Coloca el url: " url

wget -r -np -nc --show-progress -A$ext $url 2>/dev/null
