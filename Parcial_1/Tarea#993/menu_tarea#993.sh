#!/bin/bash
#Menu de 18 Scripts de Shell Linux

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

#SCRIPT 1: Hola Mundo
script_01_hola_mundo() {
    limpiar
    echo "=== SCRIPT 1: Hola Mundo ==="
    echo ""
    
    # Esto es un comentario
    
    echo "Hola mundo"
    
    pausar
}

#SCRIPT 2: Hola Mundo con Variable
script_02_hola_mundo_variable() {
    limpiar
    echo "=== SCRIPT 2: Hola Mundo con Variable ==="
    echo ""
    
    # En la primera linea establezco con qué shell se debe ejecutar
    # Se define una variable
    
    SALUDO="Hola mundo"
    echo -n "Este script te dice: "
    echo ${SALUDO}
    
    pausar
}

#SCRIPT 3: Variables
script_03_variables() {
    limpiar
    echo "=== SCRIPT 3: Variables ==="
    echo ""
    
    # Muestra el uso de variables
    # No existen los tipos
    # definición de variables
    una_variable=666
    MI_NOMBRE="Allan"
    NOMBRES="Paola Alfonso Bernardo Nadia Karol"
    BOOLEANO=true
    
    echo "Echemos un ojo a las variables "
    echo "Un número: ${una_variable}"
    echo "Un nombre ${MI_NOMBRE}"
    echo "Un grupo de nombres: ${NOMBRES}"
    
    # Al script se le pueden pasar argumentos. Para recogerlos
    # hay que usar : ${número} donde:
    # ${0} : nombre del script
    # ${1} : primer argumento
    # ${2} : segundo argumento
    # ...etc.
    
    echo "Has invocado el script pasándome ${0} eta ${1} "
    # Otras variables especiales
    # $# : Número de argumentos
    echo "Me has pasado $# argumentos"
    # $@ : grupo de parámetros del script
    echo "IDa: ${!} y $@"
    
    # Variables de entorno
    echo "Mi directorio actual: ${PWD} y mi usuario ${UID}"
    
    pausar
}

#SCRIPT 4: Arrays
script_04_arrays() {
    limpiar
    echo "=== SCRIPT 4: Arrays ==="
    echo ""
    
    # Muestra el uso de arrays
    
    # Podemos crear arrays de una dimensión
    asociaciones[0]="Gruslin"
    asociaciones[1]="Hackresi"
    asociaciones[2]="NavarradotNET"
    asociaciones[3]="Riberlug"
    
    # Otra forma de definirlos
    partidos=("UPN" "PSN" "CDN" "IUN" "Nafarroa BAI" "RCN" )
    numeros=(15 23 45 42 23 1337 23 666 69)
    echo ${asociaciones[0]} es una asociación, ${partidos[1]} un partido
    
    #echo "Tamaño: $#asociaciones"
    #echo "Tamaño: ${$#{partidos}}"
    
    pausar
}

#SCRIPT 5: Otros Usos (Substring y Valores)
script_05_otros_usos() {
    limpiar
    echo "=== SCRIPT 5: Otros Usos (Substring y Valores) ==="
    echo ""
    
    # Muestra el uso de variables
    # Sacar parte del valor de una variable (substring)
    NOMBRE="Navarrux Live edition"
    echo ${NOMBRE} una parte ${NOMBRE:8} y otra ${NOMBRE:8:4}
    
    # Valores por defecto.
    # ${variable:-valorpordefecto}
    SINVALOR=
    echo "Variable SINVALOR: ${SINVALOR:-31337} eta ${VACIO:-'Miguel Indurain'}"
    echo "La variable SINVALOR no tiene valor algun ${SINVALOR} "
    # Esto es igual pero el valor queda establecido
    # ${variable:=valorpordefecto}
    echo "Variable SINVALOR: ${SINVALOR:=31337} eta ${VACIO:='Miguel Indurain'}"
    echo "La variable SINVALOR no tiene valor algun ${SINVALOR} "
    
    # Y lo contrario: si la variable SÍ tiene valor, se le pone otro
    # ${variable:+valorpordefecto}
    PROGRAMA='sniffit'
    echo "valor de PROGRAMA: ${PROGRAMA:+'tcpdump'} y ahora ${PROGRAMA}"
    
    # Si la variable está sin definir o vacía se muestra un error. En caso
    # contrario se le asigna un valor por defecto
    # ${variable:?valorpordefecto}
    echo "Valor de: ${EJEMPLO:?'Roberto'} y luego {EJEMPLO}"
    
    # Otros
    # ${!prefijo*} : nos devuelve una lista de las variables que comienzan
    # con determinado prefijo.
    # Podemos probar con el for:
    for i in ${!P*};do echo $i ;done
    
    pausar
}

