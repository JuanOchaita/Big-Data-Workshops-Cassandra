CREATE KEYSPACE IF NOT EXISTS discord_20240563
  WITH replication = {'class': 'NetworkTopologyStrategy', 'dc-g3': 3};

USE discord_20240563;

CREATE TABLE IF NOT EXISTS usuarios_por_id (
  usuario_id     text PRIMARY KEY,
  nombre_usuario text,
  creado_en      timestamp
);

CREATE TABLE IF NOT EXISTS mensajes_por_canal (
  canal_id       text,
  enviado_en     timestamp,
  mensaje_id     int,
  usuario_id     text,
  nombre_usuario text,
  contenido      text,
  PRIMARY KEY ((canal_id), enviado_en, mensaje_id)
) WITH CLUSTERING ORDER BY (enviado_en DESC, mensaje_id DESC);

CREATE TABLE IF NOT EXISTS mensajes_por_usuario (
  usuario_id  text,
  enviado_en  timestamp,
  mensaje_id  int,
  canal_id    text,
  servidor    text,
  canal       text,
  contenido   text,
  PRIMARY KEY ((usuario_id), enviado_en, mensaje_id)
) WITH CLUSTERING ORDER BY (enviado_en DESC, mensaje_id DESC);

CREATE TABLE IF NOT EXISTS mensajes_por_canal_dia (
  canal_id   text,
  dia        date,
  mensaje_id int,
  PRIMARY KEY ((canal_id, dia), mensaje_id)
);
