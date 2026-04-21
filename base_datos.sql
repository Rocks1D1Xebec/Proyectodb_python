create database if not exists tienda_videojuegos;
use tienda_videojuegos;

CREATE TABLE cuenta (
    id_cuenta       INT             PRIMARY KEY AUTO_INCREMENT,
    correo          VARCHAR(100)    NOT NULL UNIQUE,
    contraseña      VARCHAR(255)    NOT NULL,
    fecha_registro  DATE            NOT NULL,
    estado          ENUM('activo','suspendido') NOT NULL,
    tipo_cuenta     ENUM('administrador','desarrollador','usuario') NOT NULL
);

CREATE TABLE administrador (
    id_cuenta       INT             PRIMARY KEY,
    nombre_completo VARCHAR(100)    NOT NULL,
    nivel_acceso    INT             NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES cuenta(id_cuenta)
);


CREATE TABLE desarrollador (
    id_cuenta           INT             PRIMARY KEY,
    nombre_estudio      VARCHAR(100)    NOT NULL,
    pais                VARCHAR(60)     NOT NULL,
    sitio_web           VARCHAR(255)    NULL,
    autorizado          BOOLEAN         NOT NULL,
    fecha_autorizacion  DATE            NULL,
    FOREIGN KEY (id_cuenta) REFERENCES cuenta(id_cuenta)
);


CREATE TABLE usuario (
    id_cuenta           INT             PRIMARY KEY,
    nombre_usuario      VARCHAR(50)     NOT NULL UNIQUE,
    nombre              VARCHAR(60)     NOT NULL,
    apellido            VARCHAR(60)     NOT NULL,
    fecha_nacimiento    DATE            NOT NULL,
    pais                VARCHAR(60)     NOT NULL,
    saldo_billetera     DECIMAL(10,2)   NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES cuenta(id_cuenta)
);


CREATE TABLE videojuego (
    id_juego            INT             PRIMARY KEY AUTO_INCREMENT,
    titulo              VARCHAR(150)    NOT NULL,
    descripcion         TEXT            NULL,
    precio_base         DECIMAL(10,2)   NOT NULL,
    fecha_lanzamiento   DATE            NULL,
    estado_publicacion  ENUM('pendiente','publicado','rechazado','retirado') NOT NULL,
    portada_url         VARCHAR(255)    NULL,
    tamaño_gb           DECIMAL(6,2)    NOT NULL,
    motivo_rechazo      TEXT            NULL,
    fecha_solicitud     DATETIME        DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categoria (
    id_categoria    INT             PRIMARY KEY AUTO_INCREMENT,
    nombre          VARCHAR(80)     NOT NULL UNIQUE
);

CREATE TABLE solicitud_autorizacion (
    id_solicitud        INT             PRIMARY KEY AUTO_INCREMENT,
    id_cuenta_dev       INT             NOT NULL,
    id_cuenta_admin     INT             NULL,
    fecha_solicitud     DATE            NOT NULL,
    fecha_resolucion    DATE            NULL,
    estado              ENUM('pendiente','aprobada','rechazada') NOT NULL,
    motivo_rechazo      TEXT            NULL,
    FOREIGN KEY (id_cuenta_dev)   REFERENCES desarrollador(id_cuenta),
    FOREIGN KEY (id_cuenta_admin) REFERENCES administrador(id_cuenta)
);

CREATE TABLE reseña (
    id_reseña           INT             PRIMARY KEY AUTO_INCREMENT,
    id_cuenta_usuario   INT             NOT NULL,
    id_juego            INT             NOT NULL,
    calificacion        INT             NOT NULL,
    comentario          TEXT            NULL,
    fecha        DATE            NOT NULL,
    util_votos          INT             NOT NULL,
    CONSTRAINT chk_calificacion CHECK (calificacion BETWEEN 1 AND 5),
    UNIQUE (id_cuenta_usuario, id_juego),
    FOREIGN KEY (id_cuenta_usuario) REFERENCES usuario(id_cuenta),
    FOREIGN KEY (id_juego)          REFERENCES videojuego(id_juego)
);

CREATE TABLE requisitos_hardware (
    id_juego                INT             NOT NULL,
    tipo                    ENUM('minimo','recomendado') NOT NULL,
    so_requerido            VARCHAR(100)    NOT NULL,
    procesador              VARCHAR(150)    NOT NULL,
    memoria_ram_gb          INT             NOT NULL,
    almacenamiento_gb       INT             NOT NULL,
    tarjeta_grafica         VARCHAR(150)    NOT NULL,
    vram_gb                 INT             NOT NULL,
    directx_version         VARCHAR(20)     NOT NULL,
    notas_adicionales       TEXT            NULL,
    PRIMARY KEY (id_juego, tipo),
    FOREIGN KEY (id_juego) REFERENCES videojuego(id_juego)
);

CREATE TABLE compra (
    id_compra           INT             PRIMARY KEY AUTO_INCREMENT,
    id_cuenta_usuario   INT             NOT NULL,
    id_juego            INT             NOT NULL,
    fecha_compra        DATETIME        NOT NULL,
    precio_pagado       DECIMAL(10,2)   NOT NULL,
    metodo_pago         ENUM('billetera','tarjeta') NOT NULL,
    FOREIGN KEY (id_cuenta_usuario) REFERENCES usuario(id_cuenta),
    FOREIGN KEY (id_juego)          REFERENCES videojuego(id_juego)
);

CREATE TABLE biblioteca (
    id_cuenta_usuario   INT             NOT NULL,
    id_juego            INT             NOT NULL,
    fecha_agregado      DATE            NOT NULL,
    PRIMARY KEY (id_cuenta_usuario, id_juego),
    FOREIGN KEY (id_cuenta_usuario) REFERENCES usuario(id_cuenta),
    FOREIGN KEY (id_juego)          REFERENCES videojuego(id_juego)
);

CREATE TABLE desarrollador_videojuego (
    id_cuenta_dev       INT             NOT NULL,
    id_juego            INT             NOT NULL,
    rol                 ENUM('desarrollador_principal','colaborador') NOT NULL,
    fecha_asociacion    DATE            NOT NULL,
    PRIMARY KEY (id_cuenta_dev, id_juego),
    FOREIGN KEY (id_cuenta_dev) REFERENCES desarrollador(id_cuenta),
    FOREIGN KEY (id_juego)      REFERENCES videojuego(id_juego)
);

CREATE TABLE videojuego_categoria (
    id_juego        INT     NOT NULL,
    id_categoria    INT     NOT NULL,
    PRIMARY KEY (id_juego, id_categoria),
    FOREIGN KEY (id_juego)      REFERENCES videojuego(id_juego),
    FOREIGN KEY (id_categoria)  REFERENCES categoria(id_categoria)
);