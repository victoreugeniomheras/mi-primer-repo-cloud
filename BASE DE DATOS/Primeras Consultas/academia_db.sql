
CREATE DATABASE academia_cursos
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE academia_cursos;

-- ------------------------------------------------------------
-- TABLA: departamentos
-- Sin clave foránea. Tabla raíz del modelo.
-- ------------------------------------------------------------
CREATE TABLE departamentos (
    id_departamento   INT          NOT NULL AUTO_INCREMENT,
    nombre            VARCHAR(80)  NOT NULL,
    presupuesto       DECIMAL(10,2)    NULL,
    fecha_creacion    DATE             NULL,
    activo            TINYINT(1)   NOT NULL DEFAULT 1,
    PRIMARY KEY (id_departamento)
) ENGINE=InnoDB;

INSERT INTO departamentos (nombre, presupuesto, fecha_creacion, activo) VALUES
    ('Informática',         15000.00, '2018-09-01', 1),
    ('Administración',      12000.00, '2018-09-01', 1),
    ('Idiomas',              9500.00, '2019-01-15', 1),
    ('Diseño Gráfico',       8000.00, '2020-03-10', 1),
    ('Marketing Digital',    7500.00, '2021-06-01', 1);

-- ------------------------------------------------------------
-- TABLA: profesores
-- Depende de: departamentos
-- ------------------------------------------------------------
CREATE TABLE profesores (
    id_profesor       INT          NOT NULL AUTO_INCREMENT,
    nif               CHAR(9)      NOT NULL,
    nombre            VARCHAR(50)  NOT NULL,
    apellidos         VARCHAR(80)  NOT NULL,
    email             VARCHAR(100)     NULL,
    telefono          VARCHAR(15)      NULL,
    fecha_alta        DATE         NOT NULL,
    salario           DECIMAL(8,2)     NULL,
    id_departamento   INT              NULL,
    PRIMARY KEY (id_profesor),
    UNIQUE KEY uq_nif (nif),
    CONSTRAINT fk_prof_depto FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO profesores (nif, nombre, apellidos, email, telefono, fecha_alta, salario, id_departamento) VALUES
    ('12345678A', 'Carlos',   'Martínez López',   'cmartinez@academia.com', '600111222', '2019-09-01', 2100.00, 1),
    ('23456789B', 'Laura',    'Sánchez Ruiz',     'lsanchez@academia.com',  '600222333', '2019-09-01', 1950.00, 1),
    ('34567890C', 'Miguel',   'García Fernández', 'mgarcia@academia.com',   '600333444', '2020-01-10', 1800.00, 2),
    ('45678901D', 'Ana',      'Torres Blanco',    'atorres@academia.com',   '600444555', '2020-03-15', 2200.00, 3),
    ('56789012E', 'Pedro',    'Jiménez Vega',     'pjimenez@academia.com',  '600555666', '2021-09-01', 1750.00, 4),
    ('67890123F', 'Sofía',    'Romero Castro',    'sromero@academia.com',   '600666777', '2022-01-20', 1900.00, 5);

-- ------------------------------------------------------------
-- TABLA: aulas
-- Sin dependencias externas.
-- ------------------------------------------------------------
CREATE TABLE aulas (
    id_aula           INT          NOT NULL AUTO_INCREMENT,
    codigo            VARCHAR(10)  NOT NULL,
    capacidad         INT          NOT NULL,
    tiene_proyector   TINYINT(1)   NOT NULL DEFAULT 0,
    tiene_pcs         TINYINT(1)   NOT NULL DEFAULT 0,
    planta            TINYINT          NULL,
    PRIMARY KEY (id_aula),
    UNIQUE KEY uq_codigo_aula (codigo)
) ENGINE=InnoDB;

INSERT INTO aulas (codigo, capacidad, tiene_proyector, tiene_pcs, planta) VALUES
    ('A101', 30, 1, 0, 1),
    ('A102', 25, 1, 0, 1),
    ('B201', 20, 1, 1, 2),
    ('B202', 20, 1, 1, 2),
    ('C301', 15, 0, 1, 3);

-- ------------------------------------------------------------
-- TABLA: cursos
-- Depende de: departamentos, profesores
-- ------------------------------------------------------------
CREATE TABLE cursos (
    id_curso          INT          NOT NULL AUTO_INCREMENT,
    codigo_curso      VARCHAR(10)  NOT NULL,
    nombre            VARCHAR(100) NOT NULL,
    descripcion       TEXT             NULL,
    horas             INT          NOT NULL,
    precio            DECIMAL(7,2) NOT NULL,
    fecha_inicio      DATE             NULL,
    fecha_fin         DATE             NULL,
    plazas            INT          NOT NULL DEFAULT 20,
    id_departamento   INT          NOT NULL,
    id_profesor       INT              NULL,
    PRIMARY KEY (id_curso),
    UNIQUE KEY uq_codigo_curso (codigo_curso),
    CONSTRAINT fk_curso_depto  FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_curso_prof   FOREIGN KEY (id_profesor)
        REFERENCES profesores(id_profesor)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO cursos (codigo_curso, nombre, descripcion, horas, precio, fecha_inicio, fecha_fin, plazas, id_departamento, id_profesor) VALUES
    ('INF001', 'Programación en Python',    'Introducción a Python orientado a datos',     60,  350.00, '2024-10-01', '2024-12-20', 20, 1, 1),
    ('INF002', 'Bases de Datos MySQL',      'Diseño y explotación de BBDD relacionales',   40,  280.00, '2024-10-15', '2024-12-15', 18, 1, 2),
    ('ADM001', 'Contabilidad Básica',       'Fundamentos de contabilidad empresarial',      50,  300.00, '2024-11-01', '2025-01-31', 22, 2, 3),
    ('IDI001', 'Inglés de Negocios B2',     'Inglés aplicado al entorno empresarial',       80,  420.00, '2024-09-15', '2025-02-28', 16, 3, 4),
    ('DIS001', 'Adobe Photoshop Avanzado',  'Retoque fotográfico y composición digital',   30,  200.00, '2024-11-15', '2025-01-15', 15, 4, 5),
    ('MKT001', 'SEO y SEM',                'Posicionamiento en buscadores y publicidad',   35,  250.00, '2025-01-10', '2025-03-10', 20, 5, 6);

-- ------------------------------------------------------------
-- TABLA: horarios
-- Depende de: cursos, aulas
-- ------------------------------------------------------------
CREATE TABLE horarios (
    id_horario        INT          NOT NULL AUTO_INCREMENT,
    id_curso          INT          NOT NULL,
    id_aula           INT          NOT NULL,
    dia_semana        ENUM('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado') NOT NULL,
    hora_inicio       TIME         NOT NULL,
    hora_fin          TIME         NOT NULL,
    PRIMARY KEY (id_horario),
    CONSTRAINT fk_hor_curso FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_hor_aula  FOREIGN KEY (id_aula)
        REFERENCES aulas(id_aula)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO horarios (id_curso, id_aula, dia_semana, hora_inicio, hora_fin) VALUES
    (1, 3, 'Lunes',     '09:00:00', '11:00:00'),
    (1, 3, 'Miércoles', '09:00:00', '11:00:00'),
    (2, 4, 'Martes',    '16:00:00', '18:00:00'),
    (2, 4, 'Jueves',    '16:00:00', '18:00:00'),
    (3, 1, 'Lunes',     '17:00:00', '19:30:00'),
    (4, 2, 'Martes',    '10:00:00', '12:00:00'),
    (4, 2, 'Jueves',    '10:00:00', '12:00:00'),
    (5, 5, 'Sábado',    '10:00:00', '13:00:00'),
    (6, 1, 'Viernes',   '16:00:00', '19:00:00');

-- ------------------------------------------------------------
-- TABLA: alumnos
-- Sin dependencias externas.
-- ------------------------------------------------------------
CREATE TABLE alumnos (
    id_alumno         INT          NOT NULL AUTO_INCREMENT,
    nif               CHAR(9)      NOT NULL,
    nombre            VARCHAR(50)  NOT NULL,
    apellidos         VARCHAR(80)  NOT NULL,
    email             VARCHAR(100) NOT NULL,
    telefono          VARCHAR(15)      NULL,
    fecha_nacimiento  DATE             NULL,
    fecha_matricula   DATE         NOT NULL DEFAULT (CURRENT_DATE),
    activo            TINYINT(1)   NOT NULL DEFAULT 1,
    PRIMARY KEY (id_alumno),
    UNIQUE KEY uq_nif_alumno  (nif),
    UNIQUE KEY uq_email_alumno (email)
) ENGINE=InnoDB;

INSERT INTO alumnos (nif, nombre, apellidos, email, telefono, fecha_nacimiento, fecha_matricula, activo) VALUES
    ('87654321Z', 'Marta',    'González Pérez',   'marta.g@gmail.com',    '611100001', '2000-05-12', '2024-09-01', 1),
    ('76543210Y', 'Javier',   'López Moreno',     'javier.l@gmail.com',   '611100002', '1998-11-23', '2024-09-05', 1),
    ('65432109X', 'Lucía',    'Herrera Díaz',     'lucia.h@gmail.com',    '611100003', '2001-03-08', '2024-09-10', 1),
    ('54321098W', 'David',    'Muñoz Serrano',    'david.m@gmail.com',    '611100004', '1999-07-19', '2024-09-15', 1),
    ('43210987V', 'Elena',    'Navarro Gil',      'elena.n@gmail.com',    '611100005', '2002-01-30', '2024-10-01', 1),
    ('32109876U', 'Andrés',   'Vargas Leal',      'andres.v@gmail.com',   '611100006', '1997-09-14', '2024-10-02', 1),
    ('21098765T', 'Carmen',   'Molina Rivas',     'carmen.mo@gmail.com',  '611100007', '2000-12-05', '2024-10-10', 1),
    ('10987654S', 'Tomás',    'Reyes Pardo',      'tomas.r@gmail.com',    '611100008', '1996-04-22', '2024-10-15', 1);

-- ------------------------------------------------------------
-- TABLA: matriculas
-- Depende de: alumnos, cursos
-- Tabla de intersección (N:M)
-- ------------------------------------------------------------
CREATE TABLE matriculas (
    id_matricula      INT          NOT NULL AUTO_INCREMENT,
    id_alumno         INT          NOT NULL,
    id_curso          INT          NOT NULL,
    fecha_matricula   DATE         NOT NULL DEFAULT (CURRENT_DATE),
    importe_pagado    DECIMAL(7,2)     NULL,
    descuento         DECIMAL(4,2)     NULL DEFAULT 0.00,
    estado            ENUM('Activa','Baja','Completada','Pendiente') NOT NULL DEFAULT 'Activa',
    PRIMARY KEY (id_matricula),
    UNIQUE KEY uq_alumno_curso (id_alumno, id_curso),
    CONSTRAINT fk_mat_alumno FOREIGN KEY (id_alumno)
        REFERENCES alumnos(id_alumno)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_mat_curso  FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO matriculas (id_alumno, id_curso, fecha_matricula, importe_pagado, descuento, estado) VALUES
    (1, 1, '2024-09-20', 350.00, 0.00,  'Activa'),
    (1, 2, '2024-09-20', 280.00, 0.00,  'Activa'),
    (2, 1, '2024-09-22', 315.00, 10.00, 'Activa'),
    (3, 3, '2024-10-05', 300.00, 0.00,  'Activa'),
    (4, 4, '2024-09-18', 420.00, 0.00,  'Activa'),
    (5, 2, '2024-10-03', 252.00, 10.00, 'Activa'),
    (6, 5, '2024-10-05', 200.00, 0.00,  'Activa'),
    (7, 6, '2024-10-12', 225.00, 10.00, 'Activa'),
    (8, 1, '2024-10-16', 350.00, 0.00,  'Activa');

-- ------------------------------------------------------------
-- TABLA: pagos
-- Depende de: matriculas
-- ------------------------------------------------------------
CREATE TABLE pagos (
    id_pago           INT          NOT NULL AUTO_INCREMENT,
    id_matricula      INT          NOT NULL,
    fecha_pago        DATE         NOT NULL,
    importe           DECIMAL(7,2) NOT NULL,
    metodo            ENUM('Efectivo','Tarjeta','Transferencia','Domiciliación') NOT NULL,
    referencia        VARCHAR(30)      NULL,
    PRIMARY KEY (id_pago),
    CONSTRAINT fk_pago_mat FOREIGN KEY (id_matricula)
        REFERENCES matriculas(id_matricula)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO pagos (id_matricula, fecha_pago, importe, metodo, referencia) VALUES
    (1, '2024-09-20', 350.00, 'Tarjeta',       'TPV-20240920-001'),
    (2, '2024-09-20', 280.00, 'Transferencia', 'TRF-20240920-002'),
    (3, '2024-09-22', 315.00, 'Tarjeta',       'TPV-20240922-003'),
    (4, '2024-10-05', 300.00, 'Efectivo',       NULL),
    (5, '2024-09-18', 420.00, 'Domiciliación', 'DOM-20240918-005'),
    (6, '2024-10-03', 252.00, 'Tarjeta',       'TPV-20241003-006');
