/*1. Calcula cuántos empleados tiene cada departamento. 
Solo deben aparecer los departamentos que tienen empleados asignados.  */

select  de.dep_no, count(em.emp_no)
from empleados em
left outer join departamentos de
on em.dep_no = de.dep_no
group by de.dep_no;

MariaDB [curso]> select  de.dep_no, count(em.emp_no)
    -> from empleados em
    -> left outer join departamentos de
    -> on em.dep_no = de.dep_no
    -> group by de.dep_no;
+--------+------------------+
| dep_no | count(em.emp_no) |
+--------+------------------+
|     10 |                3 |
|     20 |                2 |
|     30 |                4 |
+--------+------------------+
3 rows in set (0.008 sec)


/* 2. Obtén el nombre del departamento y la suma de los salarios de sus empleados, 
pero solo para departamentos cuya masa salarial supere los 10.000€.  */

MariaDB [curso]> select de.dnombre, sum(salario) as total_salario
    -> from empleados em
    -> inner join departamentos de
    -> on em.dep_no = de.dep_no
    -> group by de.dep_no
    -> having total_salario < 10.000;
Empty set (0.001 sec)

/* 3.Muestra todos los vendedores (empleados con oficio 'VENDEDOR') y el nombre de 
los clientes que gestionan. Si un vendedor no tiene clientes, debe aparecer también en 
la lista.  */

MariaDB [curso]> select em.emp_no, cli.nombre, em.oficio
    -> from empleados em
    -> left outer join clientes cli
    -> on em.emp_no = cli.vendedor_no
    -> where oficio = 'VENDEDOR';
+--------+-------------------------+----------+
| emp_no | nombre                  | oficio   |
+--------+-------------------------+----------+
|   7499 | DISTRIBUCIONES GOMEZ    | VENDEDOR |
|   7499 | EDICIONES SANZ          | VENDEDOR |
|   7654 | LOGITRONICA S.L         | VENDEDOR |
|   7654 | TALLERES ESTESO S.A.    | VENDEDOR |
|   7654 | SIGNOLOGIC S.A.         | VENDEDOR |
|   7654 | MANUFACTURAS ALI S.A.   | VENDEDOR |
|   7844 | INDUSTRIAS LACTEAS S.A. | VENDEDOR |
|   7844 | MARTIN Y ASOCIADOS S.L. | VENDEDOR |
+--------+-------------------------+----------+
8 rows in set (0.001 sec)

/* 4. Encuentra los productos que nunca se han vendido (stock muerto), pero 
solo aquellos que pertenecen a la categoría 'MESA DESPACHO MOD. GAVIOTA' y 
cuyo stock sea mayor a 10 unidades.  */

MariaDB [curso]> select pro.*, pe.pedido_no, fecha_pedido
    -> from productos pro
    -> left outer join pedidos pe
    -> on pro.producto_no = pe.producto_no
    -> where descripcion = 'MESA DESPACHO MOD. GAVIOTA' and stock_disponible > 10;
+-------------+----------------------------+---------------+------------------+-----------+--------------+
| PRODUCTO_NO | DESCRIPCION                | PRECIO_ACTUAL | STOCK_DISPONIBLE | pedido_no | fecha_pedido |
+-------------+----------------------------+---------------+------------------+-----------+--------------+
|          10 | MESA DESPACHO MOD. GAVIOTA |        550.00 |               50 |      1002 | 1999-10-07   |
|          10 | MESA DESPACHO MOD. GAVIOTA |        550.00 |               50 |      1008 | 1999-11-16   |
|          10 | MESA DESPACHO MOD. GAVIOTA |        550.00 |               50 |      1012 | 1999-12-06   |
+-------------+----------------------------+---------------+------------------+-----------+--------------+
3 rows in set (0.001 sec)

/* 5. Muestra todos los departamentos de la empresa y cuántos empleados tiene cada uno. Si 
un departamento está vacío, debe aparecer con un 0 (no debe desaparecer de la lista).  */

MariaDB [curso]> select dnombre, em.*, count(emp_no) as total_empleados
    -> from departamentos de
    -> left outer join empleados em
    -> on de.dep_no = em.dep_no
    -> group by dep_no;
+---------------+--------+----------+----------+----------+------------+---------+----------+--------+-----------------+
| dnombre       | EMP_NO | APELLIDO | OFICIO   | DIRECTOR | FECHA_ALTA | SALARIO | COMISION | DEP_NO | total_empleados |
+---------------+--------+----------+----------+----------+------------+---------+----------+--------+-----------------+
| PRODUCCION    |   NULL | NULL     | NULL     |     NULL | NULL       |    NULL |     NULL |   NULL |               0 |
| CONTABILIDAD  |   7521 | LOPEZ    | EMPLEADO |     7782 | 1981-05-08 | 1350.50 |     NULL |     10 |               3 |
| INVESTIGACION |   7876 | GIL      | ANALISTA |     7782 | 1982-05-06 | 3350.00 |     NULL |     20 |               2 |
| VENTAS        |   7499 | ALONSO   | VENDEDOR |     7698 | 1981-02-23 | 1400.00 |   400.00 |     30 |               4 |
+---------------+--------+----------+----------+----------+------------+---------+----------+--------+-----------------+
4 rows in set (0.001 sec)

