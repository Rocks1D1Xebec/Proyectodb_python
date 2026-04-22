INSERT INTO cuenta (correo, contraseña, fecha_registro, estado, tipo_cuenta) VALUES
-- Admins
('rivan@admin.com',    'scrypt:32768:8:1$VmuuojNViq73Yzys$22662bf6e640f26f1431eb2683d5b5793b4ec1f55e3b9e01fe0af418d052f27f6c706e8b4121dac4a4043359b85445c4bcca575e99732a9cb002f2bc9216c7ab', '2023-01-10', 'activo', 'administrador'),
('nyls@admin.com',     'scrypt:32768:8:1$ZW7GuqHqVxGPDgsS$b7d794b9447464c00c615ab917c91de5ec7a4f6fff5a95e8aa2af0f2f6256ebff1a8f43a4e307cd5dfd7b60167d0557448d2b9a5fd8ad49664b7e724bba7f7cf', '2023-01-12', 'activo', 'administrador'),
-- Desarrolladores (ids 3-14)
('dev1@dev.com',       'scrypt:32768:8:1$1Sc4jebeKKypCAWc$c77d19e82eee27a4dc7249b7122998f2ef969c85d57231a14d2bfd3bbaf6478f86190a5abf5b690f380add7fa50a013b8f076c1e0e633024997ecf9753fd9fe0', '2023-02-01', 'activo', 'desarrollador'),
('dev2@dev.com',       'scrypt:32768:8:1$Lzi31k3f8gR7LFwj$a20176f6d0e01f20ba5d04159c1b5654b620f4521b4cab45b93f23de5d5ef49522978842c480768f812df40b696bb10c61dc3e294e65b4727141ac6916c19bbd', '2023-02-05', 'activo', 'desarrollador'),
('pixelforge@dev.com', 'scrypt:32768:8:1$KrQKyp0H9zzMMLb3$3ac4543120b54e5065414f049552083395bcdff2d0d5ca79268ecd7cab6392e1ce52cb65d2ccfa95fe7af7bed3972cfaf3aecd34d9bba17a81d6ddd2702b9dd1', '2023-03-10', 'activo', 'desarrollador'),
('nightowl@dev.com',   'scrypt:32768:8:1$NA8bOk56zaGhZapJ$68550b25de6d400cb1df17cff7bd1d2f9b4fcd37cef0bdf72f344b477049d7b7573b563ef0d27d09cb8189a702c453e92e1084131057458a0f1a91ec377edaa3', '2023-04-15', 'activo', 'desarrollador'),
('redhorizon@dev.com', 'scrypt:32768:8:1$KrQKyp0H9zzMMLb3$3ac4543120b54e5065414f049552083395bcdff2d0d5ca79268ecd7cab6392e1ce52cb65d2ccfa95fe7af7bed3972cfaf3aecd34d9bba17a81d6ddd2702b9dd1', '2023-05-20', 'activo', 'desarrollador'),
('eightbit@dev.com',   'scrypt:32768:8:1$NA8bOk56zaGhZapJ$68550b25de6d400cb1df17cff7bd1d2f9b4fcd37cef0bdf72f344b477049d7b7573b563ef0d27d09cb8189a702c453e92e1084131057458a0f1a91ec377edaa3', '2023-06-01', 'activo', 'desarrollador'),
('gamedream@dev.com',  'scrypt:32768:8:1$1Sc4jebeKKypCAWc$c77d19e82eee27a4dc7249b7122998f2ef969c85d57231a14d2bfd3bbaf6478f86190a5abf5b690f380add7fa50a013b8f076c1e0e633024997ecf9753fd9fe0', '2023-07-10', 'activo', 'desarrollador'),
('stormgames@dev.com', 'scrypt:32768:8:1$Lzi31k3f8gR7LFwj$a20176f6d0e01f20ba5d04159c1b5654b620f4521b4cab45b93f23de5d5ef49522978842c480768f812df40b696bb10c61dc3e294e65b4727141ac6916c19bbd', '2023-08-05', 'activo', 'desarrollador'),
('cryptodev@dev.com',  'scrypt:32768:8:1$KrQKyp0H9zzMMLb3$3ac4543120b54e5065414f049552083395bcdff2d0d5ca79268ecd7cab6392e1ce52cb65d2ccfa95fe7af7bed3972cfaf3aecd34d9bba17a81d6ddd2702b9dd1', '2023-09-12', 'activo',     'desarrollador'),
('lunardev@dev.com',   'scrypt:32768:8:1$NA8bOk56zaGhZapJ$68550b25de6d400cb1df17cff7bd1d2f9b4fcd37cef0bdf72f344b477049d7b7573b563ef0d27d09cb8189a702c453e92e1084131057458a0f1a91ec377edaa3', '2023-09-20', 'activo',     'desarrollador'),
('apexstudio@dev.com', 'scrypt:32768:8:1$1Sc4jebeKKypCAWc$c77d19e82eee27a4dc7249b7122998f2ef969c85d57231a14d2bfd3bbaf6478f86190a5abf5b690f380add7fa50a013b8f076c1e0e633024997ecf9753fd9fe0', '2023-10-01', 'activo', 'desarrollador'),
('novagames@dev.com',  'scrypt:32768:8:1$Lzi31k3f8gR7LFwj$a20176f6d0e01f20ba5d04159c1b5654b620f4521b4cab45b93f23de5d5ef49522978842c480768f812df40b696bb10c61dc3e294e65b4727141ac6916c19bbd', '2023-10-15', 'activo', 'desarrollador'),
-- Usuarios (ids 15-28)
('usuario1@correo.com',  'scrypt:32768:8:1$NfdEeFJqbXrHh24b$0be35395668f6f6341552c84384e2958bd7787dab27a144c9385c8d43daf9f7161ddf7d04ad9f5630b0fabfc4fd3286a29b10d4124c6954af10ca0b66b010cc3', '2023-03-15', 'activo', 'usuario'),
('usuario2@correo.com',  'scrypt:32768:8:1$tg8y35wvOhrucYYM$455a4d86293dc8b6ef9608f1d4f8bbef104d174f1f12b315792b4b5c751fe51667959f19481ef86cfca635f68faaa6063e406ebb31d2e8ce774632ffab7e19f7', '2023-03-20', 'activo', 'usuario'),
('carlos.gm@correo.com', 'scrypt:32768:8:1$VwKUt2p029z0YyZR$d4631b4f77b5b9d4d7defd0572d7b013324ed7bae73d0856bf758d20f1199606f1df93dec717b705d97ad375a1ce4831e403111e687bcc884b2dcad8694c33ca', '2023-04-02', 'activo', 'usuario'),
('sofia.rs@correo.com',  'scrypt:32768:8:1$lIsJjLKiWgRbhQEw$b9ee882bee8510781f3006381e37335723cb6a89c2479a8c7f41e57063ec90662360af0f67bbe86b258dc9c2617253b419a6c03fcb061dddbb7d7a08260a4f71', '2023-04-10', 'activo', 'usuario'),
('andres.v@correo.com',  'scrypt:32768:8:1$bmCYMALBMraAKrv0$65f420866dd956cfc8f9eec554c80e547b64fbe511cffba9b093e41517a03ebc1b69c8c4bfd330f1d789c0938c62bf9693d7e92220722286a96b901b9bde3f7a', '2023-05-01', 'activo', 'usuario'),
('lucia.pt@correo.com',  'scrypt:32768:8:1$es1GwZEcWdLBjtp2$c1ba20ae7989ac0f743962297b3fd8e31087bfddf171301af4c874314602f2f06c6e23382e9ab0276ff11070d8ffa2fab05674c6e6fbec78159db73a55c474df', '2023-05-18', 'activo', 'usuario'),
('miguel.cl@correo.com', 'scrypt:32768:8:1$CjfWNeyAJgOXEmK5$c79d6888961c8615e26ffb64c70f2f2e6ba259cfcc6080bf65a01b761ac244011ec458cf690e0926492e5394c6c4aa17c3b64418cedc205ef23f4ce2e716da70', '2023-06-05', 'activo', 'usuario'),
('ana.bo@correo.com',    'scrypt:32768:8:1$VX4e34g3VEaXZgBF$73cfa43ac5b58c769cd04d0748613f8839c767964c59b55529c293b3f7cfcd9f2d9070e6219b565ce9bbc6142af710385c64caa33483fc96c3cc7be58c39ab98', '2023-06-20', 'activo', 'usuario'),
('pedro.ar@correo.com',  'scrypt:32768:8:1$S0w8rFYL47VuDsaa$43e6701b5e6f613760b479f81c27c57de5675ce31e8aa26c95f55e0ab992b6432d28e9a1518426b30583daae9af3f965591444d22a7cb42a0399a52fdfdf9205', '2023-07-08', 'activo', 'usuario'),
('valentina.co@correo.com','scrypt:32768:8:1$m4dqMp32fDiLPw7G$625d5ae896cbe7b2c225b02fc52e7bb2c599ecf0717bad267163fec618a44301957a5f860347515c988f2a511190ffd8e62a3300b487892977294288806606ad','2023-07-25','activo','usuario'),
('jose.mx@correo.com',   'scrypt:32768:8:1$7Xlo6ZW9w9VAKScz$ce82c704c454b725dfd1b85459711bb6d42a7e48c397fb7f724e1a25af64e7c878c503cd8a91477fee4d13aab553511b8ef18bcdc5ce388fe94b1068790cb04a', '2023-08-10', 'activo', 'usuario'),
('maria.pe@correo.com',  'scrypt:32768:8:1$JDAvIe5DjHyf8dbq$f5d30c8ff762cdee548e9481f784691ab44ed50d5bcf8a510ede584294e34d7735a5e79ae6b0e8e93be78963911afef0cdef351084dfa44054592a2175b2c0af', '2023-08-22', 'activo', 'usuario'),
('roberto.uy@correo.com','scrypt:32768:8:1$0RIRlqKWNJLEA4M9$6b9f880fd55717cb36b1f8265bc6e509ef2ed264f91fc49f0b054115bbf11b5277ad0b9801bd084198d9e2519dd631dba8a1f9bdd505c8db5e9a03449a4804a4', '2023-09-05', 'activo', 'usuario'),
('claudia.ec@correo.com','scrypt:32768:8:1$RXehZFreN5nmn9hS$5b5a9ca25ff67c78780450e1078d4ad63409162aaafda8a61e10d3de79669cba09dea0d38fabeff116ebf1e9396f96514b62acc06c1e7c6f727cfcab557960fd', '2023-09-18', 'activo', 'usuario');


