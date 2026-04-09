

- Funciones o precedimientos:
Funciones: Coge unos datos y opera da un resultado
Palabra clave: return
Procedimientos: Realiza acciones


- Crear Procedimientos
([argumentos...]) Los argumentos pueden ser entrada in, salida out o entrada/salida in/out
begin 

end;


- Crear Function
([argumentos...])
returns tipo de dato
begin 

return valor
end;


- Queremos un procedimiento que nos diga si un curso es "Corto","Medio" o "Largo" segun 
su carga lectiva Largo con mas de 50 horas, medio entre 30 y 50 horas.


MariaDB [academia_cursos]> delimiter //
MariaDB [academia_cursos]> create procedure duracioncursos(IN p_id_curso INT,OUT p_categoria VARCHAR(20))
    -> begin
    -> DECLARE v_horas INT;
    -> SELECT horas INTO v_horas
    -> from cursos
    -> where id_curso=p_id_curso;
    -> if v_horas > 50 then
    -> set p_categoria="Largo";
    -> elseif v_horas BETWEEN 30 and 50 then
    -> set p_categoria="Medio";
    -> else
    -> set p_categoria="Corto";
    -> end if;
    -> end//
Query OK, 0 rows affected (0.009 sec)

MariaDB [academia_cursos]> show procedure status where Db='academia_cursos';
    -> ;
    -> //
+-----------------+----------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| Db              | Name           | Type      | Definer        | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
+-----------------+----------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| academia_cursos | duracioncursos | PROCEDURE | root@localhost | 2026-04-07 12:19:54 | 2026-04-07 12:19:54 | DEFINER       |         | utf8mb4              | utf8mb4_general_ci   | utf8mb4_spanish_ci |
+-----------------+----------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
1 row in set (0.027 sec)


