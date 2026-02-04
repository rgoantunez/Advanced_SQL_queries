--Ejercicio 1: 
--Crea el esquema de la BBDD. >> Ver foto del esquema adjunto en repositorio y/o Readme.

--Ejercicio 2:
--Muestra los nombres de todas las películas con una clasificación por edades de ‘R’
select title, rating
from film f 
where rating in ('R');

--Ejercicio 3: 
--Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select actor_id, first_name, last_name 
from actor
where actor_id > 30 and actor_id < 40;

--Ejercicio 3 (solucion alternativa):
select actor_id, first_name, last_name 
from actor
where actor_id between 30 and 40;

--Ejercicio 4:
--Obtén las películas cuyo idioma coincide con el idioma original.
select f.title, l.language_id, f.original_language_id as "Idioma_Original"		
from film f 
left join language l 
on f.language_id = l.language_id
order by f.language_id;
	--Comentario: columna: original_language_id = vacía. Hago un left join, porque si hago un inner me devuelve todo null.

--Ejercicio 5:
--Ordena las películas por duración de forma ascendente.
select length, title
from film f
order by length asc;

--Ejercicio 6:
--Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select first_name, last_name 
from actor a
where a.last_name in ('ALLEN');

--Ejercicio 7:
--Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select COUNT(title) as Nombre	
from film f;
select COUNT(description) as Sinopsis
from film f;
select COUNT(release_year) as Lanzamiento
from film; 
select COUNT(language_id) as Idioma
from film f;
select COUNT(original_language_id) as Idioma_Original	
from film f;
select COUNT(rental_duration) as Duracion_Alquiler
from film f;
select COUNT(rental_rate) as Precio_Alquiler	
from film f;
select COUNT(length) as "Duracion"
from film f;
select COUNT(replacement_cost) as "Costo_Cambio"
from film f;
select COUNT(rating) as "Rating"
from film f;
select COUNT(last_update) as "Actualizacion"
from film f;
select COUNT(special_features) as "Contenido_Especial"
from film f;
select COUNT(fulltext) as "Guion_Completo"
from film f;

--Ejercicio 8:
--Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select title, length, rating 
from film f
where rating = 'PG-13' or length > 180;

--Ejercicio 9:
--Encuentra la variabilidad de lo que costaría reemplazar las películas.
select ROUND(VARIANCE(replacement_cost),2) as Variabilidad_Reemplazo
from film f;

--Ejercicio 10:
--Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MIN(length) as Duracion_Minima, 
	   MAX(length) as Duracion_Maxima
from film f;

--Ejercicio 11: 
--Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
	--Observando la salida del siguiente script, observamos que costó 2.99 (tercer fila).
select r.rental_id, r.rental_date as Fecha_Alquiler, p.amount as Costo_Alquiler
from rental r
inner join payment p
on r.rental_id = p.rental_id
order by fecha_alquiler desc;

--Ejercicio 12:
--Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select title, rating 
from film
where rating not in ('NC-17', 'G');

--Ejercicio 13:
--Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select rating as Clasificacion, ROUND(AVG(length),2) as Duracion_Promedio
from film
group by rating;

--Ejercicio 14:
--Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title as Titulo, length as Duracion
from film f
group by titulo, duracion 
having AVG(length) > 180;

--Ejercicio 15:
--¿Cuánto dinero ha generado en total la empresa?
select SUM(amount) as Total_Facturado
from payment;

--Ejercicio 16:
--Muestra los 10 clientes con mayor valor de id.
select CONCAT(first_name, ' ', last_name) as Nombre_Cliente, customer_id
from customer
order by customer_id desc
limit 10;

--Ejercicio 17:
--Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
with ID_ACTORES as ( 
					select fa.actor_id 
					from film f
					inner join film_actor fa
					on f.film_id = fa.film_id
					where title IN('EGG IGBY')
					)
select a.first_name as NOMBRE, a.last_name as APELLIDO
from actor a 
inner join ID_ACTORES 
on a.actor_id = ID_ACTORES.actor_id;

--Ejercicio 18:
--Selecciona todos los nombres de las películas únicos.
select title as Nombre_Pelicula
from film f
order by title asc;

--Ejercicio 19:
--Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
with COMEDIAS as (					
					select category_id
					from category c
					where name in ('Comedy')
				 ),
	 IDENTIFICADOR as (
						select fc.film_id
						from COMEDIAS
						inner join film_category fc
						on fc.category_id = COMEDIAS.category_id
				 		)