INSERT INTO administrador (id_cuenta, nombre_completo, nivel_acceso) VALUES
(1, 'Mauricio Salces',   3),
(2, 'Nyls Apaza', 3);


INSERT INTO desarrollador (id_cuenta, nombre_estudio, pais, sitio_web, autorizado, fecha_autorizacion) VALUES
(3,  'Desarrollador 1',   'Bolivia',   'https://dev1.io',          1, '2023-02-15'),
(4,  'Desarrollador 2',   'Bolivia',   'https://dev2.io',          1, '2023-02-20'),
(5,  'PixelForge Studios','Argentina', 'https://pixelforge.dev',   1, '2023-03-25'),
(6,  'NightOwl Games',    'Colombia',  'https://nightowlgames.com',1, '2023-05-01'),
(7,  'Red Horizon Dev',   'Chile',     'https://redhorizon.cl',    1, '2023-06-05'),
(8,  '8Bit Studios',      'Mexico',    'https://8bitstudios.mx',   1, '2023-06-20'),
(9,  'GameDream Co',      'Peru',      NULL,                        0, NULL),
(10, 'Storm Games',       'Uruguay',   NULL,                        0, NULL),
(11, 'Crypto Dev',        'Venezuela', NULL,                        0, NULL),
(12, 'Lunar Dev',         'Ecuador',   NULL,                        0, NULL),
(13, 'Apex Studio',       'Paraguay',  'https://apexstudio.com',   1, '2023-10-10'),
(14, 'Nova Games',        'Brasil',    'https://novagames.br',     1, '2023-10-25');


