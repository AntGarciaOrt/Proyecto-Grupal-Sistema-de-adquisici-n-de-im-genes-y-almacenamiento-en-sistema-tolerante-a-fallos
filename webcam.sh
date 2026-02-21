#!/bin/bash

############################################
# CONFIGURACIÓN
############################################

WEBCAM_DIR="/mnt/sistemaImagenes/webcam"
REG_LOG_DIR="/mnt/sistemaImagenes/registro_log/webcam"
LOCAL_LOG_BASE="/home/adquisicion-datos/registro_log/webcam"

URL="https://oratge.es/_minis/c05m028e04_webcam1.jpg"

############################################
# FECHA Y HORA ACTUAL
############################################

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")
FECHA_NOMBRE=$(date +"%d-%m-%Y-%H:%M")

ARCHIVO="benicassimSE_${FECHA_NOMBRE}.jpg"

DEST_DIR="$WEBCAM_DIR/$ANIO/$MES/$DIA"
mkdir -p "$DEST_DIR"
DESTINO="$DEST_DIR/$ARCHIVO"

LOG_DIR="$REG_LOG_DIR/$ANIO/$MES/$DIA"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/benicassimSE_${FECHA_NOMBRE}.log"

LOCAL_LOG_DIR="$LOCAL_LOG_BASE/$ANIO/$MES/$DIA"
mkdir -p "$LOCAL_LOG_DIR"
LOCAL_LOG="$LOCAL_LOG_DIR/benicassimSE_${FECHA_NOMBRE}.log"

############################################
# DESCARGA
############################################

wget -q --timeout=20 --tries=2 "$URL" -O "$DESTINO"

if [ $? -eq 0 ]; then
    MENSAJE="$(date '+%Y-%m-%d %H:%M:%S') - Imagen Benicassim descargada correctamente: $ARCHIVO"
    echo "$MENSAJE" >> "$LOG"
    echo "$MENSAJE" >> "$LOCAL_LOG"
else
    MENSAJE="$(date '+%Y-%m-%d %H:%M:%S') - ERROR descargando imagen Benicassim: $ARCHIVO"
    echo "$MENSAJE" >> "$LOG"
    echo "$MENSAJE" >> "$LOCAL_LOG"
    rm -f "$DESTINO"
fi

exit 0
