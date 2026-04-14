#!/bin/bash
#Archivo para el videojuego en bash
#=============================================
#  SERPIENTE LOCA
#  Hecho en bash porque... ¿por qué no?
#
#  Controles: flechas del teclado, q = salir
#
#  ¡FUNCION ESPECIAL: Si comes la estrella ★
#  tus controles se invierten por 12 movimientoss!
#=============================================

# Colores (para que se vea bonito)
VE=$'\e[32m'   #verde  → la serpiente
RO=$'\e[31m'   #rojo   → comida / peligro
AM=$'\e[33m'   #amarillo → puntos
AZ=$'\e[34m'   #azul   → borde del tablero
MA=$'\e[35m'   #magenta → trampa
CI=$'\e[36m'   #cyan   → título
RE=$'\e[0m'    #reset  → quitar color

#Dimensiones del tablero
W=38   #ancho
H=18   #alto
OX=4   #fila donde empieza el tablero
OY=4   #columna donde empieza el tablero

#Estado global del juego
puntos=0
dx=0; dy=1          #dirección inicial: hacia la derecha
invertido=0         #cuando >0, los controles están al revés
comida_x=0; comida_y=0
trampa_x=-1; trampa_y=-1
sx=(); sy=()        #posiciones de cada segmento de la serpiente
delay=0.15          #segundos por tick (velocidad)
corriendo=true

#Mueve el cursor a (fila, columna)
ir() { tput cup "$1" "$2"; }

#Salida limpia del juego
salir() {
    stty echo
    tput cnorm          # mostrar cursor
    tput rmcup          # restaurar pantalla original
    echo -e "\n${AM}★ Puntuación final: $puntos puntos ★${RE}\n"
    exit 0
}

#Dibuja el borde del tablero con líneas dobles
dibujar_borde() {
    ir $OX $OY
    echo -ne "${AZ}╔"
    for ((i=0; i<W; i++)); do echo -ne "═"; done
    echo -ne "╗${RE}"

    for ((r=1; r<=H; r++)); do
        ir $((OX+r)) $OY;          echo -ne "${AZ}║${RE}"
        ir $((OX+r)) $((OY+W+1));  echo -ne "${AZ}║${RE}"
    done

    ir $((OX+H+1)) $OY
    echo -ne "${AZ}╚"
    for ((i=0; i<W; i++)); do echo -ne "═"; done
    echo -ne "╝${RE}"
}

#Barra de info arriba del tablero
mostrar_info() {
    ir 1 $OY
    if (( invertido > 0 )); then
        #aviso de controles invertidos
        echo -ne "${RO}⚠  ¡¡CONTROLES AL REVES!! faltan: $invertido movs  ${RE}   "
    else
        echo -ne "${CI}=[ SERPIENTE LOCA ]=${RE}  Puntos: ${AM}$puntos${RE}                 "
    fi
    ir 2 $OY
    echo -ne "  ${VE}●${RE}=serpiente  ${RO}♦${RE}=comida (+10pts)  ${MA}★${RE}=trampa (¡invierte controles!)  q=salir"
}

#Coloca comida en una posición aleatoria
nueva_comida() {
    #borrar comida anterior (si existía)
    if (( comida_x > 0 )); then
        ir $comida_x $comida_y; echo -ne " "
    fi

    comida_x=$(( OX + 1 + RANDOM % H ))
    comida_y=$(( OY + 1 + RANDOM % W ))
    ir $comida_x $comida_y
    echo -ne "${RO}♦${RE}"

    #35% de probabilidad de que aparezca también una trampa
    if (( RANDOM % 100 < 35 )); then
        if (( trampa_x > 0 )); then
            ir $trampa_x $trampa_y; echo -ne " "   #borrar trampa vieja
        fi
        trampa_x=$(( OX + 1 + RANDOM % H ))
        trampa_y=$(( OY + 1 + RANDOM % W ))
        ir $trampa_x $trampa_y
        echo -ne "${MA}★${RE}"
    fi
}

#Inicializa la serpiente de 5 segmentos en el centro
init_serpiente() {
    local cx=$(( OX + H/2 ))
    local cy=$(( OY + W/2 ))
    sx=(); sy=()
    for ((i=4; i>=0; i--)); do
        sx+=($cx)
        sy+=($(( cy - i )))
    done
}