INSERT INTO usuario (id_cuenta, nombre_usuario, nombre, apellido, fecha_nacimiento, pais, saldo_billetera) VALUES
(15, 'usuario1',   'Usuario',    'Uno',        '2000-05-14', 'Bolivia',   120.00),
(16, 'usuario2',   'Usuario',    'Dos',        '1998-11-22', 'Bolivia',   85.50),
(17, 'carlosgm',   'Carlos',     'Gomez',      '1995-03-08', 'Bolivia',   200.00),
(18, 'sofiars',    'Sofia',      'Ramirez',    '2001-07-19', 'Argentina', 50.00),
(19, 'andresv',    'Andres',     'Vargas',     '1997-01-30', 'Colombia',  310.75),
(20, 'luciap',     'Lucia',      'Paredes',    '2002-09-05', 'Chile',     0.00),
(21, 'miguelcl',   'Miguel',     'Castro',     '1999-12-12', 'Mexico',    145.20),
(22, 'anabo',      'Ana',        'Bolivar',    '2003-04-25', 'Peru',      60.00),
(23, 'pedroar',    'Pedro',      'Arce',       '1996-08-17', 'Uruguay',   500.00),
(24, 'valentinac', 'Valentina',  'Correa',     '2000-02-28', 'Colombia',  75.00),
(25, 'josemx',     'Jose',       'Martinez',   '1994-06-11', 'Mexico',    220.00),
(26, 'mariape',    'Maria',      'Perez',      '2001-10-03', 'Peru',      30.00),
(27, 'robertouy',  'Roberto',    'Ugarte',     '1993-07-07', 'Uruguay',   400.00),
(28, 'claudiaec',  'Claudia',    'Estrada',    '1998-03-15', 'Ecuador',   95.50);


INSERT INTO categoria (nombre) VALUES
('Acción'),
('Aventura'),
('RPG'),
('Estrategia'),
('Simulación'),
('Terror'),
('Plataformas'),
('Puzzle'),
('Carreras'),
('Shooter'),
('Indie'),
('Multijugador');


