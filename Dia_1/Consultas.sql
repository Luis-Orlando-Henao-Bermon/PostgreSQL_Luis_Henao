-- CONSULTAS SOBRE UNA TABLA

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.

select nombre from producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.

select nombre,precio from producto;

-- 3. Lista todas las columnas de la tabla producto.

select * from producto;

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).

select nombre,precio as precio_euro, precio*1.09 as precio_dolar from producto;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
--    Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.

select nombre,precio as euros, precio*1.09 as dólares from producto;

-- 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.

select upper(nombre),precio from producto;

-- 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.

select lower(nombre),precio from producto;

-- 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.

select nombre,upper(substring(nombre,1,2)) from fabricante;

-- 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.

select nombre,round(precio) from producto;

-- 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.

select nombre,trunc(precio) from producto;

-- 11. Lista el identificador de los fabricantes que tienen productos en la tabla producto.

select codigo as identificador from fabricante;

-- 12. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.

select distinct codigo as identificador from fabricante;

-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.

select nombre from fabricante order by 1 asc;

-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.

select nombre from fabricante order by 1 desc;

-- 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.

select nombre,precio from producto order by 1 asc,2 desc;

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.

select * from fabricante limit 5;

-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.

select * from fabricante offset 3 limit 2;

-- 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)

select nombre,precio from producto order by 2 asc limit 1;

-- 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)

select nombre,precio from producto order by 2 desc limit 1;

-- 20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.

select nombre from producto where codigo_fabricante=2;

-- 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.

select nombre from producto where precio<=120;

-- 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.

select nombre from producto where precio>=400;

-- 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.

select nombre from producto where precio<400;

-- 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.

select * from producto where precio>=80 and precio<=300;

-- 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.

select * from producto where precio between 60 and 200;

-- 26. Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.

select * from producto where precio>200 and codigo_fabricante=6;

-- 27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.

select * from producto where codigo_fabricante=1 or codigo_fabricante=3 or codigo_fabricante=5;

-- 28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.

select * from producto where codigo_fabricante in (1,3,5);

-- 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que se llame céntimos.

select nombre, precio*100 as céntimos from producto;

-- 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.

select nombre from fabricante where nombre like 'S%';

-- 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.

select nombre from fabricante where nombre like '%e';

-- 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.

select nombre from fabricante where nombre like '%w%';

-- 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.

select nombre from fabricante where length(nombre)=4;

-- 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.

select * from producto where nombre like '%Portátil%';

-- 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.

select * from producto where nombre like '%Monitor%' and precio<215;

-- 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€.
--     Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).

select precio,nombre from producto where precio>=180 order by 1 desc,2 asc;



-- CONSULTAS MULTITABLA (Composición interna)
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.

select p.nombre as nombre_producto, p.precio, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo; 

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
--    Ordene el resultado por el nombre del fabricante, por orden alfabético.

select p.nombre as nombre_producto, p.precio, f.nombre as nombre_fabricante 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo order by 3 asc; 

-- 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.

select p.codigo, p.nombre,f.codigo,f.nombre 
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo; 

-- 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.

select p.nombre,p.precio,f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo order by p.precio asc limit 1; 

-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.

select p.nombre,p.precio,f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo order by p.precio desc limit 1; 

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.

select p.* from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo where f.nombre='Lenovo'; 

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

select p.* from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo where f.nombre='Crucial' and p.precio>200; 

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.

select p.*,f.nombre as nombre_fabricante from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo where f.nombre='Asus' or f.nombre='Hewlett-Packard' or f.nombre='Seagate'; 

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.

select p.*,f.nombre as nombre_fabricante from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo where f.nombre in ('Asus','Hewlett-Packard','Seagate');

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.

select p.nombre,p.precio,f.nombre as nombre_fabricante from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo where f.nombre like ('%e');

-- 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.

select p.nombre,p.precio,f.nombre as nombre_fabricante from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo where f.nombre like ('%w%');

-- 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€.
--     Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).

select p.nombre,p.precio,f.nombre as nombre_fabricante
from producto p inner join fabricante f on p.codigo_fabricante=f.codigo where p.precio>=180 order by 2 desc, 1 asc; 

-- 13. Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
select distinct f.* from producto p inner join fabricante f 
on p.codigo_fabricante=f.codigo order by 1;