#Dibuja todos los segmentos de la serpiente
dibujar_serpiente() {
    local len=${#sx[@]}
    for ((i=0; i<len; i++)); do
        ir ${sx[$i]} ${sy[$i]}
        if (( i == len-1 )); then
            # La cabeza apunta hacia donde va
            if   (( dx==-1 )); then echo -ne "${VE}▲${RE}"
            elif (( dx== 1 )); then echo -ne "${VE}▼${RE}"
            elif (( dy== 1 )); then echo -ne "${VE}▶${RE}"
            else                    echo -ne "${VE}◀${RE}"
            fi
        else
            echo -ne "${VE}●${RE}"
        fi
    done
}

#Pantalla de game over
game_over() {
    corriendo=false
    local cx=$(( OX + H/2 ))
    local cy=$(( OY + W/2 - 10 ))

    ir $((cx-1)) $cy; echo -ne "${RO}╔═══════════════════╗${RE}"
    ir $((cx))   $cy; echo -ne "${RO}║    ¡PERDISTE!     ║${RE}"
    ir $((cx+1)) $cy; echo -ne "${RO}║ Puntos: ${AM}$(printf '%-9s' "$puntos") ${RO}║${RE}"
    ir $((cx+2)) $cy; echo -ne "${RO}║                   ║${RE}"
    ir $((cx+3)) $cy; echo -ne "${RO}║  r = reiniciar    ║${RE}"
    ir $((cx+4)) $cy; echo -ne "${RO}║  q = salir        ║${RE}"
    ir $((cx+5)) $cy; echo -ne "${RO}╚═══════════════════╝${RE}"

    local k
    while true; do
        read -n 1 -s k
        [[ "$k" == "q" ]] && salir
        [[ "$k" == "r" ]] && { jugar; return; }
    done
}

#Mueve la serpiente un paso
mover() {
    local len=${#sx[@]}
    local nx=$(( ${sx[$((len-1))]} + dx ))
    local ny=$(( ${sy[$((len-1))]} + dy ))

    #Choque con los bordes: game over
    if (( nx<=OX || nx>OX+H || ny<=OY || ny>OY+W )); then
        game_over; return
    fi

    #Choque con su propio cuerpo: game over
    for ((i=1; i<len-1; i++)); do
        if (( nx==sx[i] && ny==sy[i] )); then
            game_over; return
        fi
    done

    #Borrar la cola antes de mover
    ir ${sx[0]} ${sy[0]}; echo -ne " "

    # Desplazar todos los segmentos hacia adelante
    for ((i=0; i<len-1; i++)); do
        sx[$i]=${sx[$((i+1))]}
        sy[$i]=${sy[$((i+1))]}
    done
    sx[$((len-1))]=$nx
    sy[$((len-1))]=$ny

    # ¿Comió la comida normal? → crecer y sumar puntos
    if (( nx==comida_x && ny==comida_y )); then
        (( puntos += 10 ))
        # Crecer: duplicar el primer segmento (se agrega al principio del array)
        sx=( "${sx[0]}" "${sx[@]}" )
        sy=( "${sy[0]}" "${sy[@]}" )
        nueva_comida

        #La serpiente se pone más rápida cada 50 puntos
        case $puntos in
            50)  delay=0.13 ;;
            100) delay=0.11 ;;
            150) delay=0.09 ;;
            200) delay=0.07 ;;
        esac
    fi

    # ¿Comió la trampa?: invertir controles por 12 movimientos
    if (( trampa_x>0 && nx==trampa_x && ny==trampa_y )); then
        invertido=12
        ir $trampa_x $trampa_y; echo -ne " "
        trampa_x=-1; trampa_y=-1
    fi

    #Contar los movimientos que quedan invertidos
    if (( invertido > 0 )); then
        (( invertido-- ))
    fi
}

