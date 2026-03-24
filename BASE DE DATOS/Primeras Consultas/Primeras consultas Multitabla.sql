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

/*4. Muestra el apellido de los empleados y el nombre de los clientes que tienen asignados
como "Vendedor No". Solo muestra empleados que efectivamente sean
vendedores de algún cliente.*/
MariaDB [curso]> select apellido, nombre
    -> from empleados e
    -> inner join clientes c
    -> on e.emp_no = c.vendedor_no;
+----------+-------------------------+
| apellido | nombre                  |
+----------+-------------------------+
| ALONSO   | DISTRIBUCIONES GOMEZ    |
| MARTIN   | LOGITRONICA S.L         |
| CALVO    | INDUSTRIAS LACTEAS S.A. |
| MARTIN   | TALLERES ESTESO S.A.    |
| ALONSO   | EDICIONES SANZ          |
| MARTIN   | SIGNOLOGIC S.A.         |
| CALVO    | MARTIN Y ASOCIADOS S.L. |
| MARTIN   | MANUFACTURAS ALI S.A.   |
+----------+-------------------------+
8 rows in set (0.001 sec)

/*5. Muestra todos los clientes de la base de datos y el número de pedido de las compras que
hayan realizado. Los clientes que no han comprado deben aparecer también.*/

select cli.* , pedido_no
from clientes cli
left outer join pedidos pe on cli.cliente_no = pe.cliente_no;

/*6. Localiza el nombre y localidad de los clientes que nunca han realizado un pedido para
enviarles una oferta de bienvenida.*/

select cli.*, pedido_no
from clientes cli
left outer join pedidos p on cli.cliente_no = p.cliente_no
where pedido_no is null;

/*7. Lista todos los productos (descripción) y las unidades vendidas en cada pedido. Deben
aparecer incluso los productos que no se han vendido nunca.*/

select pro.*, unidades
from productos pro
left outer join pedidos pe on pro.producto_no = pe.producto_no;

/*8.   Muestra la descripción de los productos que no aparecen en ninguna línea de pedido
(productos que no tienen salida).*/
select pro.* , pedido_no
from productos pro
left outer pedidos pe on pro.producto_no = pe.producto_no;
/*No terminada*/