select f.film_id, f.title, f.length
from film f 
inner join IDENTIFICADOR 
on f.film_id = IDENTIFICADOR.film_id
where length > 180;

--Ejercicio 20:
--Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
with PROMEDIO_110 as (
					  select f.film_id, fc.category_id, f.length
					  from film f
					  join film_category fc 
					  on f.film_id = fc.film_id
					  group by f.film_id, fc.category_id 
					  having AVG(length) > 110
					  )
select c.name, PROMEDIO_110.length
from category c
inner join PROMEDIO_110
on PROMEDIO_110.category_id = c.category_id;

--Ejercicio 21:
--¿Cuál es la media de duración del alquiler de las películas?
select AVG(rental_duration) as PROM_DIAS_DE_ALQUILER
from film;

	--Solucion alternativa:
select AVG(return_date - rental_date) as PROM_DIAS_DE_ALQUILER
from rental;

--Ejercicio 22:
--Crea una columna con el nombre y apellidos de todos los actores y actrices.
select CONCAT(first_name, ' ', last_name) as NOMBRE_Y_APELLIDO
from actor;

--Ejercicio 23:
--Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select DATE(rental_date) as FECHA, COUNT(*) as CANT_ALQUILERES
from rental
group by FECHA
order by CANT_ALQUILERES desc;

--Ejercicio 24:
--Encuentra las películas con una duración superior al promedio.
	--Consulto el promedio
select AVG(length) as PROMEDIO
from film;
	--Consulto aquellas peliculas con duración mayor al promedio
select title as PELICULA, length as DURACION
from film f
group by title, length
having length > 115.272;

--Ejercicio 25: (mediante consulta a Gemini ante la dificultad de separar meses)
--Averigua el número de alquileres registrados por mes.
select TO_CHAR(rental_date, 'YYYY-MM') as MES, COUNT(*) as CANT_ALQUILERES
from rental
group by MES
order by MES;

--Ejercicio 26:
--Encuentra el promedio, la desviación estándar y varianza del total pagado.
select AVG(amount) as PROMEDIO
from payment p;

select STDDEV(amount) as VAR_STANDAR
from payment p;

select VARIANCE(amount) as VARIANZA
from payment p;

--Ejercicio 27:
--¿Qué películas se alquilan por encima del precio medio?
	--Consulto el precio promedio 
select AVG(rental_rate) as PRECIO_PROMEDIO
from film f;
	--Consulto aquellas por encima del precio_promedio
select title, rental_rate
from film f
where rental_rate > 2.98;

--Ejercicio 28:
--Muestra el id de los actores que hayan participado en más de 40 películas.
select actor_id, COUNT(film_id)
from film_actor fa
group by actor_id
having COUNT(distinct(film_id)) > 40;

--Ejercicio 29:
--Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select COUNT(distinct(film_id)) as TOTAL_PELICULAS,
	   COUNT(inventory_id) as EJEMPLARES_EN_INVENTARIO
from inventory;

--Ejercicio 30:
--Obtener los actores y el número de películas en las que ha actuado.
select actor_id, COUNT(film_id) as CANTIDAD_PELICULAS
from film_actor
group by actor_id
having COUNT(film_id) > 0
order by actor_id;

--Ejercicio 31:
--Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title as PELICULAS, fa.actor_id as ACTORES_PROTAGONISTAS
from film_actor fa 
full join film f 
on fa.film_id = f.film_id
order by PELICULAS;

--Ejercicio 32:
--Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select CONCAT(a.first_name, ' ', a.last_name) as ACTOR, fa.film_id
from actor a 
full join film_actor fa
on a.actor_id = fa.actor_id;

--Ejercicio 33:
--Obtener todas las películas que tenemos y todos los registros de alquiler.
	--Interpretacioón A:
select COUNT(inventory_id) as TOTAL_REG_ALQUILERES
from rental;

select COUNT(film_id) as TOTAL_PELICULAS
from film;
	--Interpretación B:
select inventory_id as REG_ALQUILER, COUNT(rental_id) as TOTAL_ALQUILERES
from rental
group by inventory_id
order by inventory_id;

--Ejercicio 34:
--Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select customer_id, SUM(amount) as TOTAL_GASTADO_CLIENTE
from payment
group by customer_id 
order by TOTAL_GASTADO_CLIENTE desc
limit 5;

--Ejercicio 35:
--Selecciona todos los actores cuyo primer nombre es ' Johnny'.
select first_name, last_name
from actor
where first_name in ('JOHNNY');

