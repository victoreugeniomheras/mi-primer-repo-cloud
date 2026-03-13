Ejercicio 1:

MariaDB [academia_cursos]> select * from departamentos;
+-----------------+-------------------+-------------+----------------+--------+
| id_departamento | nombre            | presupuesto | fecha_creacion | activo |
+-----------------+-------------------+-------------+----------------+--------+
|               1 | Inform├ítica       |    15000.00 | 2018-09-01     |      1 |
|               2 | Administraci├│n    |    12000.00 | 2018-09-01     |      1 |
|               3 | Idiomas           |     9500.00 | 2019-01-15     |      1 |
|               4 | Dise├▒o Gr├ífico    |     8000.00 | 2020-03-10     |      1 |
|               5 | Marketing Digital |     7500.00 | 2021-06-01     |      1 |
+-----------------+-------------------+-------------+----------------+--------+
5 rows in set (0.001 sec)

MariaDB [academia_cursos]> INSERT INTO departamentos
    -> VALUES (NULL, 'Ciberseguridad', 11000.00, '2025-01-10', 1);
Query OK, 1 row affected (0.004 sec)

MariaDB [academia_cursos]> select * from departamentos;
+-----------------+-------------------+-------------+----------------+--------+
| id_departamento | nombre            | presupuesto | fecha_creacion | activo |
+-----------------+-------------------+-------------+----------------+--------+
|               1 | Inform├ítica       |    15000.00 | 2018-09-01     |      1 |
|               2 | Administraci├│n    |    12000.00 | 2018-09-01     |      1 |
|               3 | Idiomas           |     9500.00 | 2019-01-15     |      1 |
|               4 | Dise├▒o Gr├ífico    |     8000.00 | 2020-03-10     |      1 |
|               5 | Marketing Digital |     7500.00 | 2021-06-01     |      1 |
|               6 | Ciberseguridad    |    11000.00 | 2025-01-10     |      1 |
+-----------------+-------------------+-------------+----------------+--------+
6 rows in set (0.000 sec)


Ejercicio 2:

MariaDB [academia_cursos]> select * from profesores
    -> ;
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
| id_profesor | nif       | nombre | apellidos          | email                  | telefono  | fecha_alta | salario | id_departamento |
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
|           1 | 12345678A | Carlos | Mart├¡nez L├│pez     | cmartinez@academia.com | 600111222 | 2019-09-01 | 2100.00 |               1 |
|           2 | 23456789B | Laura  | S├ínchez Ruiz       | lsanchez@academia.com  | 600222333 | 2019-09-01 | 1950.00 |               1 |
|           3 | 34567890C | Miguel | Garc├¡a Fern├índez   | mgarcia@academia.com   | 600333444 | 2020-01-10 | 1800.00 |               2 |
|           4 | 45678901D | Ana    | Torres Blanco      | atorres@academia.com   | 600444555 | 2020-03-15 | 2200.00 |               3 |
|           5 | 56789012E | Pedro  | Jim├®nez Vega       | pjimenez@academia.com  | 600555666 | 2021-09-01 | 1750.00 |               4 |
|           6 | 67890123F | Sof├¡a  | Romero Castro      | sromero@academia.com   | 600666777 | 2022-01-20 | 1900.00 |               5 |
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
6 rows in set (0.001 sec)

MariaDB [academia_cursos]> INSERT INTO profesores
    -> VALUES (NULL, '78901234G', 'Isabel', 'Fuentes Mora', 'ifuentes@academia.com', '600777888', '2025-01-10', 2050.00, 6);
Query OK, 1 row affected (0.007 sec)

MariaDB [academia_cursos]> select * from profesores;
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
| id_profesor | nif       | nombre | apellidos          | email                  | telefono  | fecha_alta | salario | id_departamento |
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
|           1 | 12345678A | Carlos | Mart├¡nez L├│pez     | cmartinez@academia.com | 600111222 | 2019-09-01 | 2100.00 |               1 |
|           2 | 23456789B | Laura  | S├ínchez Ruiz       | lsanchez@academia.com  | 600222333 | 2019-09-01 | 1950.00 |               1 |
|           3 | 34567890C | Miguel | Garc├¡a Fern├índez   | mgarcia@academia.com   | 600333444 | 2020-01-10 | 1800.00 |               2 |
|           4 | 45678901D | Ana    | Torres Blanco      | atorres@academia.com   | 600444555 | 2020-03-15 | 2200.00 |               3 |
|           5 | 56789012E | Pedro  | Jim├®nez Vega       | pjimenez@academia.com  | 600555666 | 2021-09-01 | 1750.00 |               4 |
|           6 | 67890123F | Sof├¡a  | Romero Castro      | sromero@academia.com   | 600666777 | 2022-01-20 | 1900.00 |               5 |
|           7 | 78901234G | Isabel | Fuentes Mora       | ifuentes@academia.com  | 600777888 | 2025-01-10 | 2050.00 |               6 |
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
7 rows in set (0.001 sec)

