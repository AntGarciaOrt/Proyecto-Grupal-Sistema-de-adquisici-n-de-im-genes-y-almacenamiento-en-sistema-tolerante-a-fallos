#!/bin/bash

############################################
# CONFIGURACIÓN
############################################

# Carpeta de imágenes
WEBCAM_DIR="/mnt/sistemaImagenes/webcam"
# Carpeta para logs
REG_LOG_DIR="/mnt/sistemaImagenes/registro_log/webcam"

# URL de la webcam
URL="https://oratge.es/_minis/c05m028e04_webcam1.jpg"

############################################
# FECHA Y HORA ACTUAL
############################################

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")
HORA=$(date +"%H")
MIN=$(date +"%M")

# Nombre base para la imagen y log
FECHA_NOMBRE=$(date +"%d-%m-%Y-%H:%M")
ARCHIVO="benicassimSE_${FECHA_NOMBRE}.jpg"

# Rutas de destino y log
DEST_DIR="$WEBCAM_DIR/$ANIO/$MES/$DIA"
DESTINO="$DEST_DIR/$ARCHIVO"

LOG_DIR="$REG_LOG_DIR/$ANIO/$MES/$DIA"
LOG="$LOG_DIR/benicassimSE_${FECHA_NOMBRE}.log"

############################################
# DESCARGA
############################################

wget -q --timeout=20 --tries=2 "$URL" -O "$DESTINO"

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Imagen Benicassim descargada correctamente: $ARCHIVO" >> "$LOG"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR descargando imagen Benicassim: $ARCHIVO" >> "$LOG"
    rm -f "$DESTINO"
fi

exit 0
