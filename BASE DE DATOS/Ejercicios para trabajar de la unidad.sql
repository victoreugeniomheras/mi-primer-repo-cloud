/* 1. Departamento del empleado que atiende al cliente del pedido con más unidades */
SUBCONSULTA:
    select dnombre
    from departamentos
    where dep_no =
    (select dep_no from empleados where emp_no =
    (select vendedor_no from clientes where cliente_no =
    (select cliente_no from pedidos where unidades = 
    (select max(unidades) from pedidos))));

MULTITABLA:
    select dnombre
    from (((pedidos pe
    inner join clientes cl
    on pe.cliente_no = cl.cliente_no)
    inner join empleados emp
    on emp.emp_no = cl.vendedor_no)
    inner join departamentos dep
    on emp.dep_no = dep.dep_no)
    group by pe.cliente_no
    having max(unidades);


/*2. Empleados que no han vendido nada y ganan más que la media de VENTAS*/
select e.apellido, e.emp_no
from empleados e
where e.salario < 