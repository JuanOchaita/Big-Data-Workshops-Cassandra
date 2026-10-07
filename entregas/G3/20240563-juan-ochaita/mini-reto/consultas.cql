USE discord_20240563;

-- C1. Perfil de un usuario.
SELECT usuario_id, nombre_usuario, creado_en
FROM usuarios_por_id
WHERE usuario_id = 'du230';

-- C2. Los 20 mensajes más recientes de un canal, con el autor.
SELECT enviado_en, nombre_usuario, contenido
FROM mensajes_por_canal
WHERE canal_id = 'ch16'
LIMIT 20;

-- C3. Los 10 mensajes más recientes de un usuario, con el canal y el servidor.
SELECT enviado_en, servidor, canal, contenido
FROM mensajes_por_usuario
WHERE usuario_id = 'du186'
LIMIT 10;

-- C4. Cuántos mensajes tuvo un canal en un día.
SELECT COUNT(*) AS mensajes
FROM mensajes_por_canal_dia
WHERE canal_id = 'ch16' AND dia = '2026-09-04';
