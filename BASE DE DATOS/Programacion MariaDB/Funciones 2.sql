DELIMITER //

CREATE FUNCTION mes_critico_pagos (
    p_id_alumno INT,
    p_cuota_mensual DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)

DETERMINISTIC

--Salida

BEGIN

    DECLARE v_deuda DECIMAL(10,2);
    DECLARE v_intereses DECIMAL(10,2);
    DECLARE v_mes INT;

-- Obtener deuda inicial
    SELECT SUM(c.precio - m.importe_pagado)
    INTO v_deuda
    FROM matriculas m
    JOIN cursos c ON m.id_curso = c.id_curso
    WHERE m.id_alumno = p_id_alumno;

    SET v_intereses = 0;
    SET v_mes = 1;
-- Bucle máximo 60 meses o hasta pagar
    WHILE v_mes <= 60 AND v_deuda > 0 DO

-- Pagar cuota
        SET v_deuda = v_deuda - p_cuota_mensual;

-- Evitar deuda negativa
        IF v_deuda < 0 THEN
            SET v_deuda = 0;
        ELSE
--Aplicar interés
            SET v_intereses = v_intereses + (v_deuda * 0.02);
            SET v_deuda = v_deuda + (v_deuda * 0.02);
        END IF;

-- Siguiente mes
        SET v_mes = v_mes + 1;

    END WHILE;

    RETURN v_intereses;

END //

DELIMITER ;