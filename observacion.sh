#!/bin/bash

############################################
# CONFIGURACIÓN
############################################

OBSERVACION_DIR="/mnt/sistemaImagenes/observacion"
REG_LOG_DIR="/mnt/sistemaImagenes/registro_log/observacion"
LOCAL_LOG_BASE="/home/adquisicion-datos/registro_log/observacion"

BASE_URL="https://www.aemet.es/imagenes_d/eltiempo/observacion/satelite"

############################################
# FECHA Y HORA ACTUAL
############################################

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")
HORA=$(date -d "-1 hour" +"%H")
FECHA_URL="${ANIO}${MES}${DIA}${HORA}00"
ARCHIVO="${FECHA_URL}_s93g.gif"

DEST_DIR="$OBSERVACION_DIR/$ANIO/$MES/$DIA"
DESTINO="$DEST_DIR/$ARCHIVO"

LOG_DIR="$REG_LOG_DIR/$ANIO/$MES/$DIA"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/${FECHA_URL}_s93g.log"

LOCAL_LOG_DIR="$LOCAL_LOG_BASE/$ANIO/$MES/$DIA"
mkdir -p "$LOCAL_LOG_DIR"
LOCAL_LOG="$LOCAL_LOG_DIR/${FECHA_URL}_s93g.log"

############################################
# DESCARGA
############################################

wget -q --timeout=20 --tries=2 "$BASE_URL/$ARCHIVO" -O "$DESTINO"

if [ $? -eq 0 ]; then
    MENSAJE="$(date '+%Y-%m-%d %H:%M:%S') - Imagen descargada correctamente: $ARCHIVO"
    echo "$MENSAJE" >> "$LOG"
    echo "$MENSAJE" >> "$LOCAL_LOG"
else
    MENSAJE="$(date '+%Y-%m-%d %H:%M:%S') - ERROR descargando imagen: $ARCHIVO"
    echo "$MENSAJE" >> "$LOG"
    echo "$MENSAJE" >> "$LOCAL_LOG"
    rm -f "$DESTINO"
fi

exit 0