Ejercicio 3:

MariaDB [academia_cursos]> select * from cursos;
+----------+--------------+--------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
| id_curso | codigo_curso | nombre                   | descripcion                                 | horas | precio | fecha_inicio | fecha_fin  | plazas | id_departamento | id_profesor |
+----------+--------------+--------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
|        1 | INF001       | Programaci├│n en Python   | Introducci├│n a Python orientado a datos     |    60 | 350.00 | 2024-10-01   | 2024-12-20 |     20 |               1 |           1 |
|        2 | INF002       | Bases de Datos MySQL     | Dise├▒o y explotaci├│n de BBDD relacionales   |    40 | 280.00 | 2024-10-15   | 2024-12-15 |     18 |               1 |           2 |
|        3 | ADM001       | Contabilidad B├ísica      | Fundamentos de contabilidad empresarial     |    50 | 300.00 | 2024-11-01   | 2025-01-31 |     22 |               2 |           3 |
|        4 | IDI001       | Ingl├®s de Negocios B2    | Ingl├®s aplicado al entorno empresarial      |    80 | 420.00 | 2024-09-15   | 2025-02-28 |     16 |               3 |           4 |
|        5 | DIS001       | Adobe Photoshop Avanzado | Retoque fotogr├ífico y composici├│n digital   |    30 | 200.00 | 2024-11-15   | 2025-01-15 |     15 |               4 |           5 |
|        6 | MKT001       | SEO y SEM                | Posicionamiento en buscadores y publicidad  |    35 | 250.00 | 2025-01-10   | 2025-03-10 |     20 |               5 |           6 |
+----------+--------------+--------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
6 rows in set (0.001 sec)

MariaDB [academia_cursos]> INSERT INTO cursos (codigo_curso, nombre, horas, precio, id_departamento, id_profesor)
    -> VALUES ('CIBER001', 'Fundamentos de Ciberseguridad', 45, 310.00, 6, 7);
Query OK, 1 row affected (0.006 sec)

MariaDB [academia_cursos]> select * from cursos;
+----------+--------------+-------------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
| id_curso | codigo_curso | nombre                        | descripcion                                 | horas | precio | fecha_inicio | fecha_fin  | plazas | id_departamento | id_profesor |
+----------+--------------+-------------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
|        1 | INF001       | Programaci├│n en Python        | Introducci├│n a Python orientado a datos     |    60 | 350.00 | 2024-10-01   | 2024-12-20 |     20 |               1 |           1 |
|        2 | INF002       | Bases de Datos MySQL          | Dise├▒o y explotaci├│n de BBDD relacionales   |    40 | 280.00 | 2024-10-15   | 2024-12-15 |     18 |               1 |           2 |
|        3 | ADM001       | Contabilidad B├ísica           | Fundamentos de contabilidad empresarial     |    50 | 300.00 | 2024-11-01   | 2025-01-31 |     22 |               2 |           3 |
|        4 | IDI001       | Ingl├®s de Negocios B2         | Ingl├®s aplicado al entorno empresarial      |    80 | 420.00 | 2024-09-15   | 2025-02-28 |     16 |               3 |           4 |
|        5 | DIS001       | Adobe Photoshop Avanzado      | Retoque fotogr├ífico y composici├│n digital   |    30 | 200.00 | 2024-11-15   | 2025-01-15 |     15 |               4 |           5 |
|        6 | MKT001       | SEO y SEM                     | Posicionamiento en buscadores y publicidad  |    35 | 250.00 | 2025-01-10   | 2025-03-10 |     20 |               5 |           6 |
|        7 | CIBER001     | Fundamentos de Ciberseguridad | NULL                                        |    45 | 310.00 | NULL         | NULL       |     20 |               6 |           7 |
+----------+--------------+-------------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
7 rows in set (0.001 sec)

--Preguntas a responder en un comentario SQL (--):
--a) ¿Con qué valor quedará el campo 'plazas'? Se queda con 20.
--b) ¿Con qué valor quedarán descripcion, fecha_inicio y fecha_fin? Null

