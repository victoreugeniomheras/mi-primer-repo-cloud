DELIMITER //

--Entrada
Create procedure monitorsaldo (
    IN p_id_matricula INT,
    IN p_umbral_alerta INT,
    OUT p_mensaje_alerta Varchar(20),
    OUT p_falta_pagar decimal(10,2)
    
)

--Salida

principal: BEGIN
    Declare v_pagado decimal(10,2);
    Declare v_precio decimal(10,2);
    Declare v_pendiente decimal(10,2);
        SELECT m.importe_pagado, c.precio 
        INTO v_pagado, v_precio 
        FROM matriculas m 
        JOIN cursos c ON m.id_curso = c.id_curso 
        WHERE m.id_matricula = p_id_matricula;

        IF v_precio IS NULL THEN
            SET p_mensaje_alerta = 'Matricula Inexistente';
            SET p_falta_pagar = 0;
            LEAVE principal;
        END IF;

        SET v_pendiente = v_precio - v_pagado;
        if v:pendiente = 100 - ((v\_pagado / v\_precio) * 100;

        if v_pendiente > p_umbral_alerta;  
            set p_mensaje_alerta = 'Riesgo';
        ELSE IF v_pendiente = 0;
            SET p_mensaje_alerta = 'Pagado Total';
            SET p_mensaje_alerta = 'Deuda Controlada';        
            

    END principal//

    --Llamar procedimiento

    SET @mensaje = '';
    SET @pendiente = '100 - ((v\_pagado / v\_precio) * 100)';

    CALL monitorsaldo (@mensaje, @pendiente, )
    SELECT @mensaje, @diferencia as 'mensaje',@diferencia as 'diferencia'