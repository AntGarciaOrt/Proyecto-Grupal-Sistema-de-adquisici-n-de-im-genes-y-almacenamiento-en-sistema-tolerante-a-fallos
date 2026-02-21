#!/bin/bash

############################################
# CONFIGURACIÓN
############################################

PREDICCION_DIR="/mnt/sistemaImagenes/prediccion"
REG_LOG_DIR="/mnt/sistemaImagenes/registro_log/prediccion"
LOCAL_LOG_BASE="/home/adquisicion-datos/registro_log/prediccion"

BASE_URL="https://www.aemet.es/imagenes_d/eltiempo/prediccion/temperaturas"

############################################
# FECHA BASE
############################################

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")
FECHA_BASE=$(date +"%Y%m%d")"00"

############################################
# DESCARGA 24h, 48h y 72h
############################################

for HORAS in 024 048 072
do
    if [ "$HORAS" == "024" ]; then DIA_PRED=1; fi
    if [ "$HORAS" == "048" ]; then DIA_PRED=2; fi
    if [ "$HORAS" == "072" ]; then DIA_PRED=3; fi

    ARCHIVO="${FECHA_BASE}+${HORAS}_ww_btmxp0d${DIA_PRED}.png"

    DEST_DIR="$PREDICCION_DIR/$ANIO/$MES/$DIA"
    mkdir -p "$DEST_DIR"
    DESTINO="$DEST_DIR/$ARCHIVO"

    LOG_DIR="$REG_LOG_DIR/$ANIO/$MES/$DIA"
    mkdir -p "$LOG_DIR"
    LOG="$LOG_DIR/${ARCHIVO%.png}.log"

    LOCAL_LOG_DIR="$LOCAL_LOG_BASE/$ANIO/$MES/$DIA"
    mkdir -p "$LOCAL_LOG_DIR"
    LOCAL_LOG="$LOCAL_LOG_DIR/${ARCHIVO%.png}.log"

    wget -q --timeout=20 --tries=2 "$BASE_URL/$ARCHIVO" -O "$DESTINO"

    if [ $? -eq 0 ]; then
        MENSAJE="$(date '+%Y-%m-%d %H:%M:%S') - Predicción ${HORAS}h descargada correctamente: $ARCHIVO"
        echo "$MENSAJE" >> "$LOG"
        echo "$MENSAJE" >> "$LOCAL_LOG"
    else
        MENSAJE="$(date '+%Y-%m-%d %H:%M:%S') - ERROR descargando predicción ${HORAS}h: $ARCHIVO"
        echo "$MENSAJE" >> "$LOG"
        echo "$MENSAJE" >> "$LOCAL_LOG"
        rm -f "$DESTINO"
    fi
done

exit 0