Ejrecicio 4:
MariaDB [academia_cursos]> select * from alumnos;
+-----------+-----------+---------+------------------+---------------------+-----------+------------------+-----------------+--------+
| id_alumno | nif       | nombre  | apellidos        | email               | telefono  | fecha_nacimiento | fecha_matricula | activo |
+-----------+-----------+---------+------------------+---------------------+-----------+------------------+-----------------+--------+
|         1 | 87654321Z | Marta   | Gonz├ílez P├®rez   | marta.g@gmail.com   | 611100001 | 2000-05-12       | 2024-09-01      |      1 |
|         2 | 76543210Y | Javier  | L├│pez Moreno     | javier.l@gmail.com  | 611100002 | 1998-11-23       | 2024-09-05      |      1 |
|         3 | 65432109X | Luc├¡a   | Herrera D├¡az     | lucia.h@gmail.com   | 611100003 | 2001-03-08       | 2024-09-10      |      1 |
|         4 | 54321098W | David   | Mu├▒oz Serrano    | david.m@gmail.com   | 611100004 | 1999-07-19       | 2024-09-15      |      1 |
|         5 | 43210987V | Elena   | Navarro Gil      | elena.n@gmail.com   | 611100005 | 2002-01-30       | 2024-10-01      |      1 |
|         6 | 32109876U | Andr├®s  | Vargas Leal      | andres.v@gmail.com  | 611100006 | 1997-09-14       | 2024-10-02      |      1 |
|         7 | 21098765T | Carmen  | Molina Rivas     | carmen.mo@gmail.com | 611100007 | 2000-12-05       | 2024-10-10      |      1 |
|         8 | 10987654S | Tom├ís   | Reyes Pardo      | tomas.r@gmail.com   | 611100008 | 1996-04-22       | 2024-10-15      |      1 |
+-----------+-----------+---------+------------------+---------------------+-----------+------------------+-----------------+--------+
8 rows in set (0.001 sec)

MariaDB [academia_cursos]> INSERT INTO alumnos (nif, nombre, apellidos, email, fecha_matricula, activo)
    -> VALUES ('11223344A', 'Mario', 'Ruiz Cano', 'mario.ruiz@gmail.com', '2025-01-15', 1);
Query OK, 1 row affected (0.004 sec)

MariaDB [academia_cursos]>
MariaDB [academia_cursos]> INSERT INTO alumnos (nif, nombre, apellidos, email, fecha_matricula, activo)
    -> VALUES ('22334455B', 'Sara', 'Vidal Torres', 'sara.vidal@gmail.com', '2025-01-15', 1);
Query OK, 1 row affected (0.002 sec)

MariaDB [academia_cursos]>
MariaDB [academia_cursos]> INSERT INTO alumnos (nif, nombre, apellidos, email, fecha_matricula, activo)
    -> VALUES ('33445566C', 'Pablo', 'Mora Sanz', 'pablo.mora@gmail.com', '2025-01-15', 1);
Query OK, 1 row affected (0.006 sec)

MariaDB [academia_cursos]> select * from alumnos;
+-----------+-----------+---------+------------------+----------------------+-----------+------------------+-----------------+--------+
| id_alumno | nif       | nombre  | apellidos        | email                | telefono  | fecha_nacimiento | fecha_matricula | activo |
+-----------+-----------+---------+------------------+----------------------+-----------+------------------+-----------------+--------+
|         1 | 87654321Z | Marta   | Gonz├ílez P├®rez   | marta.g@gmail.com    | 611100001 | 2000-05-12       | 2024-09-01      |      1 |
|         2 | 76543210Y | Javier  | L├│pez Moreno     | javier.l@gmail.com   | 611100002 | 1998-11-23       | 2024-09-05      |      1 |
|         3 | 65432109X | Luc├¡a   | Herrera D├¡az     | lucia.h@gmail.com    | 611100003 | 2001-03-08       | 2024-09-10      |      1 |
|         4 | 54321098W | David   | Mu├▒oz Serrano    | david.m@gmail.com    | 611100004 | 1999-07-19       | 2024-09-15      |      1 |
|         5 | 43210987V | Elena   | Navarro Gil      | elena.n@gmail.com    | 611100005 | 2002-01-30       | 2024-10-01      |      1 |
|         6 | 32109876U | Andr├®s  | Vargas Leal      | andres.v@gmail.com   | 611100006 | 1997-09-14       | 2024-10-02      |      1 |
|         7 | 21098765T | Carmen  | Molina Rivas     | carmen.mo@gmail.com  | 611100007 | 2000-12-05       | 2024-10-10      |      1 |
|         8 | 10987654S | Tom├ís   | Reyes Pardo      | tomas.r@gmail.com    | 611100008 | 1996-04-22       | 2024-10-15      |      1 |
|         9 | 11223344A | Mario   | Ruiz Cano        | mario.ruiz@gmail.com | NULL      | NULL             | 2025-01-15      |      1 |
|        10 | 22334455B | Sara    | Vidal Torres     | sara.vidal@gmail.com | NULL      | NULL             | 2025-01-15      |      1 |
|        11 | 33445566C | Pablo   | Mora Sanz        | pablo.mora@gmail.com | NULL      | NULL             | 2025-01-15      |      1 |
+-----------+-----------+---------+------------------+----------------------+-----------+------------------+-----------------+--------+
11 rows in set (0.001 sec)