INSERT INTO videojuego (titulo, descripcion, precio_base, fecha_lanzamiento, estado_publicacion, portada_url, tamaño_gb, motivo_rechazo, fecha_solicitud) VALUES
-- Publicados (15)
('Abyssal Chronicle',   'RPG de mundo abierto ambientado en océanos alienígenas.',                              29.99, '2023-05-01', 'publicado',  NULL, 18.50, NULL, '2023-04-10 09:00:00'),
('Shadow Protocol',     'Thriller táctico de sigilo con historia ramificada.',                                   24.99, '2023-06-15', 'publicado',  NULL,  9.20, NULL, '2023-05-20 10:30:00'),
('Crimson Frontier',    'Estrategia por turnos ambientada en un futuro post-apocalíptico.',                      19.99, '2023-07-20', 'publicado',  NULL,  6.80, NULL, '2023-06-25 14:00:00'),
('Neon Runners',        'Carreras futuristas en ciudades flotantes con personalización total.',                  14.99, '2023-08-10', 'publicado',  NULL, 12.30, NULL, '2023-07-15 11:00:00'),
('Echoes of Eternity',  'Aventura narrativa con mecánicas de viaje en el tiempo.',                              34.99, '2023-09-05', 'publicado',  NULL, 22.00, NULL, '2023-08-01 08:00:00'),
('Void Siege',          'Defensa de base en tiempo real contra oleadas de enemigos cósmicos.',                  17.99, '2023-10-01', 'publicado',  NULL,  5.60, NULL, '2023-09-05 13:00:00'),
('Phantom Depths',      'Survival horror submarino con exploración y rompecabezas.',                            22.99, '2023-11-01', 'publicado',  NULL, 15.40, NULL, '2023-10-02 16:00:00'),
('Solar Drift',         'Simulador de colonización espacial con gestión de recursos.',                          27.99, '2023-11-20', 'publicado',  NULL, 10.70, NULL, '2023-10-25 09:30:00'),
('Iron Bastion',        'Shooter en primera persona ambientado en fortalezas medievales retrofuturistas.',      21.99, '2023-12-05', 'publicado',  NULL,  8.90, NULL, '2023-11-10 10:00:00'),
('Crystal Labyrinth',   'Puzzle de lógica espacial con más de 200 niveles y editor de mapas.',                  9.99,  '2024-01-10', 'publicado',  NULL,  3.20, NULL, '2023-12-15 15:00:00'),
('Dark Horizon',        'Shooter táctico con modo campaña cooperativo y modos PvP.',                            26.99, '2024-02-14', 'publicado',  NULL, 14.60, NULL, '2024-01-20 11:00:00'),
('Arcane Realms',       'MMORPG de fantasía con un mundo persistente y gremios jugables.',                      39.99, '2024-03-01', 'publicado',  NULL, 35.80, NULL, '2024-02-05 08:00:00'),
('Turbo Rush',          'Carreras arcade caóticas con armas y pistas generadas proceduralmente.',               12.99, '2024-04-05', 'publicado',  NULL,  4.50, NULL, '2024-03-10 14:00:00'),
('Lost Sanctum',        'Aventura de exploración en ruinas antiguas con narrativa no lineal.',                  18.99, '2024-05-12', 'publicado',  NULL, 11.20, NULL, '2024-04-15 10:00:00'),
('Pixel Warriors',      'Plataformas cooperativo local con más de 30 personajes desbloqueables.',               11.99, '2024-06-20', 'publicado',  NULL,  2.80, NULL, '2024-05-25 09:00:00'),
-- Pendientes (3)
('Gravity Storm',       'Acción de plataformas con mecánicas de gravedad inversa.',                             19.99, NULL,         'pendiente',  NULL,  7.30, NULL, '2024-07-01 12:00:00'),
('Ocean Tycoon',        'Simulador de gestión de acuarios y ecosistemas marinos.',                              24.99, NULL,         'pendiente',  NULL,  9.10, NULL, '2024-07-10 15:00:00'),
('Stellar Conflict',    'Shooter espacial multijugador masivo online.',                                         29.99, NULL,         'pendiente',  NULL, 16.00, NULL, '2024-07-20 10:00:00'),
-- Rechazado (1)
('Blade Legacy',        'RPG de acción con sistema de combate basado en física.',                               22.99, NULL,         'rechazado',  NULL, 13.50, 'El contenido incluye violencia excesiva no clasificada correctamente.', '2024-06-15 11:00:00'),
-- Retirado (1)
('Toxic Realm',         'Survival multijugador en zonas contaminadas post-guerra.',                             15.99, '2024-05-01', 'retirado',   NULL,  8.40, 'Violación de términos de servicio: monetización abusiva reportada por usuarios.', '2024-04-01 09:00:00');