#Lee una tecla con timeout (así funciona el tick del juego)
leer_tecla() {
    local k=""
    IFS= read -r -s -t "$delay" -n 1 k < /dev/tty    # espera $delay segundos o una tecla

    #Las flechas mandan una secuencia de 3 bytes: ESC [ letra
    if [[ "$k" == $'\x1b' ]]; then
        IFS= read -r -s -t 0.05 -n 2 k < /dev/tty   # leer los otros 2 bytes rápido

        #Si los controles están invertidos, las flechas hacen lo contrario
        if (( invertido > 0 )); then
            case "$k" in
                "[A") (( dy!=0 )) && dx=1  && dy=0 ;;  # arriba → abajo
                "[B") (( dy!=0 )) && dx=-1 && dy=0 ;;  # abajo → arriba
                "[C") (( dx!=0 )) && dy=-1 && dx=0 ;;  # derecha → izquierda
                "[D") (( dx!=0 )) && dy=1  && dx=0 ;;  # izquierda → derecha
            esac
        else
            case "$k" in
                "[A") (( dy!=0 )) && dx=-1 && dy=0 ;;  # arriba
                "[B") (( dy!=0 )) && dx=1  && dy=0 ;;  # abajo
                "[C") (( dx!=0 )) && dy=1  && dx=0 ;;  # derecha
                "[D") (( dx!=0 )) && dy=-1 && dx=0 ;;  # izquierda
            esac
        fi
    elif [[ "$k" == "q" ]]; then
        salir
    fi
}

#Pantalla de bienvenida
pantalla_inicio() {
    clear
    local cx=$(( $(tput lines)/2 - 6 ))
    local cy=$(( $(tput cols)/2 - 21 ))
    (( cx < 1 )) && cx=1

    ir $cx         $cy; echo -ne "${VE}╔══════════════════════════════════════════╗${RE}"
    ir $((cx+1))   $cy; echo -ne "${VE}║${RE}    ${CI}  S E R P I E N T E  L O C A        ${RE}  ${VE}║${RE}"
    ir $((cx+2))   $cy; echo -ne "${VE}╠══════════════════════════════════════════╣${RE}"
    ir $((cx+3))   $cy; echo -ne "${VE}║${RE}   Usa las flechas del teclado para mover ${VE}║${RE}"
    ir $((cx+4))   $cy; echo -ne "${VE}║${RE}   ${RO}♦${RE} Come la comida para crecer  (+10)    ${VE}║${RE}"
    ir $((cx+5))   $cy; echo -ne "${VE}║${RE}   ${MA}★${RE} ¡Cuidado con la trampa!              ${VE}║${RE}"
    ir $((cx+6))   $cy; echo -ne "${VE}║${RE}     → Invierte tus controles por 12 movs ${VE}║${RE}"
    ir $((cx+7))   $cy; echo -ne "${VE}║${RE}     → Izquierda se vuelve derecha, etc...${VE}║${RE}"
    ir $((cx+8))   $cy; echo -ne "${VE}╠══════════════════════════════════════════╣${RE}"
    ir $((cx+9))   $cy; echo -ne "${VE}║${RE}     Presiona ${CI}ENTER${RE} para empezar          ${VE}║${RE}"
    ir $((cx+10))  $cy; echo -ne "${VE}║${RE}     Presiona ${RO}q${RE} para salir                ${VE}║${RE}"
    ir $((cx+11))  $cy; echo -ne "${VE}╚══════════════════════════════════════════╝${RE}"

    local k
    while true; do
        read -n 1 -s k
        [[ -z "$k" ]] && break   #Enter = empezar
        [[ "$k" == "q" ]] && salir
    done
}

#Función principal del juego (se puede llamar para reiniciar)
jugar() {
    puntos=0
    delay=0.15
    invertido=0
    comida_x=0; comida_y=0
    trampa_x=-1; trampa_y=-1
    dx=0; dy=1
    corriendo=true

    clear
    dibujar_borde
    init_serpiente
    dibujar_serpiente
    nueva_comida
    mostrar_info

    while $corriendo; do
        leer_tecla
        $corriendo && mover
        $corriendo && dibujar_serpiente
        $corriendo && mostrar_info
    done
}

#Punto de entrada
main() {
    trap 'salir' SIGTERM SIGINT
    stty -echo          #ocultar lo que se escribe
    tput civis          #ocultar el cursor
    tput smcup          #guardar la pantalla original

    pantalla_inicio
    jugar
}

main
