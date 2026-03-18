-- Se puede utilizar multitablas y subconsultas.
-- Si hacemos select no hace falta poner values.


CREATE TABLE EMPLEADOS_VENTAS (
      EMP_NO   INT(4),
      APELLIDO VARCHAR(8),
      OFICIO   VARCHAR(10),
      SALARIO  FLOAT(6,2)
  );

--1:
INSERT INTO EMPLEADOS_VENTAS (EMP_NO, APELLIDO, OFICIO, SALARIO)
SELECT EMP_NO, APELLIDO, OFICIO, SALARIO
FROM EMPLEADOS WHERE DEP_NO = (SELECT DEP_NO FROM DEPARTAMENTOS WHERE DNOMBRE = 'VENTAS');

--2:
INSERT INTO EMPLEADOS_VENTAS
VALUES (8009, 'GARRIDO', 'VENDEDOR', (SELECT AVG(SALARIO) FROM EMPLEADOS WHERE DEP_NO = (SELECT DEP_NO 
FROM DEPARTAMENTOS WHERE DNOMBRE = 'VENTAS')));

--Sube el credito a los clientes que han sido atendidos por empleados del departametno 
--ventas , ojo solo a los departamentos ventas , si un cliente ha atendido un empleado
--no suba el limite porque le consideramos especifico.

UPDATE clientes
SET LIMITE_CREDITO = LIMITE_CREDITO*2
WHERE VENDEDOR_NO IN (SELECT EMP_NO FROM EMPLEADOS WHERE DEP_NO = (SELECT DEP_NO 
FROM DEPARTAMENTOS WHERE DNOMBRE = 'VENTAS'));