-- dev1 (id=3): rechazada primero, luego aprobada
INSERT INTO solicitud_autorizacion (id_cuenta_dev, id_cuenta_admin, fecha_solicitud, fecha_resolucion, estado, motivo_rechazo) VALUES
(3, 1, '2023-02-01', '2023-02-08', 'rechazada', 'Documentación incompleta en el primer envío.'),
(3, 1, '2023-02-10', '2023-02-15', 'aprobada',  NULL),
-- dev2 (id=4): rechazada primero, luego aprobada
(4, 2, '2023-02-05', '2023-02-12', 'rechazada', 'Sitio web no accesible al momento de la revisión.'),
(4, 2, '2023-02-14', '2023-02-20', 'aprobada',  NULL),
-- dev3 PixelForge (id=5): rechazada, reaprobada
(5, 1, '2023-03-10', '2023-03-17', 'rechazada', 'Portfolio de juegos insuficiente.'),
(5, 1, '2023-03-20', '2023-03-25', 'aprobada',  NULL),
-- dev4 NightOwl (id=6): rechazada, reaprobada
(6, 2, '2023-04-15', '2023-04-22', 'rechazada', 'Información del estudio incompleta.'),
(6, 2, '2023-04-25', '2023-05-01', 'aprobada',  NULL),
-- dev5 RedHorizon (id=7): rechazada, reaprobada
(7, 1, '2023-05-20', '2023-05-27', 'rechazada', 'Términos de uso no aceptados correctamente.'),
(7, 1, '2023-05-29', '2023-06-05', 'aprobada',  NULL),
-- dev6 8Bit (id=8): aprobada directamente
(8, 2, '2023-06-01', '2023-06-10', 'aprobada',  NULL),
-- dev7 GameDream (id=9): pendiente
(9, NULL, '2023-07-10', NULL, 'pendiente', NULL),
-- dev8 Storm (id=10): pendiente
(10, NULL, '2023-08-05', NULL, 'pendiente', NULL),
-- dev9 Crypto (id=11): rechazada, luego reaprobada pendiente
(11, 1, '2023-09-12', '2023-09-19', 'rechazada', 'No cumple con política de contenido mínimo.'),
(11, NULL, '2023-09-25', NULL, 'pendiente', NULL),
-- dev10 Lunar (id=12): rechazada, luego reaprobada pendiente
(12, 2, '2023-09-20', '2023-09-27', 'rechazada', 'Sitio web con contenido inadecuado.'),
(12, NULL, '2023-10-01', NULL, 'pendiente', NULL),
-- dev11 Apex (id=13): aprobada directamente
(13, 1, '2023-10-01', '2023-10-10', 'aprobada',  NULL),
-- dev12 Nova (id=14): aprobada directamente
(14, 2, '2023-10-15', '2023-10-25', 'aprobada',  NULL);