--Ejercicio 36:
--Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select first_name as NOMBRE, last_name as APELLIDO
from actor
where first_name in ('JOHNNY');

--Ejercicio 37:
--Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MIN(actor_id) as ID_MAS_BAJO,
	   MAX(actor_id) as ID_MAS_ALTO
from actor;

--Ejercicio 38:
--Cuenta cuántos actores hay en la tabla “actor”.
select COUNT(actor_id) as TOTAL_ACTORES
from actor;

--Ejercicio 39:
--Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select first_name, last_name
from actor
order by last_name asc;

--Ejercicio 40:
--Selecciona las primeras 5 películas de la tabla “film”.
	--VEO EL ORDEN POR DEFECTO DE LA TABLA:
select *
from film;
	--SELECCIONO LAS PRIMERAS 5 PELICULAS:
select *
from film
order by film_id asc
limit 5;

--Ejercicio 41:
--Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select first_name, COUNT(first_name) as TOTAL_NOMBRES
from actor
group by first_name
order by TOTAL_NOMBRES desc;
	--Los nombres más repetidos son: KENNETH, PENELOPE y JULIA (4 veces cada uno).

--Ejercicio 42:
--Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id as NRO_ALQUILER, CONCAT(c.first_name, ' ', c.last_name) as NOMBRE_CLIENTE
from rental r
inner join customer c
on r.customer_id = c.customer_id;

--Ejercicio 43:
--Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select c.first_name, c.last_name, r.rental_id, c.customer_id
from customer c
inner join rental r
on c.customer_id = r.customer_id
order by c.customer_id;

--Ejercicio 44:
--Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f
cross join category c;
	--ESTE CROSS JOIN NO APORTA VALOR, YA QUE ASIGNA EL GÉNERO A LAS PELÍCULAS PERO SIN NINGUN VÍNCULO. DE HECHO, PARA UNA MISMA PELICULA ASOCIA LOS DISTINTOS GÉNEROS (LO QUE ES INCOHERENTE CON LA BASE DE DATOS).

--Ejercicio 45:
--Encuentra los actores que han participado en películas de la categoría 'Action'.
	--Chequeo la CATEGORY_ID para el género 'ACTION':
select name, category_id
from category
where name in ('Action');
	--Consulo los actores para el género 'ACTION':
	with PELIS_ACTION as (  select film_id
							from film_category
							where category_id = 1),
		 ELENCO_ACTION as (	select fa.actor_id
							from film_actor fa
							inner join PELIS_ACTION 
							on fa.film_id = PELIS_ACTION.film_id
							)
select a.first_name, a.last_name
from actor a 
inner join ELENCO_ACTION
on a.actor_id = ELENCO_ACTION.actor_id
group by a.actor_id;

--Ejercicio 46:
--Encuentra todos los actores que no han participado en películas.
select a.actor_id
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
where fa.actor_id < 200;

	--Solución alternativa:
select actor_id, film_id
from film_actor
where actor_id = NULL;

--Chequeo que todos los actores protagonizan al menos una pelicula y todas las peliculas tienen actores:
	select COUNT(a.actor_id) as TOTAL_PELI_POR_ACTOR, COUNT(fa.actor_id) as ACTORES_CON_PELICULAS
	from actor a
	full join film_actor fa 
	on a.actor_id = fa.actor_id
	group by a.actor_id, fa.actor_id;


--Ejercicio 47:
--Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select fa.actor_id, CONCAT(a.first_name, ' ', a.last_name) as NOMBRE_ACTOR, COUNT(film_id) as CANT_PELICULAS
from film_actor fa
inner join actor a
on fa.actor_id = a.actor_id
group by fa.actor_id, a.first_name, a.last_name
order by fa.actor_id;

--Ejercicio 48:
--Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as (
									select CONCAT(a.first_name, ' ', a.last_name), COUNT(film_id)
									from film_actor fa
									inner join actor a
									on fa.actor_id = a.actor_id
									group by a.first_name, a.last_name
									);
select *
from actor_num_peliculas;

--Ejercicio 49:
--Calcula el número total de alquileres realizados por cada cliente.
select customer_id as CLIENTE, COUNT(rental_id) as TOTAL_ALQUILERES
from rental
group by customer_id
order by customer_id;

	--PLUS: Incluyendo Nombres de Clientes:
select r.customer_id, CONCAT(c.first_name, ' ', c.last_name) as CLIENTE, COUNT(rental_id) as TOTAL_ALQUILERES
from rental r
inner join customer c
on r.customer_id = c.customer_id
group by r.customer_id, c.first_name, c.last_name
order by r.customer_id;

