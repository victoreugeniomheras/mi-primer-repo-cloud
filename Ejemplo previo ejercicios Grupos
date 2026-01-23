MariaDB [curso]> select
    -> Dep_no,
    -> sum(salario) as salario_total
    -> from empleados
    -> where oficio <> 'presidente'
    -> group by dep_no
    -> having sum(salario) > 3000
    -> order by salario_total desc
    -> limit 1;
    +--------+---------------+
| Dep_no | salario_total |
+--------+---------------+
|     30 |       8550.12 |
+--------+---------------+
1 row in set (0.004 sec)