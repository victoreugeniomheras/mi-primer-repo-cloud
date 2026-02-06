/*Ejercicio 1:
Solo se pueden ver los productos para los que no hay
ningun pedido.
*/

SELECT DESCRIPCION
FROM PRODUCTOS
WHERE NOT EXISTS (
    SELECT 1
    FROM PEDIDOS
    WHERE PEDIDOS.PRODUCTO_NO = PRODUCTOS.PRODUCTO_NO

);
+-----------------------------+
| DESCRIPCION                 |
+-----------------------------+
| CAJA SEGURIDAD MOD B222     |
| MODULO ORDENADOR MOD. ERGOS |
+-----------------------------+
2 rows in set (0.002 sec)

/*Ejercicio 2:
VER LAS FECHAS EN LAS QUE GOMEZ HIZO PEDIDOS*/
/*QUIEN PIDIO ALGO EN ESAS FECHAS*/

MariaDB [curso]> select fecha_pedido
    -> from pedidos
    -> where cliente_no not like (select apellido from empleados where apellido='%GOMEZ%');
Empty set (0.001 sec)
/*EMPTY QUIERE DECIR QUE NADIE PIDIO NADA EL MISMO DIA QUE GOMEZ */

/*Ejercicio 3:
TENGO QUE CONTAR LOS EMPLEADOS DEL DEPARTAMENTO 20
*/