--Ejercicio 50:
--Calcula la duración total de las películas en la categoría 'Action'.
select f.film_id, f.length as DURACION_TOTAL
from film f
inner join film_category fc
on f.film_id = fc.film_id
where fc.category_id = 1
group by f.film_id
order by f.film_id;

	--PLUS: Duración Total de TODAS las peliculas de Acción:
select SUM(f.length) as DURACION_TOTAL
from film f
inner join film_category fc
on f.film_id = fc.film_id
where fc.category_id = 1;

--Ejercicio 51:
--Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary TABLE cliente_rentas_temporal as 

select customer_id as ID_CLIENTE, COUNT(rental_id) as TOTAL_ALQUILERES
from rental
group by customer_id
order by customer_id;

--Ejercicio 52:
--Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as			 

select i.film_id as ID_PELICULA, COUNT(i.inventory_id) as CANT_ALQUILERES
from inventory i
inner join rental r 
on i.inventory_id = r.inventory_id
group by i.film_id
having COUNT(i.inventory_id) > 10
order by i.film_id;

--Ejercicio 53:
--Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.    
with PEND_TAMMY_SANDERS as (
							select c.customer_id, r.inventory_id, r.return_date
							from customer c
							inner join rental r
							on c.customer_id = r.customer_id 
							where c.first_name in ('TAMMY') and c.last_name in ('SANDERS')
							group by c.customer_id, r.inventory_id, r.return_date  
							having COUNT(r.return_date) = 0
							),
	 FILMS_PEND_DEVOLUCION as (
	 							select i.film_id, PEND_TAMMY_SANDERS.inventory_id
	 							from PEND_TAMMY_SANDERS
	 							inner join inventory i 
	 							on i.inventory_id = PEND_TAMMY_SANDERS.inventory_id
	 							)
select f.title as NOMBRE_PELICULA
from film f
inner join FILMS_PEND_DEVOLUCION 
on f.film_id = FILMS_PEND_DEVOLUCION.film_id
order by f.title asc;

--Ejercicio 54:
--Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
	--Consulto el Nro de Categoría para 'Sci-Fi':
select name, category_id as CAT_FICCION 						  
from category
where name in ('Sci-Fi');

	--Consulto los actores que protagonizaron al menos una pelicula de Ciencia-Ficción:
	with CIENCIA_FICCION as (
						 	 select fc.film_id 
						     from film_category fc 
						     where category_id = 14
							  ),
		 ELENCO_FICCION as (					
		 					select fa.film_id, fa.actor_id
							from film_actor fa
							inner join CIENCIA_FICCION 
							on fa.film_id = CIENCIA_FICCION.film_id
							)
select a.first_name, a.last_name
from actor a
inner join ELENCO_FICCION
on a.actor_id = ELENCO_FICCION.actor_id
group by a.first_name, a.last_name
order by a.last_name asc;

--Ejercicio 55:
--Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
	--Busco FILM_ID de Spartacus Cheaper:
	select film_id
	from film
	where title in ('SPARTACUS CHEAPER');
	--Obtengo: Film_ID = 824
			--Localizo peliculas que se alquilaron despues de Spartacus Cheaper:
	with POST_SPARTACUS as (select film_id as PELICULAS_POST_SPARTACUS
							from inventory
							where film_id > 824
							group by film_id
							order by film_id),
		 ELENCO_POST_SPARTACUS as (select fa.film_id, fa.actor_id
							 	   from film_actor fa
								   inner join POST_SPARTACUS 
								   on fa.film_id = peliculas_post_spartacus)
	select a.actor_id, a.first_name as NOMBRE, a.last_name as APELLIDO
	from actor a
	inner join ELENCO_POST_SPARTACUS
	on a.actor_id = ELENCO_POST_SPARTACUS.actor_id
	group by a.actor_id
	order by APELLIDO asc;

--Ejercicio 56:
--Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
	--ACTORES PARTICIPES DE PELICULAS DEL GENERO MUSIC:
with GEN_MUSIC as ( select film_id as MUSICALES
					from film_category fc 
					where category_id = 12),
	 ELENCO_MUSIC as ( select fa.actor_id, fa.film_id
	 				   from	film_actor fa
	 				   inner join GEN_MUSIC
	 				   on fa.film_id = MUSICALES)
