# Ejercicio 03
# 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre AS 'Nombre Producto' FROM producto;

# 2. Lisfabricanteta los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

# 3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

# 4. Lista los nombres y los precios de todos los productos de la tabla producto,
# redondeando el valor del precio.
SELECT nombre, round(precio) AS 'Precio redondeado' FROM producto;

# 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT 
	f.nombre AS 'Fabricante',
	f.codigo, 
	count(p.codigo_fabricante) AS'# Productos'
FROM 
	producto p 
    INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY f.nombre;

# 10. Lista el código de los fabricantes que tienen productos en la tabla producto, sin
# mostrar los repetidos.
SELECT p.codigo_fabricante , p.nombre FROM producto p GROUP BY p.codigo_fabricante;

# 11. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT f.nombre FROM fabricante f ORDER BY f.nombre ASC;

# 12. Lista los nombres de los productos ordenados en primer lugar por el nombre de
# forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT * FROM producto p ORDER BY p.nombre;
SELECT * FROM producto p ORDER BY p.precio DESC;

# 13. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante f WHERE f.codigo LIMIT 5;

# 14. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
# ORDER BY y LIMIT)
SELECT 
    p.nombre AS 'Mas barato', p.precio
FROM
    producto p
ORDER BY precio
LIMIT 1;

# 15. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas
# ORDER BY y LIMIT)
SELECT 
    p.nombre AS 'Mas caro', p.precio
FROM
    producto p
ORDER BY precio DESC
LIMIT 1;

# 16. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT 
    nombre, precio
FROM
    producto
WHERE
    precio <= 120
ORDER BY precio ASC;

# 17. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el
# operador BETWEEN.
SELECT 
    nombre, precio
FROM
    producto
WHERE
    precio BETWEEN 60 AND 200
ORDER BY precio ASC;

# 18. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el
# operador IN.
SELECT 
    nombre, precio, codigo_fabricante
FROM
    producto
WHERE
    codigo_fabricante = 1
        OR codigo_fabricante = 3
        OR codigo_fabricante = 5
ORDER BY nombre ASC;

# 23. Devuelve una lista con el nombre de todos los productos que contienen la cadena
# Portátil en el nombre.
SELECT 
    nombre, precio, codigo_fabricante
FROM
    producto
WHERE
    nombre LIKE '%Portatil%'
ORDER BY precio ASC;

# Consultas Multitabla
# 1. Devuelve una lista con el código del producto, nombre del producto, código del
# fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT 
    p.codigo AS 'CodProducto',
    p.nombre AS 'Producto',
    f.codigo AS 'CodFabricante',
    f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
ORDER BY f.nombre ASC;

# 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de
# todos los productos de la base de datos. Ordene el resultado por el nombre del
# fabricante, por orden alfabético.
SELECT 
    p.nombre AS 'Producto',
    p.precio AS 'Precio',
    f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
ORDER BY f.nombre ASC;

# 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del
# producto más barato.
SELECT 
    p.nombre AS 'Porducto',
    p.precio AS 'Precio', 
    f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
ORDER BY p.precio ASC
LIMIT 1 , 5;

# 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT 
    p.nombre AS 'Producto', p.precio, f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
WHERE
    f.nombre LIKE 'Lenovo%'
ORDER BY p.nombre;

# 5) Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT 
    p.nombre AS 'Producto', p.precio, f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
WHERE
    f.nombre LIKE 'Crucial%'
        AND p.precio > 200;
        
# 6) Devuelve un listado con todos los productos de los fabricantes Asus, HewlettPackard. Utilizando el operador IN.
SELECT 
    p.nombre AS 'Producto', p.precio, f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
WHERE
    f.nombre IN ('Asus' , 'Hewlett-Packard')
ORDER BY p.nombre;

# 7) Devuelve un listado con el nombre de producto, precio y nombre de fabricante, 
# de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar 
# por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT 
    p.nombre AS 'Producto', p.precio, f.nombre AS 'Fabricante'
FROM
    producto p,
    fabricante f
WHERE
    p.precio >= 180
ORDER BY p.precio DESC , p.nombre ASC;

# Consultas Multitabla 
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# 1) Devuelve un listado de todos los fabricantes que existen en la base de datos, 
# junto con los productos que tiene cada uno de ellos. El listado deberá mostrar 
# también aquellos fabricantes que no tienen productos asociados.
SELECT * FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

# 2) Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT *
FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
WHERE p.codigo_fabricante IS NULL;
    
# Subconsultas (En la cláusula WHERE) 
# Con operadores básicos de comparación.

# 1) Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * 
FROM fabricante f,producto p
WHERE f.nombre LIKE 'Lenovo%';

# 2) Devuelve todos los datos de los productos que tienen el mismo precio que el producto 
# más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT *
FROM fabricante f,
	 producto p
WHERE
    p.precio = (SELECT MAX(p.precio)
        FROM
            fabricante f,
            producto p
        WHERE
            f.nombre LIKE 'Lenovo%' AND p.codigo_fabricante = f.codigo
        GROUP BY f.nombre)
        AND p.codigo_fabricante = f.codigo;
        
# 3) Lista el nombre del producto más caro del fabricante Lenovo.
SELECT *, MAX(p.precio)
FROM fabricante f , producto p
WHERE f.nombre LIKE 'lenovo%' AND p.codigo_fabricante = f.codigo; 

# 4) Lista todos los productos del fabricante Asus que tienen un precio superior al 
# precio medio de todos sus productos.
SELECT  *
FROM fabricante f, producto p
WHERE p.precio > (SELECT AVG(p.precio)
        FROM producto p, fabricante f
        WHERE f.nombre LIKE 'Asus%' AND f.codigo = p.codigo_fabricante
        GROUP BY p.codigo_fabricante)
        AND f.codigo = p.codigo_fabricante
        AND f.nombre LIKE 'Asus%';
        
# Subconsultas con IN y NOT IN
# 1) Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN). 
SELECT f.nombre
FROM fabricante f , producto p
WHERE f.codigo IN(p.codigo_fabricante)
GROUP BY f.nombre;

# 2) Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT 
    f.nombre
FROM
    fabricante f,
    producto p
WHERE
    f.codigo NOT IN (SELECT p.codigo_fabricante FROM producto p GROUP BY p.codigo_fabricante)
GROUP BY f.nombre;

# Subconsultas (En la cláusula HAVING)
# 1) Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT 
    f.codigo, f.nombre
FROM
    fabricante f,
    producto p
WHERE
    p.codigo_fabricante = f.codigo
GROUP BY f.codigo
HAVING COUNT(f.codigo) = (SELECT COUNT(f.codigo)
    FROM
        producto p,
        fabricante f
    WHERE
        p.codigo_fabricante = f.codigo AND f.nombre LIKE 'lenovo%'
    GROUP BY f.codigo);
    
 DROP DATABASE tienda;   