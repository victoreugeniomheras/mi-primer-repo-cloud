-- EJERCICIO 4:
MariaDB [academia_cursos]> select * from profesores;
+-------------+-----------+---------+--------------------+------------------------+-----------+------------+---------+-----------------+
| id_profesor | nif       | nombre  | apellidos          | email                  | telefono  | fecha_alta | salario | id_departamento |
+-------------+-----------+---------+--------------------+------------------------+-----------+------------+---------+-----------------+
|           1 | 12345678A | Carlos  | Mart├¡nez L├│pez     | cmartinez@academia.com | 600111222 | 2019-09-01 | 2100.00 |               1 |
|           2 | 23456789B | Laura   | S├ínchez Ruiz       | lsanchez@academia.com  | 600222333 | 2019-09-01 | 1950.00 |               1 |
|           3 | 34567890C | Miguel  | Garc├¡a Fern├índez   | mgarcia@academia.com   | 600333444 | 2020-01-10 | 1800.00 |               2 |
|           4 | 45678901D | Ana     | Torres Blanco      | atorres@academia.com   | 600444555 | 2020-03-15 | 2200.00 |               3 |
|           5 | 56789012E | Pedro   | Jim├®nez Vega       | pjimenez@academia.com  | 600555666 | 2021-09-01 | 1750.00 |               4 |
|           6 | 67890123F | Sof├¡a   | Romero Castro      | sromero@academia.com   | 600666777 | 2022-01-20 | 1900.00 |               5 |
|           7 | 87654321Z | Rodrigo | Castillo Vera      | rcastillo@academia.com | 611222333 | 2025-03-01 | 2300.00 |               1 |
+-------------+-----------+---------+--------------------+------------------------+-----------+------------+---------+-----------------+
7 rows in set (0.001 sec)


UPDATE profesores p
SET salario = salario * 1.10
WHERE p.id_profesor IN (
    SELECT DISTINCT c.id_profesor
    FROM cursos c
    JOIN matriculas m ON c.id_curso = m.id_curso
    WHERE m.estado = 'Activa'
);

MariaDB [academia_cursos]> select * from profesores;
+-------------+-----------+---------+--------------------+------------------------+-----------+------------+---------+-----------------+
| id_profesor | nif       | nombre  | apellidos          | email                  | telefono  | fecha_alta | salario | id_departamento |
+-------------+-----------+---------+--------------------+------------------------+-----------+------------+---------+-----------------+
|           1 | 12345678A | Carlos  | Mart├¡nez L├│pez     | cmartinez@academia.com | 600111222 | 2019-09-01 | 2310.00 |               1 |
|           2 | 23456789B | Laura   | S├ínchez Ruiz       | lsanchez@academia.com  | 600222333 | 2019-09-01 | 2145.00 |               1 |
|           3 | 34567890C | Miguel  | Garc├¡a Fern├índez   | mgarcia@academia.com   | 600333444 | 2020-01-10 | 1980.00 |               2 |
|           4 | 45678901D | Ana     | Torres Blanco      | atorres@academia.com   | 600444555 | 2020-03-15 | 2420.00 |               3 |
|           5 | 56789012E | Pedro   | Jim├®nez Vega       | pjimenez@academia.com  | 600555666 | 2021-09-01 | 1925.00 |               4 |
|           6 | 67890123F | Sof├¡a   | Romero Castro      | sromero@academia.com   | 600666777 | 2022-01-20 | 2090.00 |               5 |
|           7 | 87654321Z | Rodrigo | Castillo Vera      | rcastillo@academia.com | 611222333 | 2025-03-01 | 2300.00 |               1 |
+-------------+-----------+---------+--------------------+------------------------+-----------+------------+---------+-----------------+
7 rows in set (0.001 sec)


-- EJERCICIO 5

-- Actualizamos las plazas restando las matrículas activas de cada curso

MariaDB [academia_cursos]> select* from cursos;
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


UPDATE cursos c
SET plazas = plazas - (
    SELECT COUNT(*)
    FROM matriculas m
    WHERE m.id_curso = c.id_curso
      AND m.estado = 'Activa'
)
WHERE c.id_curso IN (
    SELECT DISTINCT id_curso
    FROM matriculas
    WHERE estado = 'Activa'
);