#SCRIPT 6: Operaciones Aritméticas
script_06_aritmeticas() {
    limpiar
    echo "=== SCRIPT 6: Operaciones Aritmeticas ==="
    echo ""
    
    # , +, *, /, %, **, variable++, variable--, --variable, ++variable
    # == : igualdad
    # != : desigualdad
    
    # Pruebas
    VALOR1=23
    VALOR2=45
    # Para las operaciones puede usarse expr o []
    RESULTADO=`expr ${VALOR1} + ${VALOR2}`
    echo "Resultado: ${RESULTADO}"
    
    RESULTADO=`expr ${VALOR1} + ${VALOR2} + 3`
    echo "Resultado: ${RESULTADO}"
    
    VALOR1=5
    VALOR2=4
    echo "${VALOR1} y ${VALOR2}"
    
    RESULTADO=$[${VALOR1} + ${VALOR2} + 2]
    echo "Ahora: ${VALOR1} + ${VALOR2} + 2 = ${RESULTADO}"
    
    RESULTADO=$[${VALOR1} + $[${VALOR2} * 3]]
    echo "Ahora: ${VALOR1} + ${VALOR2} * 3 = ${RESULTADO}"
    
    pausar
}

#SCRIPT 7: Operaciones Lógicas
script_07_logicas() {
    limpiar
    echo "=== SCRIPT 7: Operaciones Logicas ==="
    echo ""
    
    ## operaciones lógicas
    # && : and
    # || : or
    # ! : not
    
    booleano=true
    
    # Si la variable booleano es true veremos por pantalla "OK"
    $booleano && echo "OK" || echo "no es true"
    
    otrobool=!${booleano}
    
    test ${otrobool} || echo "Ahora es falso"
    # Mediante && podemos encadenar comandos
    #who && ps -axf && echo "OK"
    
    ## comparaciones : -eq, -ne, -lt, -le, -gt, or -ge
    valor=6
    
    test $valor -le 6 && echo "Se cumple"
    
    # Asignaciones
    nuevo=${valor}
    test ${nuevo} -eq ${valor} && echo "Son los mismo"
    echo "Ahora ${nuevo} es lo mismo que ${valor}"
    
    pausar
}

#SCRIPT 8: Condicionales if/test
script_08_condicionales() {
    limpiar
    echo "=== SCRIPT 8: Condicionales if/test ==="
    echo ""
    
    # Condicionales
    VARIABLE=45
    if [ ${VARIABLE} -gt 0 ]; then
        echo "${VARIABLE} es mayor que 0"
    fi
    
    # Podemos meter el then en la siguiente linea
    if [ -e /etc/shadow ]
    then
        echo "OK, parece que tienes un sistema con shadow pass"
    fi
    
    ## Estructura if-else
    OTRA=-23
    
    if [ ${OTRA} -lt 0 ]
    then
        echo "${OTRA} es menor que 0"
    else
        echo "${OTRA} es mayor que 0";
    fi
    
    ## Estructura if-elseif
    # Vamos a usar "read" para pedirle datos al usuario
    echo -n "Mete un valor: "
    read VALOR1
    echo -n "Mete otro valor: "
    read VALOR2
    
    echo "Has introducido los valores ${VALOR1} y ${VALOR2} "
    
    if [ ${VALOR1} -gt ${VALOR2} ]
    then
        echo "${VALOR1} es mayor que ${VALOR2}"
    elif [ ${VALOR1} -lt ${VALOR2} ]
    then
        echo "${VALOR1} es menor que ${VALOR2}"
    else
        echo "${VALOR1} y ${VALOR2} son iguales"
    fi
    
    ## Estructura test
    # Ejecutar operacion si no se cumple la condición
    # test condición || operacion
    # Ejecutar operación si se cumple
    # test condición && operacion
    
    # Este test crea un fichero si no existe.
    test -f './fichero.txt' || touch fichero.txt
    
    pausar
}