/* 6. Lista los clientes que no han realizado ningún pedido en el año 2005, ordenados 
alfabéticamente por nombre.  */

MariaDB [curso]> select cli.* , fecha_pedido
    from clientes cli
    left outer join pedidos pe
    on cli.cliente_no = pe.cliente_no
    and year(fecha_pedido) between 2005/1/01 and 2005/12/31
    order by cli.cliente_no asc;

+------------+-------------------------+-----------+-------------+------+-------+----------------+--------------+
| CLIENTE_NO | NOMBRE                  | LOCALIDAD | VENDEDOR_NO | DEBE | HABER | LIMITE_CREDITO | fecha_pedido |
+------------+-------------------------+-----------+-------------+------+-------+----------------+--------------+
|        101 | DISTRIBUCIONES GOMEZ    | MADRID    |        7499 | 0.00 |  0.00 |        5000.00 | NULL         |
|        105 | EDICIONES SANZ          | BARCELONA |        7499 | 0.00 |  0.00 |        5000.00 | NULL         |
|        103 | INDUSTRIAS LACTEAS S.A. | LAS ROZAS |        7844 | 0.00 |  0.00 |       10000.00 | NULL         |
|        102 | LOGITRONICA S.L         | BARCELONA |        7654 | 0.00 |  0.00 |        5000.00 | NULL         |
|        108 | MANUFACTURAS ALI S.A.   | SEVILLA   |        7654 | 0.00 |  0.00 |        5000.00 | NULL         |
|        107 | MARTIN Y ASOCIADOS S.L. | ARAVACA   |        7844 | 0.00 |  0.00 |       10000.00 | NULL         |
|        106 | SIGNOLOGIC S.A.         | MADRID    |        7654 | 0.00 |  0.00 |        5000.00 | NULL         |
|        104 | TALLERES ESTESO S.A.    | SEVILLA   |        7654 | 0.00 |  0.00 |        5000.00 | NULL         |
+------------+-------------------------+-----------+-------------+------+-------+----------------+--------------+
8 rows in set (0.001 sec)

/* 7. Lista el nombre del departamento, apellido del empleado y nombre del cliente, para 
aquellos empleados que son vendedor de algun departamento */ 

MariaDB [curso]> select de.dnombre, em.apellido, nombre
    -> from (departamentos de
    -> inner join empleados em
    -> on de.dep_no = em.dep_no)
    -> inner join clientes cli
    -> on cli.vendedor_no = em.emp_no;
+---------+----------+-------------------------+
| dnombre | apellido | nombre                  |
+---------+----------+-------------------------+
| VENTAS  | ALONSO   | DISTRIBUCIONES GOMEZ    |
| VENTAS  | MARTIN   | LOGITRONICA S.L         |
| VENTAS  | CALVO    | INDUSTRIAS LACTEAS S.A. |
| VENTAS  | MARTIN   | TALLERES ESTESO S.A.    |
| VENTAS  | ALONSO   | EDICIONES SANZ          |
| VENTAS  | MARTIN   | SIGNOLOGIC S.A.         |
| VENTAS  | CALVO    | MARTIN Y ASOCIADOS S.L. |
| VENTAS  | MARTIN   | MANUFACTURAS ALI S.A.   |
+---------+----------+-------------------------+
8 rows in set (0.000 sec)

/* 8. Nombre del departamento y apellido de los empleados cumpliendo que los departamentos tengan empleados y 
ademas los empleados no tengan clientes asignados */

MariaDB [curso]> SELECT d.DNOMBRE, e.APELLIDO
    -> FROM DEPARTAMENTOS d
    -> INNER JOIN EMPLEADOS e
    ->     ON d.DEP_NO = e.DEP_NO
    -> LEFT JOIN CLIENTES c
    ->     ON e.EMP_NO = c.VENDEDOR_NO
    -> WHERE c.CLIENTE_NO IS NULL;
+---------------+----------+
| DNOMBRE       | APELLIDO |
+---------------+----------+
| CONTABILIDAD  | LOPEZ    |
| CONTABILIDAD  | MARTINEZ |
| CONTABILIDAD  | REY      |
| INVESTIGACION | GIL      |
| INVESTIGACION | JIMENEZ  |
| VENTAS        | GARRIDO  |
+---------------+----------+
6 rows in set (0.003 sec)


