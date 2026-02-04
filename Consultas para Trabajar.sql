# mysql -u root

//Primer ejercicio
MariaDB [(none)]> use curso
Database changed
MariaDB [curso]> use curso:
ERROR 1049 (42000): Unknown database 'curso:'
MariaDB [curso]> use curso;
Database changed
MariaDB [curso]> SELECT
    ->   APELLIDO,
    ->   DATE_FORMAT(FECHA_ALTA, '%d de %M de %Y') AS FECHA_ALTA
    -> FROM EMPLEADOS;
+----------+-------------------------+
| APELLIDO | FECHA_ALTA              |
+----------+-------------------------+
| ALONSO   | 23 de February de 1981  |
| LOPEZ    | 08 de May de 1981       |
| MARTIN   | 28 de September de 1981 |
| GARRIDO  | 01 de May de 1981       |
| MARTINEZ | 09 de June de 1981      |
| REY      | 17 de November de 1981  |
| CALVO    | 08 de September de 1981 |
| GIL      | 06 de May de 1982       |
| JIMENEZ  | 24 de March de 1983     |
+----------+-------------------------+
9 rows in set (0.001 sec)

//Segundo ejercicio
MariaDB [curso]> SELECT
    ->   LEFT(APELLIDO, LENGTH(APELLIDO) - 3) AS APELLIDO_CORTADO
    -> FROM EMPLEADOS
    -> WHERE LENGTH(APELLIDO) > 6
    -> ORDER BY APELLIDO;
+------------------+
| APELLIDO_CORTADO |
+------------------+
| GARR             |
| JIME             |
| MARTI            |
+------------------+
3 rows in set (0.001 sec)

//Tercer ejercicio
MariaDB [curso]> SELECT
    ->   APELLIDO,
    ->   SALARIO * 0.03 AS REGALO
    -> FROM EMPLEADOS
    -> WHERE COMISION IS NULL OR COMISION = 0
    -> ORDER BY APELLIDO;
+----------+--------+
| APELLIDO | REGALO |
+----------+--------+
| CALVO    |  54.00 |
| GARRIDO  | 115.50 |
| GIL      | 100.50 |
| JIMENEZ  |  42.00 |
| LOPEZ    |  40.52 |
| MARTINEZ |  73.50 |
| REY      | 180.00 |
+----------+--------+
7 rows in set (0.000 sec)

//Cuarto ejercicio
//Si pones select con asterisco * saldran todas las columnas.
MariaDB [curso]> SELECT *
    -> FROM EMPLEADOS
    -> WHERE (SALARIO + IFNULL(COMISION,0)) > 2000
    ->   AND (SALARIO > 1800 OR IFNULL(COMISION,0) > 500);
+--------+----------+------------+----------+------------+---------+----------+--------+
| EMP_NO | APELLIDO | OFICIO     | DIRECTOR | FECHA_ALTA | SALARIO | COMISION | DEP_NO |
+--------+----------+------------+----------+------------+---------+----------+--------+
|   7654 | MARTIN   | VENDEDOR   |     7698 | 1981-09-28 | 1500.00 |  1600.00 |     30 |
|   7698 | GARRIDO  | DIRECTOR   |     7839 | 1981-05-01 | 3850.12 |     NULL |     30 |
|   7782 | MARTINEZ | DIRECTOR   |     7839 | 1981-06-09 | 2450.00 |     NULL |     10 |
|   7839 | REY      | PRESIDENTE |     NULL | 1981-11-17 | 6000.00 |     NULL |     10 |
|   7876 | GIL      | ANALISTA   |     7782 | 1982-05-06 | 3350.00 |     NULL |     20 |
+--------+----------+------------+----------+------------+---------+----------+--------+
5 rows in set (0.001 sec)

MariaDB [curso]>

//Quinto Ejercicio
MariaDB [curso]> select *
    -> from empleados
    -> where oficio = 'Director'
    -> order by FECHA_ALTA ASC
    -> LIMIT 1;
+--------+----------+----------+----------+------------+---------+----------+--------+
| EMP_NO | APELLIDO | OFICIO   | DIRECTOR | FECHA_ALTA | SALARIO | COMISION | DEP_NO |
+--------+----------+----------+----------+------------+---------+----------+--------+
|   7698 | GARRIDO  | DIRECTOR |     7839 | 1981-05-01 | 3850.12 |     NULL |     30 |
+--------+----------+----------+----------+------------+---------+----------+--------+
1 row in set (0.001 sec)

