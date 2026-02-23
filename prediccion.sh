#!/bin/bash

############################################
# CONFIGURACIÓN
############################################

# Carpeta de predicciones
PREDICCION_DIR="/mnt/sistemaImagenes/prediccion"
# Carpeta para logs
REG_LOG_DIR="/mnt/sistemaImagenes/registro_log/prediccion"

# URL base
BASE_URL="https://www.aemet.es/imagenes_d/eltiempo/prediccion/temperaturas"

############################################
# FECHA BASE (00 UTC DEL DÍA ACTUAL)
############################################

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")
FECHA_BASE=$(date +"%Y%m%d")"00"

############################################
# DESCARGAR 24h, 48h y 72h
############################################

for HORAS in 024 048 072
do
    if [ "$HORAS" == "024" ]; then DIA_PRED=1; fi
    if [ "$HORAS" == "048" ]; then DIA_PRED=2; fi
    if [ "$HORAS" == "072" ]; then DIA_PRED=3; fi

    # Nombre del archivo de imagen
    ARCHIVO="${FECHA_BASE}+${HORAS}_ww_btmxp0d${DIA_PRED}.png"

    # Rutas de destino y log
    DEST_DIR="$PREDICCION_DIR/$ANIO/$MES/$DIA"
    DESTINO="$DEST_DIR/$ARCHIVO"

    LOG_DIR="$REG_LOG_DIR/$ANIO/$MES/$DIA"
    LOG="$LOG_DIR/${ARCHIVO%.png}.log"

    # Descargar la imagen
    wget -q --timeout=20 --tries=2 "$BASE_URL/$ARCHIVO" -O "$DESTINO"

    if [ $? -eq 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Predicción ${HORAS}h descargada correctamente: $ARCHIVO" >> "$LOG"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR descargando predicción ${HORAS}h: $ARCHIVO" >> "$LOG"
        rm -f "$DESTINO"
    fi
done

exit 0
