#!/bin/bash

# Ruta donde está montado el NAS
BASE_DIR="/mnt/sistemaImagenes"

# Ruta local adicional para logs
LOCAL_LOG_BASE="/home/adquisicion-datos/registro_log"

# Fecha actual
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)

# Carpetas principales
DIRECTORIOS=("observacion" "prediccion" "webcam")

# Crear estructura
for DIR in "${DIRECTORIOS[@]}"; do
    # Ruta de la carpeta principal en NAS
    DIR_PATH="$BASE_DIR/$DIR/$YEAR/$MONTH/$DAY"
    mkdir -p "$DIR_PATH"

    # Crear estructura de logs en NAS
    REG_LOG_PATH="$BASE_DIR/registro_log/$DIR/$YEAR/$MONTH/$DAY"
    mkdir -p "$REG_LOG_PATH"

    # Crear estructura de logs en LOCAL
    LOCAL_LOG_PATH="$LOCAL_LOG_BASE/$DIR/$YEAR/$MONTH/$DAY"
    mkdir -p "$LOCAL_LOG_PATH"
done