//Sexto Ejercicio
MariaDB [curso]> SELECT *
    -> FROM EMPLEADOS
    -> WHERE DEP_NO IN (20, 30)
    -> ORDER BY SALARIO DESC
    -> LIMIT 2;
+--------+----------+----------+----------+------------+---------+----------+--------+
| EMP_NO | APELLIDO | OFICIO   | DIRECTOR | FECHA_ALTA | SALARIO | COMISION | DEP_NO |
+--------+----------+----------+----------+------------+---------+----------+--------+
|   7698 | GARRIDO  | DIRECTOR |     7839 | 1981-05-01 | 3850.12 |     NULL |     30 |
|   7876 | GIL      | ANALISTA |     7782 | 1982-05-06 | 3350.00 |     NULL |     20 |
+--------+----------+----------+----------+------------+---------+----------+--------+
2 rows in set (0.001 sec)

//Séptimo Ejercicio
MariaDB [curso]> SELECT
    ->     APELLIDO,
    ->     FLOOR(TIMESTAMPDIFF(YEAR, FECHA_ALTA, CURDATE()) / 3) AS TRIENIOS
    -> FROM EMPLEADOS;
+----------+----------+
| APELLIDO | TRIENIOS |
+----------+----------+
| ALONSO   |       14 |
| LOPEZ    |       14 |
| MARTIN   |       14 |
| GARRIDO  |       14 |
| MARTINEZ |       14 |
| REY      |       14 |
| CALVO    |       14 |
| GIL      |       14 |
| JIMENEZ  |       14 |
+----------+----------+
9 rows in set (0.006 sec)

//Octavo Ejercicio
MariaDB [curso]> select*
    -> from empleados
    -> where dayname(fecha_alta) = 'monday';
+--------+----------+----------+----------+------------+---------+----------+--------+
| EMP_NO | APELLIDO | OFICIO   | DIRECTOR | FECHA_ALTA | SALARIO | COMISION | DEP_NO |
+--------+----------+----------+----------+------------+---------+----------+--------+
|   7499 | ALONSO   | VENDEDOR |     7698 | 1981-02-23 | 1400.00 |   400.00 |     30 |
|   7654 | MARTIN   | VENDEDOR |     7698 | 1981-09-28 | 1500.00 |  1600.00 |     30 |
+--------+----------+----------+----------+------------+---------+----------+--------+
2 rows in set (0.001 sec)

//Noveno Ejercicio
MariaDB [curso]> SELECT CONCAT(LEFT(APELLIDO, 3), '.') AS APELLIDO_CORTO
    -> FROM EMPLEADOS;
+----------------+
| APELLIDO_CORTO |
+----------------+
| ALO.           |
| LOP.           |
| MAR.           |
| GAR.           |
| MAR.           |
| REY.           |
| CAL.           |
| GIL.           |
| JIM.           |
+----------------+
9 rows in set (0.000 sec)

//Decimo Ejercicio
MariaDB [curso]> select *
    -> from empleados
    -> ORDER BY SALARIO ASC
    -> limit 5;
+--------+----------+----------+----------+------------+---------+----------+--------+
| EMP_NO | APELLIDO | OFICIO   | DIRECTOR | FECHA_ALTA | SALARIO | COMISION | DEP_NO |
+--------+----------+----------+----------+------------+---------+----------+--------+
|   7521 | LOPEZ    | EMPLEADO |     7782 | 1981-05-08 | 1350.50 |     NULL |     10 |
|   7499 | ALONSO   | VENDEDOR |     7698 | 1981-02-23 | 1400.00 |   400.00 |     30 |
|   7900 | JIMENEZ  | EMPLEADO |     7782 | 1983-03-24 | 1400.00 |     NULL |     20 |
|   7654 | MARTIN   | VENDEDOR |     7698 | 1981-09-28 | 1500.00 |  1600.00 |     30 |
|   7844 | CALVO    | VENDEDOR |     7698 | 1981-09-08 | 1800.00 |     0.00 |     30 |
+--------+----------+----------+----------+------------+---------+----------+--------+
5 rows in set (0.001 sec)