INSERT INTO requisitos_hardware (id_juego, tipo, so_requerido, procesador, memoria_ram_gb, almacenamiento_gb, tarjeta_grafica, vram_gb, directx_version) VALUES
-- Juego 1: Abyssal Chronicle
(1,'minimo',    'Windows 10 64-bit', 'Intel Core i5-8400',       8,  20, 'NVIDIA GTX 1060',    4, 'DirectX 11'),
(1,'recomendado','Windows 10 64-bit','Intel Core i7-10700K',     16, 25, 'NVIDIA RTX 3070',    8, 'DirectX 12'),
-- Juego 2: Shadow Protocol
(2,'minimo',    'Windows 10 64-bit', 'AMD Ryzen 5 2600',          8, 12, 'AMD RX 580',         4, 'DirectX 11'),
(2,'recomendado','Windows 11 64-bit','AMD Ryzen 7 5800X',        16, 15, 'AMD RX 6700 XT',     8, 'DirectX 12'),
-- Juego 3: Crimson Frontier
(3,'minimo',    'Windows 10 64-bit', 'Intel Core i5-6500',        4,  8, 'NVIDIA GTX 970',     2, 'DirectX 11'),
(3,'recomendado','Windows 10 64-bit','Intel Core i7-9700',        8, 10, 'NVIDIA GTX 1080',    6, 'DirectX 12'),
-- Juego 4: Neon Runners
(4,'minimo',    'Windows 10 64-bit', 'Intel Core i5-8600',        8, 15, 'NVIDIA GTX 1070',    4, 'DirectX 11'),
(4,'recomendado','Windows 11 64-bit','Intel Core i9-11900K',     16, 18, 'NVIDIA RTX 3080',    10,'DirectX 12'),
-- Juego 5: Echoes of Eternity
(5,'minimo',    'Windows 10 64-bit', 'AMD Ryzen 5 3600',         12, 25, 'NVIDIA RTX 2060',    6, 'DirectX 12'),
(5,'recomendado','Windows 11 64-bit','AMD Ryzen 9 5900X',        24, 30, 'NVIDIA RTX 3090',    24,'DirectX 12'),
-- Juego 6: Void Siege
(6,'minimo',    'Windows 10 64-bit', 'Intel Core i5-7500',        8,  8, 'AMD RX 570',         4, 'DirectX 11'),
(6,'recomendado','Windows 10 64-bit','Intel Core i7-10700',      16, 10, 'AMD RX 5700 XT',     8, 'DirectX 12'),
-- Juego 7: Phantom Depths
(7,'minimo',    'Windows 10 64-bit', 'Intel Core i7-7700',        8, 18, 'NVIDIA GTX 1080',    4, 'DirectX 11'),
(7,'recomendado','Windows 11 64-bit','Intel Core i9-10900',      16, 20, 'NVIDIA RTX 3070 Ti', 8, 'DirectX 12'),
-- Juego 8: Solar Drift
(8,'minimo',    'Windows 10 64-bit', 'AMD Ryzen 5 2600X',         8, 14, 'AMD RX 5600 XT',     6, 'DirectX 11'),
(8,'recomendado','Windows 10 64-bit','AMD Ryzen 7 3700X',        16, 16, 'AMD RX 6600 XT',     8, 'DirectX 12'),
-- Juego 9: Iron Bastion
(9,'minimo',    'Windows 10 64-bit', 'Intel Core i5-9400F',       8, 12, 'NVIDIA GTX 1060 6GB',4, 'DirectX 11'),
(9,'recomendado','Windows 10 64-bit','Intel Core i7-9700K',      16, 14, 'NVIDIA RTX 2070',    8, 'DirectX 12'),
-- Juego 10: Crystal Labyrinth
(10,'minimo',   'Windows 7 64-bit',  'Intel Core i3-7100',        4,  5, 'NVIDIA GTX 950',     2, 'DirectX 11'),
(10,'recomendado','Windows 10 64-bit','Intel Core i5-8400',        8,  6, 'NVIDIA GTX 1060',    4, 'DirectX 11'),
-- Juego 11: Dark Horizon
(11,'minimo',   'Windows 10 64-bit', 'AMD Ryzen 5 3500X',         8, 18, 'AMD RX 5500 XT',     4, 'DirectX 11'),
(11,'recomendado','Windows 11 64-bit','AMD Ryzen 7 5700X',        16, 20, 'AMD RX 6700 XT',     8, 'DirectX 12'),
-- Juego 12: Arcane Realms
(12,'minimo',   'Windows 10 64-bit', 'Intel Core i7-8700K',      16, 40, 'NVIDIA GTX 1080 Ti', 8, 'DirectX 12'),
(12,'recomendado','Windows 11 64-bit','Intel Core i9-12900K',     32, 45, 'NVIDIA RTX 4080',    16,'DirectX 12'),
-- Juego 13: Turbo Rush
(13,'minimo',   'Windows 10 64-bit', 'Intel Core i5-7400',        4,  6, 'NVIDIA GTX 760',     2, 'DirectX 11'),
(13,'recomendado','Windows 10 64-bit','Intel Core i7-8700',        8,  8, 'NVIDIA GTX 1070 Ti', 4, 'DirectX 12'),
-- Juego 14: Lost Sanctum
(14,'minimo',   'Windows 10 64-bit', 'AMD Ryzen 5 1600',          8, 14, 'AMD RX 480',         4, 'DirectX 11'),
(14,'recomendado','Windows 10 64-bit','AMD Ryzen 7 2700X',        16, 16, 'AMD RX 5700',        8, 'DirectX 12'),
-- Juego 15: Pixel Warriors
(15,'minimo',   'Windows 7 64-bit',  'Intel Core i3-6100',        4,  4, 'NVIDIA GTX 750 Ti',  2, 'DirectX 11'),
(15,'recomendado','Windows 10 64-bit','Intel Core i5-8400',        8,  5, 'NVIDIA GTX 1050 Ti', 4, 'DirectX 11'),
-- Juego 16: Gravity Storm (pendiente)
(16,'minimo',   'Windows 10 64-bit', 'Intel Core i5-8600K',       8,  9, 'NVIDIA GTX 1060 6GB',4, 'DirectX 11'),
(16,'recomendado','Windows 10 64-bit','Intel Core i7-10700K',     16, 12, 'NVIDIA RTX 2080',    8, 'DirectX 12'),
-- Juego 17: Ocean Tycoon (pendiente)
(17,'minimo',   'Windows 10 64-bit', 'AMD Ryzen 5 3600',          8, 12, 'AMD RX 5600 XT',     6, 'DirectX 11'),
(17,'recomendado','Windows 11 64-bit','AMD Ryzen 9 5950X',        16, 14, 'AMD RX 6800 XT',     16,'DirectX 12'),
-- Juego 18: Stellar Conflict (pendiente)
(18,'minimo',   'Windows 10 64-bit', 'Intel Core i7-8700',       16, 18, 'NVIDIA RTX 2060',    6, 'DirectX 12'),
(18,'recomendado','Windows 11 64-bit','Intel Core i9-11900K',     32, 22, 'NVIDIA RTX 3080 Ti', 12,'DirectX 12'),
-- Juego 19: Blade Legacy (rechazado)
(19,'minimo',   'Windows 10 64-bit', 'AMD Ryzen 5 3600X',         8, 16, 'AMD RX 5700 XT',     8, 'DirectX 12'),
(19,'recomendado','Windows 11 64-bit','AMD Ryzen 9 5900X',        16, 18, 'AMD RX 6900 XT',     16,'DirectX 12'),
-- Juego 20: Toxic Realm (retirado)
(20,'minimo',   'Windows 10 64-bit', 'Intel Core i5-8400',        8, 10, 'NVIDIA GTX 1070',    4, 'DirectX 11'),
(20,'recomendado','Windows 10 64-bit','Intel Core i7-9700K',      16, 12, 'NVIDIA RTX 2070',    8, 'DirectX 12');