#SCRIPT 9: Comprobaciones de Ficheros
script_09_comprobaciones() {
    limpiar
    echo "=== SCRIPT 9: Comprobaciones de Ficheros ==="
    echo ""
    
    # script para comprobar si un fichero existe. Espera un parámetro
    echo "Ingresa el nombre de un archivo para comprobar:"
    read archivo
    
    if [ -e "$archivo" ] && [ -f "$archivo" ]
    then
    echo "OK, el fichero existe "
    else echo "NO existe"
    fi
    # Para comprobar la negación usaríamos el símbolo: !
    if [ ! -e "$archivo" ]
    then
    echo "No existe"
    fi
    
    pausar
}

#SCRIPT 10: Estructura case
script_10_case() {
    limpiar
    echo "=== SCRIPT 10: Estructura case ==="
    echo ""
    
    NOMBRE=""
    
    echo -n "Dame un nombre: "
    read NOMBRE
    
    case ${NOMBRE} in 
        iñigo)
            echo "${NOMBRE} dice: me dedico a Navarrux"
            ;;
        sten)
            echo "${NOMBRE} dice: tengo un blog friki"
            ;;
        asier)
            echo "${NOMBRE}> dice: .NET me gusta"
            ;;
        pello)
            echo "${NOMBRE}> dice: el shell mola"
            ;;
        *)
            echo "A ${NOMBRE} no lo conozco"
    esac
    
    pausar
}

#SCRIPT 11: Iteraciones (For)
script_11_iteraciones() {
    limpiar
    echo "=== SCRIPT 11: Iteraciones (For) ==="
    echo ""
    
    ## un for simple
    echo "FOR simple: "
    for i in a b c d e f g h i
    do
        echo "letra: $i"
    done
    
    ## for para recorrer array
    NOMBRES="Iñigo Sten Asier Pello Roberto"
    echo "FOR simple para recorrer un array: "
    
    echo "Participantes en la 4party: "
    for i in ${NOMBRES}
    do
        echo ${i}
    done
    
    ## for con el resultado de un comando
    echo "FOR con el resultado de un comando"
    echo "(Nota: requiere archivo direcciones.txt)"
    if [ -f "direcciones.txt" ]; then
        for i in `cat direcciones.txt`
        do
            echo ${i}
        done
    else
        echo "Archivo direcciones.txt no encontrado"
    fi
    
    ## for con un grupo de ficheros
    echo "FOR con ficheros"
    for i in *.sh
    do
        ls -lh ${i}
    done
    
    ## for clásico con un índice
    echo "FOR clásico "
    for (( cont=0 ; ${cont} < 10 ; cont=`expr $cont + 1` ))
    do
        echo "Ahora valgo> ${cont}"
    done
    
    pausar
}

#SCRIPT 12: While
script_12_while() {
    limpiar
    echo "=== SCRIPT 12: While ==="
    echo ""
    
    ## Estructura while
    echo "WHILE en marcha"
    
    cont=0
    
    # Un bucle que terminará cuando $cont sea mayor que 100
    while (test ${cont} -lt 100)
    do
        cont=`expr $cont + 10`
        echo "Valor del contador: ${cont}"
    done
    
    echo "Valor final del contador: ${cont}"
    
    ## Un while infinito
    # while true; do comando; done
    
    pausar
}

#SCRIPT 13: Until
script_13_until() {
    limpiar
    echo "=== SCRIPT 13: Until ==="
    echo ""
    
    ## El bucle until
    # Un bucle until se ejecuta hasta que el test resulte falso
    echo "Estructura until"
    
    cont=15
    
    until (test ${cont} -lt 0)
    do
        cont=`expr $cont - 1`
        echo "Valor del contador: ${cont}"
    done
    
    echo "Valor final del contador: ${cont}"
    
    pausar
}

