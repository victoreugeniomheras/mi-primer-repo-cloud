--CORREGIDO (SIN CORREGIR EN CLASE)
DELIMITER //
-- Es una funcion porque pone "Se espera tener este resultado en un informe"
CREATE function becas_progresivas (
    p_id_alumno INT,
    p_numero_curso INT )
    
    RETURNS decimal(10,2)


--Salida

DETERMINISTIC;

principal: BEGIN
    Declare v_numero_veces INT; --Default 1;
    Declare v_precio_curso decimal(10,2);
    Declare v_ahorro_total decimal(10,2); --Se puede usar aqui un "Default 0;" en vez del SET.
    Declare v_descuento decimal(5,2); --Default 0;
         SELECT c.precio INTO v_precio_curso 
         FROM matriculas m JOIN cursos c 
         ON m.id_curso = c.id_curso 
         WHERE m.id_alumno = p_id_alumno;
    

    SET v_numero_veces = 1;
    SET v_ahorro_total = 0;

    WHILE v_numero_veces < p_numero_cursos DO

        IF v_numero_veces = 1 THEN
            SET v_descuento = 0;

        ELSE IF v_numero_veces = 2 THEN
            SET v_descuento = 0.05;

        ELSE IF v_numero_veces =< 3 THEN
            SET v_descuento = 0.10;

        END IF;

        SET v_ahorro_total = v_ahorro_total + (v_precio_curso * v_descuento);
        SET v_numero_veces = v_numero_veces + 1;

    END WHILE;

    SET p_ahorro_total = v_ahorro_total;

    END principal//

    DELIMITER ;

    -- Llamar procedimiento

    CALL becas_progresivas (1, 4, @ahorro_total);
    SELECT @ahorro_total;
