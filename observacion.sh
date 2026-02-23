############################################
# CONFIGURACIÓN
############################################

# Carpeta de imágenes
OBSERVACION_DIR="/mnt/sistemaImagenes/observacion"
# Carpeta para logs
REG_LOG_DIR="/mnt/sistemaImagenes/registro_log/observacion"

# URL base
BASE_URL="https://www.aemet.es/imagenes_d/eltiempo/observacion/satelite"

############################################
# FECHA Y HORA ACTUAL
############################################

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")
HORA=$(date +"%H")
FECHA_URL="${ANIO}${MES}${DIA}${HORA}00"
ARCHIVO="${FECHA_URL}_s93g.gif"

# Rutas de destino y log
DEST_DIR="$OBSERVACION_DIR/$ANIO/$MES/$DIA"
DESTINO="$DEST_DIR/$ARCHIVO"

LOG_DIR="$REG_LOG_DIR/$ANIO/$MES/$DIA"
LOG="$LOG_DIR/${FECHA_URL}_s93g.log"

############################################
# DESCARGA
############################################

wget -q --timeout=20 --tries=2 "$BASE_URL/$ARCHIVO" -O "$DESTINO"

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Imagen descargada correctamente: $ARCHIVO" >> "$LOG"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR descargando imagen: $ARCHIVO" >> "$LOG"
    rm -f "$DESTINO"
fi

exit 0