INSERT INTO desarrollador_videojuego (id_cuenta_dev, id_juego, rol, fecha_asociacion) VALUES
-- dev1 (Desarrollador 1) — principal en juegos 1-3
(3,  1, 'desarrollador_principal', '2023-04-10'),
(3,  2, 'desarrollador_principal', '2023-05-20'),
(3,  3, 'desarrollador_principal', '2023-06-25'),
-- dev2 (Desarrollador 2) — principal en juegos 4-6
(4,  4, 'desarrollador_principal', '2023-07-15'),
(4,  5, 'desarrollador_principal', '2023-08-01'),
(4,  6, 'desarrollador_principal', '2023-09-05'),
-- PixelForge (id=5) — principal en juegos 7-9
(5,  7, 'desarrollador_principal', '2023-10-02'),
(5,  8, 'desarrollador_principal', '2023-10-25'),
(5,  9, 'desarrollador_principal', '2023-11-10'),
-- NightOwl (id=6) — principal en juegos 10-12
(6, 10, 'desarrollador_principal', '2023-12-15'),
(6, 11, 'desarrollador_principal', '2024-01-20'),
(6, 12, 'desarrollador_principal', '2024-02-05'),
-- RedHorizon (id=7) — principal en juegos 13-15
(7, 13, 'desarrollador_principal', '2024-03-10'),
(7, 14, 'desarrollador_principal', '2024-04-15'),
(7, 15, 'desarrollador_principal', '2024-05-25'),
-- 8Bit (id=8) — principal en juegos 16-17 + colaborador en juego 19
(8, 16, 'desarrollador_principal', '2024-07-01'),
(8, 17, 'desarrollador_principal', '2024-07-10'),
-- Apex (id=13) — principal en juego 18 y 19
(13, 18, 'desarrollador_principal', '2024-07-20'),
(13, 19, 'desarrollador_principal', '2024-06-15'),
-- Nova (id=14) — principal en juego 20
(14, 20, 'desarrollador_principal', '2024-04-01'),
-- Colaboradores cruzados
(4,  1, 'colaborador', '2023-04-12'),  -- dev2 colabora en juego 1
(3,  4, 'colaborador', '2023-07-16'),  -- dev1 colabora en juego 4
(6,  7, 'colaborador', '2023-10-05'),  -- NightOwl colabora en juego 7
(5, 10, 'colaborador', '2023-12-16'),  -- PixelForge colabora en juego 10
(7, 12, 'colaborador', '2024-02-07');  -- RedHorizon colabora en juego 12


INSERT INTO videojuego_categoria (id_juego, id_categoria) VALUES
(1,  3),
(1,  2), 
(2,  1), 
(2, 10),
(3,  4),
(3, 12),
(4,  9),
(4, 12), 
(5,  2), 
(5,  3),  
(6,  4),  
(6,  1), 
(7,  6),  
(7,  2),  
(8,  5),  
(8, 11),  
(9,  1),  
(9, 10),  
(10, 8),  
(10,11), 
(11,10), 
(11,12),  
(12, 3),  
(12,12),  
(13, 9), 
(13, 1),  
(14, 2),  
(15, 7),  
(16, 1),  
(18,10);  


INSERT INTO compra (id_cuenta_usuario, id_juego, fecha_compra, precio_pagado, metodo_pago) VALUES
(15,  1, '2023-05-05 10:23:00', 29.99, 'tarjeta'),
(15,  2, '2023-06-20 14:10:00', 24.99, 'billetera'),
(15,  5, '2023-09-10 09:00:00', 34.99, 'tarjeta'),
(16,  4, '2023-08-15 18:30:00', 14.99, 'tarjeta'),
(16,  6, '2023-10-05 11:00:00', 17.99, 'billetera'),
(16, 10, '2024-01-15 20:00:00',  9.99, 'tarjeta'),
(17,  1, '2023-05-10 08:45:00', 29.99, 'billetera'),
(17,  3, '2023-07-25 17:00:00', 19.99, 'tarjeta'),
(17, 12, '2024-03-05 12:30:00', 39.99, 'billetera'),
(18,  7, '2023-11-05 21:00:00', 22.99, 'tarjeta'),
(18, 13, '2024-04-10 16:45:00', 12.99, 'billetera'),
(19,  5, '2023-09-08 13:20:00', 34.99, 'tarjeta'),
(19,  9, '2023-12-10 19:00:00', 21.99, 'billetera'),
(19, 11, '2024-02-18 10:10:00', 26.99, 'tarjeta'),
(20, 15, '2024-06-25 22:00:00', 11.99, 'tarjeta'),
(21,  2, '2023-06-22 09:15:00', 24.99, 'billetera'),
(21,  8, '2023-11-22 14:00:00', 27.99, 'tarjeta'),
(22, 10, '2024-01-20 18:30:00',  9.99, 'billetera'),
(22, 15, '2024-06-28 11:00:00', 11.99, 'tarjeta'),
(23,  1, '2023-05-12 07:30:00', 29.99, 'tarjeta'),
(23, 12, '2024-03-08 16:00:00', 39.99, 'billetera'),
(24,  4, '2023-08-20 20:15:00', 14.99, 'tarjeta'),
(25,  6, '2023-10-08 10:00:00', 17.99, 'billetera'),
(26, 14, '2024-05-18 15:30:00', 18.99, 'tarjeta'),
(27, 11, '2024-02-20 09:00:00', 26.99, 'billetera');


