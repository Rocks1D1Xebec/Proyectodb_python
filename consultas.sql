-- TIENDA DE VIDEOJUEGOS
-- 01. Listar todos los videojuegos publicados con titulo, precio y fecha de lanzamiento.
SELECT titulo, precio_base, fecha_lanzamiento
FROM videojuego
WHERE estado_publicacion = 'publicado'
ORDER BY fecha_lanzamiento DESC;

-- 02. Listar todos los usuarios con nombre, apellido y pais.
SELECT nombre_usuario, nombre, apellido, pais
FROM usuario
ORDER BY apellido ASC;

-- 03. Mostrar los videojuegos publicados con precio mayor a $30.
SELECT titulo, precio_base
FROM videojuego
WHERE precio_base > 30
  AND estado_publicacion = 'publicado'
ORDER BY precio_base DESC;

-- 04. Listar los desarrolladores autorizados con su estudio, pais y fecha de autorizacion.
SELECT nombre_estudio, pais, sitio_web, fecha_autorizacion
FROM desarrollador
WHERE autorizado = TRUE
ORDER BY fecha_autorizacion DESC;

-- 05. Mostrar las cuentas registradas en los ultimos 2 anos ordenadas por fecha.
SELECT correo, tipo_cuenta, fecha_registro, estado
FROM cuenta
WHERE fecha_registro >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY fecha_registro DESC;

-- 06. Listar los juegos rechazados junto con el motivo de rechazo.
SELECT titulo, motivo_rechazo, fecha_solicitud
FROM videojuego
WHERE estado_publicacion = 'rechazado'
ORDER BY fecha_solicitud DESC;

-- 07. Mostrar los usuarios con saldo en billetera mayor a $50.
SELECT nombre_usuario, nombre, apellido, saldo_billetera
FROM usuario
WHERE saldo_billetera > 50
ORDER BY saldo_billetera DESC;



-- 08. Contar cuantos usuarios hay registrados por pais.
SELECT pais, COUNT(*) AS total_usuarios
FROM usuario
GROUP BY pais
ORDER BY total_usuarios DESC;

-- 09. Mostrar ingresos totales, cantidad de transacciones y ticket promedio por metodo de pago.
SELECT metodo_pago,
       COUNT(*)           AS total_transacciones,
       SUM(precio_pagado) AS ingresos_totales,
       AVG(precio_pagado) AS ticket_promedio
FROM compra
GROUP BY metodo_pago;

-- 10. Contar cuantas solicitudes de autorizacion existen por cada estado.
SELECT estado, COUNT(*) AS total
FROM solicitud_autorizacion
GROUP BY estado;

-- 11. Contar cuantos juegos hay en cada estado de publicacion.
SELECT estado_publicacion, COUNT(*) AS total
FROM videojuego
GROUP BY estado_publicacion
ORDER BY total DESC;

-- 12. Calcular el promedio de calificacion de cada videojuego con al menos una reseña.
SELECT id_juego,
       ROUND(AVG(calificacion), 2) AS promedio,
       COUNT(*)                    AS total_reseñas
FROM reseña
GROUP BY id_juego
HAVING COUNT(*) >= 1
ORDER BY promedio DESC;

-- 13. Mostrar los 5 videojuegos con mas reseñas registradas.
SELECT id_juego, COUNT(*) AS total_reseñas
FROM reseña
GROUP BY id_juego
ORDER BY total_reseñas DESC
LIMIT 5;

-- 14. Contar cuantos juegos tiene asociado cada desarrollador.
SELECT id_cuenta_dev, COUNT(*) AS total_juegos
FROM desarrollador_videojuego
GROUP BY id_cuenta_dev
ORDER BY total_juegos DESC;



-- 15. Mostrar el historial completo de compras con nombre de usuario y titulo del juego.
SELECT u.nombre_usuario, u.nombre, u.apellido,
       v.titulo, c.precio_pagado, c.metodo_pago, c.fecha_compra
FROM compra c
JOIN usuario    u ON c.id_cuenta_usuario = u.id_cuenta
JOIN videojuego v ON c.id_juego          = v.id_juego
ORDER BY c.fecha_compra DESC;

-- 16. Listar los juegos que tiene cada usuario en su biblioteca.
SELECT u.nombre_usuario, v.titulo, b.fecha_agregado
FROM biblioteca b
JOIN usuario    u ON b.id_cuenta_usuario = u.id_cuenta
JOIN videojuego v ON b.id_juego          = v.id_juego
ORDER BY u.nombre_usuario, b.fecha_agregado DESC;

-- 17. Mostrar todas las reseñas con nombre de usuario, titulo del juego, calificacion y comentario.
SELECT u.nombre_usuario, v.titulo,
       r.calificacion, r.comentario, r.fecha, r.util_votos
FROM reseña r
JOIN usuario    u ON r.id_cuenta_usuario = u.id_cuenta
JOIN videojuego v ON r.id_juego          = v.id_juego
ORDER BY r.fecha DESC;

