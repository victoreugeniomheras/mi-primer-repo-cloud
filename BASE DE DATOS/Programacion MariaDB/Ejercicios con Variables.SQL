-- EJERCICIO 1:
MariaDB [academia_cursos]> SET @precio_max = (SELECT MAX(precio) FROM cursos);
Query OK, 0 rows affected (0.011 sec)

MariaDB [academia_cursos]> SELECT CONCAT('El curso más caro cuesta: ', @precio_max, ' euros') AS resultado;
+----------------------------------------+
| resultado                              |
+----------------------------------------+
| El curso más caro cuesta: 420.00 euros  |
+----------------------------------------+
1 row in set (0.001 sec)

--EJERCICIO 2:
MariaDB [academia_cursos]> SET @alumnos_activos = (SELECT COUNT(*) FROM alumnos WHERE activo = 1);
Query OK, 0 rows affected (0.009 sec)

MariaDB [academia_cursos]> SET @dinero_total = (
    ->     SELECT SUM(importe_pagado)
    ->     FROM matriculas
    ->     WHERE estado = 'Activa'
    -> );
Query OK, 0 rows affected (0.008 sec)

MariaDB [academia_cursos]> SELECT @alumnos_activos AS alumnos_activos,
    ->        @dinero_total AS dinero_total;
+-----------------+--------------+
| alumnos_activos | dinero_total |
+-----------------+--------------+
|               3 |      2692.00 |
+-----------------+--------------+
1 row in set (0.001 sec)

--EJERCICIO 3:
MariaDB [academia_cursos]> SET @dep = 1;
Query OK, 0 rows affected (0.001 sec)

MariaDB [academia_cursos]> SELECT *
    -> FROM cursos
    -> WHERE id_departamento = @dep;
+----------+--------------+-------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
| id_curso | codigo_curso | nombre                  | descripcion                                 | horas | precio | fecha_inicio | fecha_fin  | plazas | id_departamento | id_profesor |
+----------+--------------+-------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
|        1 | INF001       | Programaci├│n en Python  | Introducci├│n a Python orientado a datos     |    60 | 350.00 | 2024-10-01   | 2024-12-20 |     17 |               1 |           1 |
|        2 | INF002       | Bases de Datos MySQL    | Dise├▒o y explotaci├│n de BBDD relacionales   |    40 | 280.00 | 2024-10-15   | 2024-12-15 |     16 |               1 |           2 |
+----------+--------------+-------------------------+---------------------------------------------+-------+--------+--------------+------------+--------+-----------------+-------------+
2 rows in set (0.001 sec)

--EJERCICIO 4:
MariaDB [academia_cursos]> SET @salario_actual = (
    ->     SELECT salario
    ->     FROM profesores
    ->     WHERE nombre = 'Laura' AND apellidos = 'Sánchez'
    -> );
Query OK, 0 rows affected (0.006 sec)

MariaDB [academia_cursos]> SET @nuevo_salario = @salario_actual * 1.05;
Query OK, 0 rows affected (0.001 sec)

MariaDB [academia_cursos]> SET @diferencia = @nuevo_salario - @salario_actual;
Query OK, 0 rows affected (0.001 sec)

MariaDB [academia_cursos]> SELECT @salario_actual AS actual,
    ->        @nuevo_salario AS nuevo,
    ->        @diferencia AS subida;
+--------+-------+--------+
| actual | nuevo | subida |
+--------+-------+--------+
|   NULL |  NULL |   NULL |
+--------+-------+--------+
1 row in set (0.001 sec)

--EJERCICIO 5:
MariaDB [academia_cursos]> SET @total = (SELECT SUM(precio) FROM cursos);
Query OK, 0 rows affected (0.001 sec)

MariaDB [academia_cursos]> SET @total_desc = @total * 0.90;
Query OK, 0 rows affected (0.001 sec)

MariaDB [academia_cursos]> SET @diferencia = @total - @total_desc;
Query OK, 0 rows affected (0.001 sec)

MariaDB [academia_cursos]> SELECT @total AS total_sin_descuento,
    ->        @total_desc AS total_con_descuento,
    ->        @diferencia AS diferencia;
+---------------------+---------------------+------------+
| total_sin_descuento | total_con_descuento | diferencia |
+---------------------+---------------------+------------+
|             1800.00 |                1620 |     180.00 |
+---------------------+---------------------+------------+
1 row in set (0.001 sec)


