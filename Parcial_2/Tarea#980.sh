#!/bin/bash
# Uso: ./Tarea#980.sh <archivo>

# ── Validación de argumento ───────────────────────────────────────────────────
if [ -z "$1" ]; then
    echo "Uso: $0 <archivo>"
    exit 1
fi

ARCHIVO="$1"

if [ ! -e "$ARCHIVO" ]; then
    echo "Error: '$ARCHIVO' no existe."
    exit 1
fi

# ── Extraer datos con stat y ls ───────────────────────────────────────────────
PERMISOS=$(stat -c "%A" "$ARCHIVO")       # ej: -rwxrwxr-x
USUARIO=$(stat -c "%U" "$ARCHIVO")
GRUPO=$(stat -c "%G" "$ARCHIVO")
TAMANIO=$(stat -c "%s" "$ARCHIVO")
FECHA=$(stat -c "%y" "$ARCHIVO")         # fecha de modificación (ls -al muestra esta)
RUTA=$(realpath "$ARCHIVO")
NOMBRE=$(basename "$ARCHIVO")

# ── Tipo de archivo ───────────────────────────────────────────────────────────
case "${PERMISOS:0:1}" in
    -)  TIPO="Archivo regular" ;;
    d)  TIPO="Directorio" ;;
    l)  TIPO="Enlace simbólico" ;;
    b)  TIPO="Dispositivo de bloque" ;;
    c)  TIPO="Dispositivo de caracteres" ;;
    p)  TIPO="Tubería (pipe)" ;;
    s)  TIPO="Socket" ;;
    *)  TIPO="Desconocido" ;;
esac

# ── Función: convierte rwx de 3 chars a texto ─────────────────────────────────
describir_permisos() {
    local bits="$1"   # ej: "rwx" o "r-x"
    local desc=""

    [ "${bits:0:1}" = "r" ] && desc+="Lectura"
    [ "${bits:1:1}" = "w" ] && { [ -n "$desc" ] && desc+=", "; desc+="Escritura"; }
    [ "${bits:2:1}" = "x" ] && { [ -n "$desc" ] && desc+=", "; desc+="Ejecución"; }

    # bits especiales: s (setuid/setgid) y t (sticky)
    [ "${bits:2:1}" = "s" ] && { [ -n "$desc" ] && desc+=", "; desc+="Ejecución, SetUID/SetGID"; }
    [ "${bits:2:1}" = "t" ] && { [ -n "$desc" ] && desc+=", "; desc+="Sticky bit"; }

    [ -z "$desc" ] && desc="Sin permisos"
    echo "$desc"
}

# ── Separar los 9 bits de permisos (ignorar el char de tipo) ─────────────────
BITS_USER="${PERMISOS:1:3}"
BITS_GROUP="${PERMISOS:4:3}"
BITS_OTHER="${PERMISOS:7:3}"

DESC_USER=$(describir_permisos  "$BITS_USER")
DESC_GROUP=$(describir_permisos "$BITS_GROUP")
DESC_OTHER=$(describir_permisos "$BITS_OTHER")

# ── Fecha en español ──────────────────────────────────────────────────────────
DIA=$(date -d "$FECHA" "+%-d")
MES_NUM=$(date -d "$FECHA" "+%m")
ANIO=$(date -d "$FECHA" "+%Y")

case "$MES_NUM" in
    01) MES="enero" ;;    02) MES="febrero" ;;   03) MES="marzo" ;;
    04) MES="abril" ;;    05) MES="mayo" ;;       06) MES="junio" ;;
    07) MES="julio" ;;    08) MES="agosto" ;;     09) MES="septiembre" ;;
    10) MES="octubre" ;;  11) MES="noviembre" ;;  12) MES="diciembre" ;;
esac

FECHA_ES="$DIA de $MES de $ANIO"

# ── Salida ────────────────────────────────────────────────────────────────────
echo ""
echo "Nombre:            $NOMBRE"
echo "Tipo:              $TIPO"
echo "Ruta absoluta:     $RUTA"
echo "Usuario:           $USUARIO"
echo "Grupo:             $GRUPO"
echo "Tamaño:            $TAMANIO bytes"
echo "Fecha modificación: $FECHA_ES"
echo "Permisos raw:      $PERMISOS"
echo ""
echo "Permisos detallados:"
echo "  User  ($USUARIO):  $DESC_USER"
echo "  Group ($GRUPO): $DESC_GROUP"
echo "  Others:           $DESC_OTHER"
echo ""