MariaDB [academia_cursos]> select* from cursos;
+----------+--------------+--------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
| id_curso | codigo_curso | nombre                   | descripcion                                 | horas | precio | fecha_inicio | fecha_fin  | plazas | id_departamento | id_profesor |
+----------+--------------+--------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
|        1 | INF001       | Programaci├│n en Python   | Introducci├│n a Python orientado a datos     |    60 | 350.00 | 2024-10-01   | 2024-12-20 |     17 |               1 |           1 |
|        2 | INF002       | Bases de Datos MySQL     | Dise├▒o y explotaci├│n de BBDD relacionales   |    40 | 280.00 | 2024-10-15   | 2024-12-15 |     16 |               1 |           2 |
|        3 | ADM001       | Contabilidad B├ísica      | Fundamentos de contabilidad empresarial     |    50 | 300.00 | 2024-11-01   | 2025-01-31 |     21 |               2 |           3 |
|        4 | IDI001       | Ingl├®s de Negocios B2    | Ingl├®s aplicado al entorno empresarial      |    80 | 420.00 | 2024-09-15   | 2025-02-28 |     15 |               3 |           4 |
|        5 | DIS001       | Adobe Photoshop Avanzado | Retoque fotogr├ífico y composici├│n digital   |    30 | 200.00 | 2024-11-15   | 2025-01-15 |     14 |               4 |           5 |
|        6 | MKT001       | SEO y SEM                | Posicionamiento en buscadores y publicidad  |    35 | 250.00 | 2025-01-10   | 2025-03-10 |     19 |               5 |           6 |
+----------+--------------

-- EJERCICIO 6
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

UPDATE alumnos a
SET activo = 0
WHERE a.id_alumno IN (
    SELECT id_alumno
    FROM (
        SELECT m.id_alumno, SUM(m.importe_pagado) AS total_gasto
        FROM matriculas m
        WHERE m.importe_pagado IS NOT NULL
        GROUP BY m.id_alumno
    ) gastos
    WHERE total_gasto < (
        SELECT AVG(total_gasto)
        FROM (
            SELECT SUM(importe_pagado) AS total_gasto
            FROM matriculas
            WHERE importe_pagado IS NOT NULL
            GROUP BY id_alumno
        ) media_gastos
    )
);

MariaDB [academia_cursos]> select * from alumnos;
+-----------+-----------+---------+------------------+---------------------+-----------+------------------+-----------------+--------+
| id_alumno | nif       | nombre  | apellidos        | email               | telefono  | fecha_nacimiento | fecha_matricula | activo |
+-----------+-----------+---------+------------------+---------------------+-----------+------------------+-----------------+--------+
|         1 | 87654321Z | Marta   | Gonz├ílez P├®rez   | marta.g@gmail.com   | 611100001 | 2000-05-12       | 2024-09-01      |      1 |
|         2 | 76543210Y | Javier  | L├│pez Moreno     | javier.l@gmail.com  | 611100002 | 1998-11-23       | 2024-09-05      |      0 |
|         3 | 65432109X | Luc├¡a   | Herrera D├¡az     | lucia.h@gmail.com   | 611100003 | 2001-03-08       | 2024-09-10      |      0 |
|         4 | 54321098W | David   | Mu├▒oz Serrano    | david.m@gmail.com   | 611100004 | 1999-07-19       | 2024-09-15      |      1 |
|         5 | 43210987V | Elena   | Navarro Gil      | elena.n@gmail.com   | 611100005 | 2002-01-30       | 2024-10-01      |      0 |
|         6 | 32109876U | Andr├®s  | Vargas Leal      | andres.v@gmail.com  | 611100006 | 1997-09-14       | 2024-10-02      |      0 |
|         7 | 21098765T | Carmen  | Molina Rivas     | carmen.mo@gmail.com | 611100007 | 2000-12-05       | 2024-10-10      |      0 |
|         8 | 10987654S | Tom├ís   | Reyes Pardo      | tomas.r@gmail.com   | 611100008 | 1996-04-22       | 2024-10-15      |      1 |
+-----------+-----------+---------+------------------+---------------------+-----------+------------------+-----------------+--------+
8 rows in set (0.001 sec)

--EJERCICIO 7:

-- Nota: no se actualizan filas porque actualmente
-- no existen matrículas que cumplan todas las condiciones

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

UPDATE matriculas m
SET importe_pagado = importe_pagado * 0.85
WHERE m.id_alumno IN (
    SELECT id_alumno
    FROM matriculas
    GROUP BY id_alumno
    HAVING COUNT(*) > 1
)
AND m.id_curso IN (
    SELECT id_curso
    FROM cursos
    WHERE id_departamento = (
        SELECT id_departamento
        FROM departamentos
        WHERE presupuesto = (
            SELECT MIN(presupuesto)
            FROM departamentos
        )
    )
);

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


