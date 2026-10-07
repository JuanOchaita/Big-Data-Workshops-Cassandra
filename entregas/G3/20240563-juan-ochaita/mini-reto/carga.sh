#!/bin/bash
# Uso: ./carga.sh CARNE RUTA_MINIRETO
# Genera los CSV desnormalizados con carga.py y los carga con COPY.
CARNE=$1; ENT=$2
mkdir -p $ENT/csv
python3 $ENT/carga.py data/mini-reto/G3-discord $ENT/csv
docker cp $ENT/csv cassandra2:/tmp/csv
docker exec cassandra2 cqlsh -e "
CONSISTENCY ONE;
COPY discord_$CARNE.usuarios_por_id (usuario_id,nombre_usuario,creado_en) FROM '/tmp/csv/usuarios_por_id.csv' WITH HEADER=true;
COPY discord_$CARNE.mensajes_por_canal (canal_id,enviado_en,mensaje_id,usuario_id,nombre_usuario,contenido) FROM '/tmp/csv/mensajes_por_canal.csv' WITH HEADER=true;
COPY discord_$CARNE.mensajes_por_usuario (usuario_id,enviado_en,mensaje_id,canal_id,servidor,canal,contenido) FROM '/tmp/csv/mensajes_por_usuario.csv' WITH HEADER=true;
COPY discord_$CARNE.mensajes_por_canal_dia (canal_id,dia,mensaje_id) FROM '/tmp/csv/mensajes_por_canal_dia.csv' WITH HEADER=true;"