-- 18. Listar los 10 juegos mas vendidos con total de ventas e ingresos generados.
SELECT v.titulo,
       COUNT(c.id_compra)   AS total_ventas,
       SUM(c.precio_pagado) AS ingresos_totales
FROM videojuego v
JOIN compra c ON v.id_juego = c.id_juego
GROUP BY v.id_juego, v.titulo
ORDER BY total_ventas DESC
LIMIT 10;

-- 19. Mostrar los 10 usuarios que mas dinero han gastado en la tienda.
SELECT u.nombre_usuario, u.nombre, u.apellido,
       COUNT(c.id_compra)   AS juegos_comprados,
       SUM(c.precio_pagado) AS total_gastado
FROM usuario u
JOIN compra c ON u.id_cuenta = c.id_cuenta_usuario
GROUP BY u.id_cuenta, u.nombre_usuario, u.nombre, u.apellido
ORDER BY total_gastado DESC
LIMIT 10;

-- 20. Listar los juegos mejor calificados con su promedio y cantidad de reseñas.
SELECT v.titulo,
       ROUND(AVG(r.calificacion), 2) AS promedio,
       COUNT(r.id_reseña)            AS total_reseñas
FROM videojuego v
JOIN reseña r ON v.id_juego = r.id_juego
GROUP BY v.id_juego, v.titulo
ORDER BY promedio DESC, total_reseñas DESC;

-- 21. Mostrar cada juego publicado con todas sus categorias en una sola columna.
SELECT v.titulo,
       GROUP_CONCAT(cat.nombre ORDER BY cat.nombre SEPARATOR ', ') AS categorias
FROM videojuego v
JOIN videojuego_categoria vc  ON v.id_juego      = vc.id_juego
JOIN categoria            cat ON vc.id_categoria = cat.id_categoria
WHERE v.estado_publicacion = 'publicado'
GROUP BY v.id_juego, v.titulo
ORDER BY v.titulo;

-- 22. Mostrar el promedio de calificacion y cantidad de juegos publicados por cada estudio desarrollador.
SELECT d.nombre_estudio, d.pais,
       ROUND(AVG(r.calificacion), 2) AS promedio_calificacion,
       COUNT(DISTINCT dv.id_juego)   AS juegos_publicados
FROM desarrollador d
JOIN desarrollador_videojuego dv ON d.id_cuenta = dv.id_cuenta_dev
JOIN videojuego               v  ON dv.id_juego = v.id_juego
JOIN reseña                   r  ON v.id_juego  = r.id_juego
WHERE v.estado_publicacion = 'publicado'
GROUP BY d.id_cuenta, d.nombre_estudio, d.pais
ORDER BY promedio_calificacion DESC;

-- 23. Listar las solicitudes resueltas con el administrador que las atendio y el desarrollador solicitante.
SELECT adm.nombre_completo AS administrador,
       dev.nombre_estudio  AS estudio_desarrollador,
       sa.estado, sa.fecha_solicitud, sa.fecha_resolucion
FROM solicitud_autorizacion sa
JOIN administrador adm ON sa.id_cuenta_admin = adm.id_cuenta
JOIN desarrollador dev ON sa.id_cuenta_dev   = dev.id_cuenta
WHERE sa.estado IN ('aprobada', 'rechazada')
ORDER BY sa.fecha_resolucion DESC;

-- 24. Mostrar los requisitos de hardware minimos y recomendados de cada juego publicado.
SELECT v.titulo, rh.tipo, rh.so_requerido, rh.procesador,
       rh.memoria_ram_gb, rh.tarjeta_grafica, rh.vram_gb
FROM videojuego v
JOIN requisitos_hardware rh ON v.id_juego = rh.id_juego
WHERE v.estado_publicacion = 'publicado'
ORDER BY v.titulo, rh.tipo;



-- 25. Listar los usuarios que nunca han realizado ninguna compra.
SELECT u.nombre_usuario, u.nombre, u.apellido, u.pais
FROM usuario u
LEFT JOIN compra c ON u.id_cuenta = c.id_cuenta_usuario
WHERE c.id_compra IS NULL
ORDER BY u.nombre_usuario;

-- 26. Mostrar los juegos publicados que no han sido comprados por ningun usuario.
SELECT v.titulo, v.precio_base, v.fecha_lanzamiento
FROM videojuego v
LEFT JOIN compra c ON v.id_juego = c.id_juego
WHERE v.estado_publicacion = 'publicado'
  AND c.id_compra IS NULL
ORDER BY v.titulo;

-- 27. Listar los juegos cuyo promedio de calificacion supera el promedio general de la plataforma.
SELECT v.titulo,
       ROUND(AVG(r.calificacion), 2) AS promedio_juego
FROM videojuego v
JOIN reseña r ON v.id_juego = r.id_juego
GROUP BY v.id_juego, v.titulo
HAVING AVG(r.calificacion) > (SELECT AVG(calificacion) FROM reseña)
ORDER BY promedio_juego DESC;

