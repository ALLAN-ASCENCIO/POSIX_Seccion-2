#!/bin/bash
#EASY: Backwards Listing
#INTERMEDIATE: ASCII to Integer
#DIFFICULT: Square Root 

#Función para pausar
pausar() {
    echo ""
    echo "Presiona Enter para continuar..."
    read
}

#Función para limpiar pantalla
limpiar() {
    clear
}

#Script 1
EASY_BackwardsListing() {
    limpiar
    echo "EASY: Backwards Listing"
    echo "-----------------------"
    echo "Introduce una cadena de texto:"
    read texto
    echo "Texto al revés: $(echo "$texto" | rev)"
    pausar
}

#######################################################

#Script 2
INTERMEDIATE_ASCIItoInteger() {
    limpiar
    while true; do
        mostrar_menu_ascii
        read opcion_ascii
        
        case $opcion_ascii in
            1)  ascii_to_integer ;;
            2)  integer_to_ascii ;;
            0)  break ;;
            *)
                echo "Opcion invalida. Presiona Enter para continuar..."
                read
                ;;
        esac
    done
}
    
ascii_to_integer() {
    limpiar
    echo "INTERMEDIATE: ASCII to Integer"
    echo "-----------------------------"
    echo "Introduce un carácter:"
    read -n 1 char
    echo ""
    ascii_value=$(printf "%d" "'$char")
    echo "El valor ASCII de '$char' es: $ascii_value"
    pausar
}

integer_to_ascii() {
    limpiar
    echo "INTERMEDIATE: Integer to ASCII"
    echo "-----------------------------"
    echo "Introduce un número entero (0-127):"
    read integer
    if [[ $integer -ge 0 && $integer -le 127 ]]; then
        ascii_char=$(printf "\\$(printf "%o" "$integer")")
        echo "El carácter ASCII correspondiente a $integer es: '$ascii_char'"
    else
        echo "Número fuera de rango. Por favor, introduce un número entre 0 y 127."
    fi
    pausar
}

#######################################################

#Script 3
#DIFFICULT_SquareRoot() {

#}


#MENÚ PRINCIPAL
mostrar_menu() {
    limpiar
    echo "Menu de Scripts"
    echo "1. EASY: Backwards Listing"
    echo "2. INTERMEDIATE: ASCII to Integer"
    echo "3. DIFFICULT: Square Root"
    echo "0. Salir"
    echo ""
    echo -n "Selecciona una opcion [0-3]: "
}

#MENÚ ASCII TO INTEGER
mostrar_menu_ascii() {
    limpiar
    echo "Menu ASCII to Integer"
    echo "1. ASCII to Integer"
    echo "2. Integer to ASCII"
    echo "0. Volver al menu principal"
    echo ""
    echo -n "Selecciona una opcion [0-2]: "
}

#BUCLE PRINCIPAL
while true; do
    mostrar_menu
    read opcion
    
    case $opcion in
        1)  EASY_BackwardsListing ;;
        2)  INTERMEDIATE_ASCIItoInteger ;;
        3)  DIFFICULT_SquareRoot  ;;
        0)
            limpiar
            echo "Gracias por usar el menu de scripts."
            echo "Hasta luego."
            echo ""
            exit 0
            ;;
        *)
            echo "Opcion invalida. Presiona Enter para continuar..."
            read
            ;;
    esac
done
