-- EJERCICIO 8:

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
8 rows in set (0.005 sec)

MariaDB [academia_cursos]> SELECT *
    -> FROM alumnos a
    -> WHERE a.activo = 0
    ->   AND a.fecha_matricula < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ->   AND NOT EXISTS (
    ->       SELECT 1
    ->       FROM matriculas m
    ->       WHERE m.id_alumno = a.id_alumno
    ->   );
Empty set (0.005 sec)

MariaDB [academia_cursos]>
MariaDB [academia_cursos]> -- Paso 2: Eliminar los mismos alumnos
MariaDB [academia_cursos]> DELETE FROM alumnos
    -> WHERE activo = 0
    ->   AND fecha_matricula < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ->   AND NOT EXISTS (
    ->       SELECT 1
    ->       FROM matriculas m
    ->       WHERE m.id_alumno = alumnos.id_alumno
    ->   );
Query OK, 0 rows affected (0.001 sec)

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
8 rows in set (0.000 sec)


--EJERCICIO 9:
MariaDB [academia_cursos]> SELECT *
    -> FROM matriculas m
    -> WHERE m.estado IN ('Pendiente', 'Baja')
    ->   AND m.id_curso IN (
    ->       SELECT id_curso
    ->       FROM (
    ->           SELECT id_curso, COUNT(*) AS total_matriculas
    ->           FROM matriculas
    ->           GROUP BY id_curso
    ->       ) AS t
    ->       WHERE total_matriculas < 3
    ->   );
Empty set (0.001 sec)

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
9 rows in set (0.000 sec)

MariaDB [academia_cursos]> DELETE FROM matriculas
    -> WHERE estado IN ('Pendiente', 'Baja')
    ->   AND id_curso IN (
    ->       SELECT id_curso
    ->       FROM (
    ->           SELECT id_curso, COUNT(*) AS total_matriculas
    ->           FROM matriculas
    ->           GROUP BY id_curso
    ->       ) AS t
    ->       WHERE total_matriculas < 3
    ->   );
Query OK, 0 rows affected (0.001 sec)

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

--EJERCICIO 10:

MariaDB [academia_cursos]> SELECT*FROM PAGOS;
+---------+--------------+------------+---------+----------------+------------------+
| id_pago | id_matricula | fecha_pago | importe | metodo         | referencia       |
+---------+--------------+------------+---------+----------------+------------------+
|       1 |            1 | 2024-09-20 |  350.00 | Tarjeta        | TPV-20240920-001 |
|       2 |            2 | 2024-09-20 |  280.00 | Transferencia  | TRF-20240920-002 |
|       3 |            3 | 2024-09-22 |  315.00 | Tarjeta        | TPV-20240922-003 |
|       4 |            4 | 2024-10-05 |  300.00 | Efectivo       | NULL             |
|       5 |            5 | 2024-09-18 |  420.00 | Domiciliaci├│n  | DOM-20240918-005 |
|       6 |            6 | 2024-10-03 |  252.00 | Tarjeta        | TPV-20241003-006 |
+---------+--------------+------------+---------+----------------+------------------+
6 rows in set (0.007 sec)

MariaDB [academia_cursos]> SELECT *
    -> FROM pagos p
    -> WHERE p.id_matricula IN (
    ->     SELECT id_matricula
    ->     FROM matriculas
    ->     WHERE id_alumno IN (SELECT id_alumno FROM alumnos WHERE activo = 0)
    -> )
    -> AND p.importe < (SELECT AVG(precio) FROM cursos);
+---------+--------------+------------+---------+---------+------------------+
| id_pago | id_matricula | fecha_pago | importe | metodo  | referencia       |
+---------+--------------+------------+---------+---------+------------------+
|       6 |            6 | 2024-10-03 |  252.00 | Tarjeta | TPV-20241003-006 |
+---------+--------------+------------+---------+---------+------------------+
1 row in set (0.006 sec)

MariaDB [academia_cursos]> DELETE FROM pagos
    -> WHERE id_matricula IN (
    ->     SELECT id_matricula
    ->     FROM matriculas
    ->     WHERE id_alumno IN (SELECT id_alumno FROM alumnos WHERE activo = 0)
    -> )
    -> AND importe < (SELECT AVG(precio) FROM cursos);
Query OK, 1 row affected (0.003 sec)

MariaDB [academia_cursos]> SELECT*FROM PAGOS;
+---------+--------------+------------+---------+----------------+------------------+
| id_pago | id_matricula | fecha_pago | importe | metodo         | referencia       |
+---------+--------------+------------+---------+----------------+------------------+
|       1 |            1 | 2024-09-20 |  350.00 | Tarjeta        | TPV-20240920-001 |
|       2 |            2 | 2024-09-20 |  280.00 | Transferencia  | TRF-20240920-002 |
|       3 |            3 | 2024-09-22 |  315.00 | Tarjeta        | TPV-20240922-003 |
|       4 |            4 | 2024-10-05 |  300.00 | Efectivo       | NULL             |
|       5 |            5 | 2024-09-18 |  420.00 | Domiciliaci├│n  | DOM-20240918-005 |
+---------+--------------+------------+---------+----------------+------------------+
5 rows in set (0.001 sec)

MariaDB [academia_cursos]>


