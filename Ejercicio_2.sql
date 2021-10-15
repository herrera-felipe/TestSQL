# Ejercicio 2:
# a) A continuación, realizar las siguientes consultas sobre la base de datos personal:

# 1. Obtener los datos completos de los empleados.
SELECT * FROM empleados;

# 2. Obtener los datos completos de los departamentos.
SELECT * FROM departamentos;

# 3. Listar el nombre de los departamentos.
SELECT nombre_depto FROM departamentos;

# 4. Obtener el nombre y salario de todos los empleados.
SELECT 
    nombre, 
    sal_emp AS 'salario'
FROM
    empleados;

# 5. Listar todas las comisiones.
SELECT comision_emp AS 'comisiones' FROM empleados;

# 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM empleados WHERE cargo_emp = 'Secretaria';

# 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * FROM empleados WHERE cargo_emp = 'vendedor' ORDER BY nombre ASC;

# 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT 
    nombre, 
    cargo_emp, 
    sal_emp
FROM
    empleados
ORDER BY sal_emp ASC;

# 9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para 
# 	 las respectivas tablas de empleados.
SELECT nombre AS 'Nombre', cargo_emp AS 'Cargo' FROM empleados;

# 10. Listar los salarios y comisiones de los empleados del departamento 2000,
#	  ordenado por comisión de menor a mayor.
SELECT 
    nombre, 
    sal_emp, 
    comision_emp
FROM
    empleados
WHERE
    id_depto = 2000
ORDER BY comision_emp ASC;

# 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los
# empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado.
SELECT 
    nombre,
    sal_emp,
    comision_emp,
    (sal_emp + comision_emp + 500) AS 'Salario Total'
FROM
    empleados
WHERE
    id_depto = 3000
ORDER BY nombre;
    
# 12. Muestra los empleados cuyo nombre empiece con la letra J.
SELECT * FROM empleados WHERE nombre LIKE 'j%';

# 13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de
# aquellos empleados que tienen comisión superior a 1000.
SELECT 
    nombre AS 'Nombre',
    sal_emp AS 'Salario',
    comision_emp AS 'Comision',
    (sal_emp + comision_emp) AS 'Salario total'
FROM
    empleados
WHERE
    comision_emp > 1000;
 
# 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT 
    nombre AS 'Nombre',
    sal_emp AS 'Salario',
    comision_emp AS 'Comision',
    (sal_emp + comision_emp) AS 'Salario total'
FROM
    empleados
WHERE
    comision_emp <= 0;
    
# 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo. 
SELECT 
    nombre AS 'Nombre',
    sal_emp AS 'Salario',
    comision_emp AS 'Comision'
FROM
    empleados
WHERE
    comision_emp > sal_emp;
    
# 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT * FROM empleados WHERE comision_emp <= (sal_emp * 0.3);

# 17. Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT * FROM empleados WHERE nombre NOT LIKE '%MA%';

# 18. Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación”
# ni ‘Mantenimiento.
SELECT * FROM departamentos WHERE nombre_depto = 'ventas';

# 19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni
# “Investigación” ni ‘Mantenimiento.
SELECT * FROM departamentos
WHERE
    nombre_depto != 'ventas'
	AND nombre_depto != 'investigacion'
	AND nombre_depto != 'mantenimiento';

#  20. Mostrar el salario más alto de la empresa.
SELECT MAX(sal_emp) AS 'Salario Mas alto' FROM empleados;
# para mostrar a quien correspone de la forma correcta sin error : 
SELECT * FROM empleados WHERE sal_emp = (SELECT MAX(sal_emp) From empleados);

# 21. Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT MAX(nombre) FROM empleados ORDER BY nombre DESC;

# 22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT 
    MAX(sal_emp) AS 'Salario mas alto',
    MIN(sal_emp) AS 'Salario mas bajo',
    (MAX(sal_emp) - MIN(sal_emp)) AS 'Diferencia'
FROM
    empleados;
    
# 23. Hallar el salario promedio por departamento.
SELECT 
    departamentos.nombre_depto AS 'DEPARTAMENTO',
    AVG(empleados.sal_emp) AS 'PROMEDIO SALARIO' # calculamos el promedio de salario
FROM
    empleados
        INNER JOIN # conectamos con la tabla departamento mediante id_depto
    departamentos ON departamentos.id_depto = empleados.id_depto
GROUP BY nombre_depto; # Ordenamos por depto por ende nos muestra los valores totales de c/u de los deptos

# 24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número
# de empleados de esos departamentos.
SELECT 
    departamentos.nombre_depto AS 'Departamento',
    COUNT(empleados.id_emp) AS 'CantEmpleados'
FROM
    empleados
        INNER JOIN
    departamentos ON departamentos.id_depto = empleados.id_depto
GROUP BY departamentos.nombre_depto
HAVING COUNT(id_emp) > 3;

# 25. Mostrar el código y nombre de cada jefe, junto al número de empleados que
# dirige. Solo los que tengan más de dos empleados (2 incluido).
SELECT 
    empleados.cod_jefe AS 'Codigo Jefe',
    empleados.nombre AS 'Nombre',
    COUNT(empleados.id_emp) AS 'CantEmpleados'
FROM
	empleados
GROUP BY empleados.cod_jefe
HAVING COUNT(id_emp) >= 2;

# 26. Hallar los departamentos que no tienen empleados
SELECT 
    departamentos.nombre_depto AS 'Departamento',
    COUNT(empleados.id_emp) AS 'CantEmpleados'
FROM
    empleados
        INNER JOIN
    departamentos ON departamentos.id_depto = empleados.id_depto
GROUP BY departamentos.nombre_depto
HAVING COUNT(id_emp) = 0;

# Consulta con Subconsulta
# 27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio
# de la empresa. Ordenarlo por departamento.
SELECT 
    departamentos.nombre_depto AS 'Departamento',
    empleados.nombre AS 'Nombre',
    empleados.sal_emp AS 'Salario'
FROM
    empleados
        INNER JOIN
    departamentos ON departamentos.id_depto = empleados.id_depto
WHERE
    empleados.sal_emp >= (SELECT AVG(sal_emp) FROM empleados)
ORDER BY departamentos.nombre_depto;

# ELIMINAMOS LA TABLA
DROP DATABASE personal;