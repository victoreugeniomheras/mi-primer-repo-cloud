-- EJERCICIO 1

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
+-------------+-----------+--------+--------------------+------------------------+-----------+------------+---------+-----------------+
6 rows in set (0.001 sec)

MariaDB [academia_cursos]> INSERT INTO profesores (nif, nombre, apellidos, email, telefono, fecha_alta, salario, id_departamento)
    -> VALUES (
    -> '87654321Z',
    -> 'Rodrigo',
    -> 'Castillo Vera',
    -> 'rcastillo@academia.com',
    -> '611222333',
    -> '2025-03-01',
    -> 2300.00,
    -> (SELECT id_departamento
    ->  FROM departamentos
    ->  WHERE presupuesto = (SELECT MAX(presupuesto) FROM departamentos))
    -> );
Query OK, 1 row affected (0.007 sec)

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

--EJERCICIO 2:

--Parte 1:
CREATE TABLE cursos_activos (
    id_curso INT,
    codigo_curso VARCHAR(10),
    nombre_curso VARCHAR(100),
    nombre_dep VARCHAR(80),
    nombre_prof VARCHAR(80),
    plazas INT
);

--Parte 2:
INSERT INTO cursos_activos (id_curso, codigo_curso, nombre_curso, nombre_dep, nombre_prof, plazas)
SELECT c.id_curso,
       c.codigo_curso,
       c.nombre,
       d.nombre,
       p.apellidos,
       c.plazas
FROM cursos c
JOIN departamentos d ON c.id_departamento = d.id_departamento
JOIN profesores p ON c.id_profesor = p.id_profesor
WHERE CURDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;


-- EJERCICIO 3:

--Parte 1:
CREATE TABLE ranking_profesores (
    id_profesor INT,
    nombre_completo VARCHAR(130),
    total_alumnos INT,
    total_cursos INT
);

--Parte 2:
INSERT INTO ranking_profesores (id_profesor, nombre_completo, total_alumnos, total_cursos)
SELECT p.id_profesor,
       CONCAT(p.nombre, ' ', p.apellidos) AS nombre_completo,
       COUNT(DISTINCT m.id_alumno) AS total_alumnos,
       COUNT(DISTINCT c.id_curso) AS total_cursos
FROM profesores p
JOIN cursos c ON p.id_profesor = c.id_profesor
JOIN matriculas m ON c.id_curso = m.id_curso
GROUP BY p.id_profesor
HAVING total_alumnos > 0
ORDER BY total_alumnos DESC;