#SCRIPT 14: Select
script_14_select() {
    limpiar
    echo "=== SCRIPT 14: Select ==="
    echo ""
    
    ## Estructura select
    
    # El select es similar al choice de msdos
    # sirve para crear menus de seleccion
    
    echo "Select de distros"
    
    DISTROS="Debian Ubuntu Navarrux Gentoo Mandriva"
    
    echo "Selecciona la mejor opción por favor: ${resultado}"
    
    select resultado in ${DISTROS}
    do
        # Si la longitud de cadena de resultado es > 0 ya está seleccionado
        (test ${#resultado} -ne 0 ) && break
        echo "Selecciona la mejor opción por favor: ${resultado}"
    done
    
    echo "Sistema seleccionado: [${resultado}] longitud de cadena: ${#resultado}"
    
    pausar
}

#SCRIPT 15: Funciones
script_15_funciones() {
    limpiar
    echo "=== SCRIPT 15: Funciones ==="
    echo ""
    
    ## funciones
    
    # Antes que nada hay que definir las funciones, si no daría error
    # las funciones toman los parámetros con $numero, como el script
    
    # variable
    RESULTADO=0
    
    # Una función que muestra valores por pantalla
    muestrapantalla () {
        echo "Valores: $0> $1 y $2 y $3"
    }
    
    # Puede usarse return pero solo para devolver números
    sumame () {
        echo "Estamos en la función: ${FUNCNAME}"
        echo "Parametros: $1 y $2"
        RESULTADO=`expr ${1} + ${2}`
        return 0
    }
    
    # Es posible la función recursiva
    boom () {
        echo "No ejecutes esto..."
        boom
    }
    
    # La llamada de se puede hacer así, sin paréntesis
    muestrapantalla 3 4 "epa"
    
    # Llamamos a la función y si devuelve 0 es correcto.
    sumame 45 67 && echo "OK" || echo "Ocurrió un error"
    
    echo "Resultado: ${RESULTADO} $!"
    
    pausar
}

#SCRIPT 16: Librerías
script_16_librerias() {
    limpiar
    echo "=== SCRIPT 16: Librerias ==="
    echo ""
    
    echo "NOTA: Este script requiere el archivo libreria.sh"
    echo "Como estamos en un menu integrado, se omite la importacion"
    echo ""
    
    # No es que existan las librerías pero se puede simular
    # algo similar
    
    # Esta es la forma de importar funciones
    # source libreria.sh
    
    # Definimos las funciones aquí para demostración
    RESULTADO=0
    
    muestrapantalla () {
        echo "Valores: $0> $1 y $2 y $3"
    }
    
    sumame () {
        echo "Estamos en la función: ${FUNCNAME}"
        echo "Parametros: $1 y $2"
        RESULTADO=`expr ${1} + ${2}`
        return 0
    }
    
    muestrapantalla 69 123 "epa"
    
    sumame 1337 3389 && echo "OK" || echo "Ocurrió un error"
    
    echo "Resultado: ${RESULTADO} $!"
    
    pausar
}

#SCRIPT 17: Señales (trap)
script_17_senales() {
    limpiar
    echo "=== SCRIPT 17: Senales (trap) ==="
    echo ""
    
    # señales
    funcion () {
        echo "Se ha recibido una señal: ${FUNCNAME} ${0}"
        #exit
    }
    
    # Lo primero es establecer que señales se atraparán. Lo hacemos con trap
    # Con esto evitaremos que se haga caso a Ctrl-C CTRL-Z
    # trap ":" INT QUIT TSTP
    
    # Esto es similar pero al recibir la señal dirigimos la ejecución a la función
    trap "funcion" INT QUIT TSTP
    
    # Un bucle sin fin para probar
    echo "Presiona Ctrl+C para ver la captura de señal"
    echo "Se ejecutaran 5 iteraciones..."
    contador=0
    while [ $contador -lt 5 ]
    do
        sleep 2
        echo "ufff qué sueño..."
        contador=$((contador + 1))
    done
    
    trap - INT QUIT TSTP
    
    pausar
}

#SCRIPT 18: Colores ANSI
script_18_colores() {
    limpiar
    echo "=== SCRIPT 18: Colores ANSI ==="
    echo ""
    
    ## Los colores ANSI
    # para darle color a los scripts debemos usar los código ANSI
    # junto "con echo -e". Para meter el carácter especial escape
    # usamos \033
    
    # Ejem: \033[0m : volver al color por defecto
    # \033[40m: color de fondo negro
    # \033[40m\033[32m: fondo negro primer plano verde
    
    # Esta es la muestra de colores, ejecútalo para ver cómo queda
    echo -e "\033[40m\033[37m Blanco \033[0m"
    echo -e "\033[40m\033[1;37m Gris claro \033[0m"
    echo -e "\033[40m\033[30m Negro \033[0m (esto es negro)"
    echo -e "\033[40m\033[1;30m Gris \033[0m"
    echo -e "\033[40m\033[31m Rojo \033[0m"
    echo -e "\033[40m\033[1;31m Rojo claro \033[0m"
    echo -e "\033[40m\033[32m Verde \033[0m"
    echo -e "\033[40m\033[1;32m Verde claro \033[0m"
    echo -e "\033[40m\033[33m Marrón \033[0m"
    echo -e "\033[40m\033[1;33m Amarillo \033[0m"
    echo -e "\033[40m\033[34m Azul \033[0m"
    echo -e "\033[40m\033[1;34m Azul claro \033[0m"
    echo -e "\033[40m\033[35m Purpura \033[0m"
    echo -e "\033[40m\033[1;35m Rosa \033[0m"
    echo -e "\033[40m\033[36m Cyan \033[0m"
    echo -e "\033[40m\033[1;36m Cyan claro \033[0m"
    
    # Se pueden poner fondos de otro color:
    echo -e "\033[42m\033[31m Navarrux v1.0 \033[0m"
    
    echo -e "\033[40m\033[4;33m Amarillo \033[0m"
    
    pausar
}

#MENÚ PRINCIPAL
mostrar_menu() {
    limpiar
    echo "========================================================"
    echo "    MENU DE 18 SCRIPTS DE SHELL LINUX"
    echo "    Taller Shell, comandos y programacion"
    echo "========================================================"
    echo ""
    echo "Seccion 1: Variables y Datos"
    echo "  1)  Hola Mundo"
    echo "  2)  Hola Mundo con Variable"
    echo "  3)  Variables"
    echo "  4)  Arrays"
    echo "  5)  Otros Usos (Substring y Valores)"
    echo ""
    echo "Seccion 2: Operaciones"
    echo "  6)  Operaciones Aritmeticas"
    echo "  7)  Operaciones Logicas"
    echo ""
    echo "Seccion 3: Estructuras de Control"
    echo "  8)  Condicionales if/test"
    echo "  9)  Comprobaciones de Ficheros"
    echo "  10) Estructura case"
    echo ""
    echo "Seccion 4: Iteraciones"
    echo "  11) Iteraciones (For)"
    echo "  12) While"
    echo "  13) Until"
    echo "  14) Select"
    echo ""
    echo "Seccion 5: Avanzado"
    echo "  15) Funciones"
    echo "  16) Librerias"
    echo "  17) Senales (trap)"
    echo "  18) Colores ANSI"
    echo ""
    echo "  0)  Salir"
    echo ""
    echo -n "Selecciona una opcion [0-18]: "
}

#BUCLE PRINCIPAL
while true; do
    mostrar_menu
    read opcion
    
    case $opcion in
        1)  script_01_hola_mundo ;;
        2)  script_02_hola_mundo_variable ;;
        3)  script_03_variables ;;
        4)  script_04_arrays ;;
        5)  script_05_otros_usos ;;
        6)  script_06_aritmeticas ;;
        7)  script_07_logicas ;;
        8)  script_08_condicionales ;;
        9)  script_09_comprobaciones ;;
        10) script_10_case ;;
        11) script_11_iteraciones ;;
        12) script_12_while ;;
        13) script_13_until ;;
        14) script_14_select ;;
        15) script_15_funciones ;;
        16) script_16_librerias ;;
        17) script_17_senales ;;
        18) script_18_colores ;;
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