select a.first_name, a.last_name, a.actor_id
from actor a
inner join ELENCO_MUSIC 
on a.actor_id = ELENCO_MUSIC.actor_id
group by a.actor_id
order by a.actor_id;
	--Los 144 actores resultantes actuaron en Musicales. 
	
	--A continuación obtengo los restantes 56 que no han actuado en Musicales:
with GEN_MUSIC as ( select film_id as MUSICALES
					from film_category fc 
					where category_id = 12),
	 ELENCO_MUSIC as ( select fa.actor_id, fa.film_id
	 				   from	film_actor fa
	 				   inner join GEN_MUSIC
	 				   on fa.film_id = MUSICALES)	 				   
select a.actor_id as NOMBRE, a.first_name as APELLIDO, a.last_name
from actor a 
left join ELENCO_MUSIC
on a.actor_id = ELENCO_MUSIC.actor_id
where ELENCO_MUSIC.actor_id is null;

--Ejercicio 57:
--Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select title as NOMBRE_PELICULA
from film f 
where rental_duration > 8;

--Ejercicio 58:
--Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
with CAT_ANIMATION as ( select category_id as CATEGORIA_ANIM
						from category
						where name in ('Animation')
						),
	 FILM_ANIMATION as ( select fc.film_id, fc.category_id
	 					 from film_category fc 
	 					 inner join CAT_ANIMATION 
	 					 on fc.category_id = categoria_anim 
	 					)
select f.film_id, f.title as NOMBRE_PELICULAS
from film f 
inner join FILM_ANIMATION 
on f.film_id = FILM_ANIMATION.film_id
group by f.film_id, f.title;

--Ejercicio 59:
--Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
with DURACION_FEVER as (select f.length
						from film f 
						where title in ('DANCING FEVER')
						)
select f.title as NOMBRE_PELI, f.length as DURACION
from film f
inner join DURACION_FEVER 
on f.length = DURACION_FEVER.length
order by f.title asc;

	--Solución alternativa:
select length
from film
where title in ('DANCING FEVER');

select title as NOMBRE_PELI, length as DURACION
from film
where length = 144
order by title asc;

--Ejercicio 60:
--Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
with CLIENTES_MAS_SIETE_FILMS as (	select r.customer_id as CLIENTES, COUNT(r.rental_id)
									from rental r
									group by r.customer_id
									having COUNT(rental_id) > 7)
select c.first_name as NOMBRE, c.last_name as APELLIDO, c.customer_id 
from customer c
inner join CLIENTES_MAS_SIETE_FILMS 
on c.customer_id = clientes
order by APELLIDO asc;
							
--Ejercicio 61:
--Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
with TOTAL_ALQUILADAS as (  select r.inventory_id, COUNT(r.rental_id)
							from rental r
							group by r.inventory_id, r.rental_id
						  ),
	 FILM_ALQUILADAS as (	select i.film_id, i.inventory_id
	 	 					from inventory i
	 	 					inner join TOTAL_ALQUILADAS 
	 	 					on i.inventory_id = TOTAL_ALQUILADAS.inventory_id 
	 					  ),
	 TOTAL_CATEGORIA_ALQ as (	select fc.film_id, fc.category_id
	 							from film_category fc
	 							inner join FILM_ALQUILADAS 
	 							on fc.film_id = FILM_ALQUILADAS.film_id
	 						 )
select c.name as CATEGORIA, COUNT(c.name) as TOTAL_ALQUILADAS
from category c 
inner join TOTAL_CATEGORIA_ALQ 
on c.category_id = TOTAL_CATEGORIA_ALQ.category_id
group by c.name;

--Ejercicio 62:
--Encuentra el número de películas por categoría estrenadas en 2006.
with ESTRENOS_2006 as ( select f.film_id
						from film f
						where release_year = 2006
						),
	 CATEGORIAS_2006 as (	select fc.film_id, fc.category_id
	 						from film_category fc 
	 						inner join ESTRENOS_2006 
	 						on fc.film_id = ESTRENOS_2006.film_id 
	 					  )
select c.name as CATEGORIAS, COUNT(CATEGORIAS_2006.film_id) as TOTAL_ESTRENOS_2006
from category c
inner join CATEGORIAS_2006 
on c.category_id = CATEGORIAS_2006.category_id
group by c.name;

--Ejercicio 63:
--Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select s.store_id, ss.staff_id
from store s
cross join staff ss;

--Ejercicio 64:
--Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id as ID_CLIENTE, c.first_name as NOMBRE, c.last_name as APELLIDO, COUNT(r.rental_id) as CANT_ALQUILADAS
from customer c
inner join rental r 
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by c.customer_id;