-- 28. Mostrar los estudios desarrolladores que tienen mas de 2 juegos publicados.
SELECT d.nombre_estudio, d.pais, COUNT(dv.id_juego) AS total_juegos
FROM desarrollador d
JOIN desarrollador_videojuego dv ON d.id_cuenta = dv.id_cuenta_dev
JOIN videojuego               v  ON dv.id_juego = v.id_juego
WHERE v.estado_publicacion = 'publicado'
GROUP BY d.id_cuenta, d.nombre_estudio, d.pais
HAVING COUNT(dv.id_juego) > 2
ORDER BY total_juegos DESC;

-- 29. Mostrar los usuarios cuyo gasto total supera su saldo actual en billetera.
SELECT u.nombre_usuario, u.saldo_billetera,
       SUM(c.precio_pagado) AS total_gastado
FROM usuario u
JOIN compra c ON u.id_cuenta = c.id_cuenta_usuario
GROUP BY u.id_cuenta, u.nombre_usuario, u.saldo_billetera
HAVING SUM(c.precio_pagado) > u.saldo_billetera
ORDER BY total_gastado DESC;

-- 30. Listar las categorias mas populares segun la cantidad de compras de juegos en cada una.
SELECT cat.nombre AS categoria, COUNT(c.id_compra) AS total_compras
FROM categoria cat
JOIN videojuego_categoria vc ON cat.id_categoria = vc.id_categoria
JOIN compra               c  ON vc.id_juego      = c.id_juego
GROUP BY cat.id_categoria, cat.nombre
ORDER BY total_compras DESC;



-- 31. Resumen completo por juego: categorias, calificacion promedio, ventas e ingresos.
SELECT v.titulo,
       GROUP_CONCAT(DISTINCT cat.nombre ORDER BY cat.nombre SEPARATOR ', ') AS categorias,
       ROUND(AVG(r.calificacion), 1)      AS calificacion_promedio,
       COUNT(DISTINCT c.id_compra)        AS total_ventas,
       COALESCE(SUM(c.precio_pagado), 0)  AS ingresos_totales
FROM videojuego v
LEFT JOIN videojuego_categoria vc  ON v.id_juego      = vc.id_juego
LEFT JOIN categoria            cat ON vc.id_categoria = cat.id_categoria
LEFT JOIN reseña               r   ON v.id_juego      = r.id_juego
LEFT JOIN compra               c   ON v.id_juego      = c.id_juego
WHERE v.estado_publicacion = 'publicado'
GROUP BY v.id_juego, v.titulo
ORDER BY total_ventas DESC;

-- 32. Ranking de usuarios con total de compras, juegos en biblioteca y dinero gastado.
SELECT u.nombre_usuario, u.pais,
       COUNT(DISTINCT c.id_compra)       AS total_compras,
       COUNT(DISTINCT b.id_juego)        AS juegos_en_biblioteca,
       COALESCE(SUM(c.precio_pagado), 0) AS total_gastado,
       u.saldo_billetera
FROM usuario u
LEFT JOIN compra     c ON u.id_cuenta = c.id_cuenta_usuario
LEFT JOIN biblioteca b ON u.id_cuenta = b.id_cuenta_usuario
GROUP BY u.id_cuenta, u.nombre_usuario, u.pais, u.saldo_billetera
ORDER BY total_gastado DESC;

-- 33. Panel general de la plataforma: usuarios, juegos, compras, ingresos y desarrolladores activos.
SELECT 'Usuarios registrados'    AS metrica, COUNT(*)           AS valor FROM usuario
UNION ALL
SELECT 'Juegos publicados',       COUNT(*)           FROM videojuego WHERE estado_publicacion = 'publicado'
UNION ALL
SELECT 'Juegos pendientes',       COUNT(*)           FROM videojuego WHERE estado_publicacion = 'pendiente'
UNION ALL
SELECT 'Total de compras',        COUNT(*)           FROM compra
UNION ALL
SELECT 'Ingresos totales ($)',    SUM(precio_pagado) FROM compra
UNION ALL
SELECT 'Desarrolladores activos', COUNT(*)           FROM desarrollador WHERE autorizado = TRUE
UNION ALL
SELECT 'Reseñas publicadas',      COUNT(*)           FROM reseña;

-- 34. Mostrar los requisitos de hardware de los 3 juegos mas vendidos.
SELECT v.titulo, rh.tipo AS requisito, rh.so_requerido, rh.procesador,
       CONCAT(rh.memoria_ram_gb, ' GB') AS ram,
       rh.tarjeta_grafica,
       CONCAT(rh.vram_gb, ' GB')        AS vram
FROM videojuego v
JOIN requisitos_hardware rh ON v.id_juego = rh.id_juego
WHERE v.id_juego IN (
    SELECT id_juego FROM compra
    GROUP BY id_juego
    ORDER BY COUNT(*) DESC
    LIMIT 3
)
ORDER BY v.titulo, rh.tipo;