Ejercicio 5:

MariaDB [academia_cursos]> select * from matriculas;
+--------------+-----------+----------+-----------------+----------------+-----------+--------+
| id_matricula | id_alumno | id_curso | fecha_matricula | importe_pagado | descuento | estado |
+--------------+-----------+----------+-----------------+----------------+-----------+--------+
|            1 |         1 |        1 | 2024-09-20      |         350.00 |      0.00 | Activa |
|            2 |         1 |        2 | 2024-09-20      |         280.00 |      0.00 | Activa |
|            3 |         2 |        1 | 2024-09-22      |         315.00 |     10.00 | Activa |
|            4 |         3 |        3 | 2024-10-05      |         300.00 |      0.00 | Activa |
|            5 |         4 |        4 | 2024-09-18      |         420.00 |      0.00 | Activa |
|            6 |         5 |        2 | 2024-10-03      |         252.00 |     10.00 | Activa |
|            7 |         6 |        5 | 2024-10-05      |         200.00 |      0.00 | Activa |
|            8 |         7 |        6 | 2024-10-12      |         225.00 |     10.00 | Activa |
|            9 |         8 |        1 | 2024-10-16      |         350.00 |      0.00 | Activa |
+--------------+-----------+----------+-----------------+----------------+-----------+--------+
9 rows in set (0.001 sec)

MariaDB [academia_cursos]> INSERT INTO matriculas (id_alumno, id_curso, fecha_matricula, importe_pagado, descuento, estado)
    -> VALUES (9, 7, '2025-01-15', NULL, 0.00, 'Pendiente');
Query OK, 1 row affected (0.003 sec)

MariaDB [academia_cursos]>
MariaDB [academia_cursos]> INSERT INTO matriculas (id_alumno, id_curso, fecha_matricula, importe_pagado, descuento, estado)
    -> VALUES (10, 7, '2025-01-15', NULL, 0.00, 'Pendiente');
Query OK, 1 row affected (0.001 sec)

MariaDB [academia_cursos]>
MariaDB [academia_cursos]> INSERT INTO matriculas (id_alumno, id_curso, fecha_matricula, importe_pagado, descuento, estado)
    -> VALUES (11, 7, '2025-01-15', NULL, 0.00, 'Pendiente');
Query OK, 1 row affected (0.004 sec)

MariaDB [academia_cursos]> select * from matriculas;
+--------------+-----------+----------+-----------------+----------------+-----------+-----------+
| id_matricula | id_alumno | id_curso | fecha_matricula | importe_pagado | descuento | estado    |
+--------------+-----------+----------+-----------------+----------------+-----------+-----------+
|            1 |         1 |        1 | 2024-09-20      |         350.00 |      0.00 | Activa    |
|            2 |         1 |        2 | 2024-09-20      |         280.00 |      0.00 | Activa    |
|            3 |         2 |        1 | 2024-09-22      |         315.00 |     10.00 | Activa    |
|            4 |         3 |        3 | 2024-10-05      |         300.00 |      0.00 | Activa    |
|            5 |         4 |        4 | 2024-09-18      |         420.00 |      0.00 | Activa    |
|            6 |         5 |        2 | 2024-10-03      |         252.00 |     10.00 | Activa    |
|            7 |         6 |        5 | 2024-10-05      |         200.00 |      0.00 | Activa    |
|            8 |         7 |        6 | 2024-10-12      |         225.00 |     10.00 | Activa    |
|            9 |         8 |        1 | 2024-10-16      |         350.00 |      0.00 | Activa    |
|           17 |         9 |        7 | 2025-01-15      |           NULL |      0.00 | Pendiente |
|           18 |        10 |        7 | 2025-01-15      |           NULL |      0.00 | Pendiente |
|           19 |        11 |        7 | 2025-01-15      |           NULL |      0.00 | Pendiente |
+--------------+-----------+----------+-----------------+----------------+-----------+-----------+
12 rows in set (0.001 sec)