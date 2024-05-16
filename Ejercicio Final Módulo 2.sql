USE SAKILA
/*1-Selecciona todos los nombres de las películas sin que aparezcan duplicados*/
SELECT DISTINCT title
FROM film;

/*2- Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"*/
SELECT DISTINCT title,rating
FROM film
WHERE rating = 'PG-13';

/*3- Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en 
su descripción*/
SELECT title,description
FROM film
WHERE description LIKE '%Amazing%';

/*4- Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos*/
SELECT title,length
FROM film
WHERE length > 120;

/*5- Recupera los nombres de todos los actores*/
SELECT CONCAT(first_name,' ',last_name) AS nombre_completo_actor
FROM actor
ORDER BY nombre_completo_actor ASC;

/*6- Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido*/
SELECT CONCAT(first_name,' ',last_name) AS nombre_completo_actor
FROM actor
WHERE last_name LIKE '%Gibson%';

/*7- Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20*/
SELECT first_name,actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

/*8- Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su 
	clasificación*/
SELECT title,rating
FROM film
WHERE rating NOT IN('PG-13','R');

/*9- Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la 
	clasificación junto con el recuento*/
SELECT rating,COUNT(rating) AS recuento
FROM film
GROUP BY rating;

/*10- Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su 
	nombre y apellido junto con la cantidad de películas alquiladas*/
SELECT rental.customer_id,COUNT(rental_id) AS total_film_rental,customer.first_name,customer.last_name
FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
GROUP BY customer_id;

/* 11- Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la 
categoría junto con el recuento de alquileres*/
SELECT rental_id AS total_rental
FROM rental;


/*12- Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
muestra la clasificación junto con el promedio de duración*/
SELECT AVG(length) AS promedio_duracion,rating AS clasificacion
FROM film
GROUP BY length;

/*13- Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"*/
SELECT CONCAT(actor.first_name,actor.last_name) AS nombre_completo_actor,film.title
FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film.film_id = film_actor.film_id
WHERE film.title = 'Indian Love';

/*14- Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción*/
SELECT title
FROM film
WHERE title LIKE '%dog%' OR '%cat%'

/*15- Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor*/
SELECT CONCAT(actor.first_name,actor.last_name) AS nombre_completo_actor,film_actor.film_id,film_actor.actor_id
FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
WHERE film_actor.actor_id= 'NULL';

/*16- Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010*/
SELECT title,release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

/*17- Encuentra el título de todas las películas que son de la misma categoría que "Family"*/
SELECT film.title,film.film_id,category.name AS genero
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'family';

/*18- Muestra el nombre y apellido de los actores que aparecen en más de 10 películas*/
WITH recuento AS(
	SELECT COUNT(actor_id) AS recuento_peliculas,actor_id
    FROM film_actor
    GROUP BY actor_id)
    
SELECT CONCAT(actor.first_name,actor.last_name) AS nombre_completo_actor,recuento.*
FROM actor
INNER JOIN recuento ON recuento.actor_id = actor.actor_id
WHERE recuento.recuento_peliculas > 10
ORDER BY nombre_completo_actor;

/*19- Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la 
tabla film*/
SELECT title AS titulo,rating AS clasificacion,length AS duracion
FROM film
WHERE rating = 'R' AND length > 120;

/*20- Encuentra las categorías de películas que tienen un promedio de duración superior a 120 
minutos y muestra el nombre de la categoría junto con el promedio de duración*/
SELECT film.title AS titulo,film.length AS duracion, category.name
FROM film
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE  film.length > 120;

/*21- Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor 
junto con la cantidad de películas en las que han actuado*/
WITH recuento AS(
	SELECT COUNT(actor_id) AS recuento_peliculas,actor_id
    FROM film_actor
    GROUP BY actor_id)
    
SELECT CONCAT(actor.first_name,actor.last_name) AS nombre_completo_actor,recuento.recuento_peliculas
FROM actor
INNER JOIN recuento ON recuento.actor_id = actor.actor_id
WHERE recuento.recuento_peliculas > 5;

/*22- Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una 
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona 
las películas correspondientes*/
SELECT title,rental_duration
FROM film
WHERE rental_duration >5;

/*23- Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la 
categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en 
películas de la categoría "Horror" y luego exclúyelos de la lista de actores*/
SELECT actor_id,CONCAT(first_name,' ',last_name) AS nombre_completo_actor
FROM actor
WHERE actor_id NOT IN(
	SELECT film_actor.actor_id
	FROM film_actor
	INNER JOIN film_category ON film_category.film_id = film_actor.film_id
	WHERE category_id =11);

/* 24-  BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 
minutos en la tabla film*/
SELECT title,length,film_id
FROM film
WHERE length > 180 AND film_id IN(
	SELECT film_id
    FROM film_category
    WHERE category_id = 5)
 

	