INSERT INTO biblioteca (id_cuenta_usuario, id_juego, fecha_agregado) VALUES
(15,  1, '2023-05-05'),
(15,  2, '2023-06-20'),
(15,  5, '2023-09-10'),
(16,  4, '2023-08-15'),
(16,  6, '2023-10-05'),
(16, 10, '2024-01-15'),
(17,  1, '2023-05-10'),
(17,  3, '2023-07-25'),
(17, 12, '2024-03-05'),
(18,  7, '2023-11-05'),
(18, 13, '2024-04-10'),
(19,  5, '2023-09-08'),
(19,  9, '2023-12-10'),
(19, 11, '2024-02-18'),
(20, 15, '2024-06-25'),
(21,  2, '2023-06-22'),
(21,  8, '2023-11-22'),
(22, 10, '2024-01-20'),
(22, 15, '2024-06-28'),
(23,  1, '2023-05-12'),
(23, 12, '2024-03-08'),
(24,  4, '2023-08-20'),
(25,  6, '2023-10-08'),
(26, 14, '2024-05-18'),
(27, 11, '2024-02-20');


INSERT INTO reseña (id_cuenta_usuario, id_juego, calificacion, comentario, fecha, util_votos) VALUES
(15,  1, 5, 'Historia increíble, el mundo submarino es alucinante. Lo recomiendo al 100%.', '2023-05-20', 42),
(15,  2, 4, 'Buen juego de sigilo, aunque algunos niveles son demasiado difíciles.', '2023-07-01', 18),
(15,  5, 5, 'El viaje en el tiempo está implementado de forma brillante. Obra maestra.', '2023-10-01', 61),
(16,  4, 4, 'Muy entretenido para jugar en ratos libres. Las pistas flotantes se ven geniales.', '2023-09-05', 27),
(16,  6, 3, 'Entretenido pero se vuelve repetitivo rápido. Necesita más variedad de enemigos.', '2023-11-10', 9),
(16, 10, 5, 'Adictivo al máximo. El editor de mapas es un plus enorme.', '2024-02-01', 33),
(17,  1, 4, 'Excelente ambientación, aunque la curva de aprendizaje del combate es alta.', '2023-05-25', 15),
(17,  3, 3, 'Buena estrategia pero le falta pulido en la interfaz.', '2023-08-10', 7),
(17, 12, 5, 'El mejor MMORPG que he jugado en años. Los gremios están muy bien implementados.', '2024-03-20', 88),
(18,  7, 5, 'Aterrador desde el primer minuto. Los puzzles están integrados de forma perfecta.', '2023-11-20', 55),
(18, 13, 4, 'Carreras locas y divertidas. Perfecto para pasar el rato con amigos.', '2024-04-25', 22),
(19,  5, 5, 'Una experiencia narrativa única. No existe nada igual.', '2023-09-20', 70),
(19,  9, 3, 'Correcto, pero los niveles se sienten algo lineales. Le falta libertad.', '2024-01-05', 11),
(19, 11, 4, 'Muy sólido en cooperativo. El modo PvP necesita más mapas.', '2024-03-01', 38),
(20, 15, 4, 'Muy divertido y colorido. Los personajes desbloqueables son geniales.', '2024-07-10', 19),
(21,  2, 3, 'La historia está bien pero el sigilo puede ser frustrante.', '2023-07-05', 6),
(21,  8, 5, 'El mejor simulador espacial que existe. Horas y horas de contenido.', '2023-12-10', 47),
(22, 10, 5, 'Simple pero completamente adictivo. Los 200 niveles no son suficientes.', '2024-02-10', 29),
(23,  1, 4, 'Mundo enorme y bien construido. Quizás demasiado largo para mi gusto.', '2023-05-18', 12),
(23, 12, 5, 'Arcane Realms me robó 400 horas y no me arrepiento ni un poco.', '2024-04-01', 95),
(25,  6, 4, 'Divertido en multijugador. La dificultad está bien balanceada.', '2023-10-20', 16);