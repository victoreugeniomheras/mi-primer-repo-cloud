/* 1.Muestra el nombre de cada cliente junto con el número de pedido y la fecha de los
pedidos que ha realizado. Solo deben aparecer los clientes que tengan pedidos.
- Selecciono lo que me piden mostrar, la relaciono con pedidos que eslo que me piden 
y al sacar la fecha_pedido nos salen todos.
*/

MariaDB [curso]> select nombre, pedido_no, fecha_pedido
    -> from clientes
    -> inner join pedidos
    -> on clientes.cliente_no = pedidos.cliente_no;
+-------------------------+-----------+--------------+
| nombre                  | pedido_no | fecha_pedido |
+-------------------------+-----------+--------------+
| DISTRIBUCIONES GOMEZ    |      1002 | 1999-10-07   |
| DISTRIBUCIONES GOMEZ    |      1007 | 1999-11-06   |
| DISTRIBUCIONES GOMEZ    |      1014 | 2000-01-07   |
| LOGITRONICA S.L         |      1010 | 1999-12-08   |
| INDUSTRIAS LACTEAS S.A. |      1000 | 1999-10-06   |
| INDUSTRIAS LACTEAS S.A. |      1006 | 1999-11-03   |
| EDICIONES SANZ          |      1003 | 1999-10-16   |
| EDICIONES SANZ          |      1005 | 1999-10-20   |
| EDICIONES SANZ          |      1009 | 1999-11-26   |
| EDICIONES SANZ          |      1012 | 1999-12-06   |
| EDICIONES SANZ          |      1015 | 2000-01-16   |
| EDICIONES SANZ          |      1017 | 2000-01-20   |
| SIGNOLOGIC S.A.         |      1001 | 1999-10-06   |
| SIGNOLOGIC S.A.         |      1004 | 1999-10-20   |
| SIGNOLOGIC S.A.         |      1008 | 1999-11-16   |
| SIGNOLOGIC S.A.         |      1011 | 1999-12-15   |
| SIGNOLOGIC S.A.         |      1013 | 1999-12-06   |
+-------------------------+-----------+--------------+
17 rows in set (0.001 sec)

/*2.Lista todos los departamentos de la empresa y, si tienen empleados, muestra su
apellido. Deben aparecer todos los departamentos, aunque estén vacíos. 
- Hay que ver en los departamentos el dnombre y el apellido que esta en la otra tabla por lo tanto 
hay que enlazar la tabla con empleados. Hay que poner d.dep_no al principio porque sino no 
sabe de que tabla cogerlo
*/
MariaDB [curso]> select d.dep_no, dnombre, apellido
    -> from departamentos d
    -> left join empleados e
    -> on d.dep_no = e.dep_no;
+--------+---------------+----------+
| dep_no | dnombre       | apellido |
+--------+---------------+----------+
|     10 | CONTABILIDAD  | LOPEZ    |
|     10 | CONTABILIDAD  | MARTINEZ |
|     10 | CONTABILIDAD  | REY      |
|     20 | INVESTIGACION | GIL      |
|     20 | INVESTIGACION | JIMENEZ  |
|     30 | VENTAS        | ALONSO   |
|     30 | VENTAS        | MARTIN   |
|     30 | VENTAS        | GARRIDO  |
|     30 | VENTAS        | CALVO    |
|     40 | PRODUCCION    | NULL     |
+--------+---------------+----------+
10 rows in set (0.001 sec)

/* 3. Obtén el nombre de aquellos departamentos que actualmente no tienen ningún empleado
trabajando en ellos.
-
*/

select dnombre, e.*
from departamentos d
left join empleados e
on d.dep_no = e.dep_no
where emp_no is null;