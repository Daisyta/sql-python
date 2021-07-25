USE sakila;

-- 1. ¿Qué consulta ejecutarías para obtener todos los clientes 
-- dentro de city_id = 312? Su consulta debe devolver el nombre, 
-- apellido, correo electrónico y dirección del cliente.

SELECT customer.first_name,customer.last_name,customer.email,customer.address_id
FROM customer
JOIN address ON customer.address_id= address.address_id
JOIN city ON address.city_id= city.city_id
WHERE city.city_id = 312;

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla customer: first_name,last_name,address_id
-- (adress_id es llave foranea de la tabla address). 
-- tenemos que unir JOIN la tabla customer con address: usando customer.address_id 
-- y se unira a address como address.address_id)JOIN
-- como los clientes estan en ciudades,cada ciudad tiene su id, y me piden ver la 312
-- por lo que la tabla que contiene una id con city es la tabla city ,y se hara un JOIN con city
-- 

-- 2. ¿Qué consulta harías para obtener todas las películas de comedia? 
-- Su consulta debe devolver el título de la película, la descripción,
-- el año de estreno, la calificación, las características especiales 
-- y el género (categoría).

SELECT film.title,film.description,film.release_year,film.rating,film.special_features,category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Comedy";

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla film: title,description,release year,rating,special features
-- seleccionar de la tabla category: name
-- (desde film 
-- tenemos que unir JOIN la tabla film con category: usando film_id 
-- necesito saber a que actegoria estan asociados los film_id,por lo que para acceder a las categorias,debo unir info con la tabla category
-- la que contiene una id que es category_id, y se hara JOIN con la tabla film_category
-- asi se puede acceder a la categoria de las peliculas y se filtra por "comedy" con el WHERE

-- 3. ¿Qué consulta harías para obtener todas las películas 
-- unidas por actor_id = 5? Su consulta debe devolver la 
-- identificación del actor, el nombre del actor, el título de la película,
--  la descripción y el año de lanzamiento.

SELECT actor.first_name,actor.last_name,film.title,film.description,film.release_year
FROM film
JOIN film_actor ON film.film_id= film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.actor_id = 5;

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla actor: first_name,last_name,
-- seleccionar de la tabla film: title,description,release_year
-- (desde film 
-- tenemos que unir JOIN la tabla film con film_actor: usando film_id 
-- necesito saber a que films estan asociados los film_id,por lo que para acceder a las films de cada actor
-- ,debo unir info con la tabla actor
-- la que contiene una id que es actor_id, y se hara JOIN con la tabla actor
-- asi se puede acceder a los films por actor con el id actor.actor_id 

-- 4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1
-- y dentro de estas ciudades (1, 42, 312 y 459)? 
-- Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente.

SELECT store.store_id,city.city_id,customer.first_name,customer.last_name,customer.email,
customer.address_id
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
JOIN store ON customer.store_id = store.store_id
WHERE store.store_id = 1 AND (city.city_id = 1 OR city.city_id =42 OR city.city_id = 312 
OR city.city_id = 459);

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla customer: first_name,last_name,
-- seleccionar de la tabla store: store_id
-- seleccionar de la tabla city: city_id
-- (desde customer
-- tenemos que unir JOIN la tabla customer con address: usando address_id 
-- necesito saber a que ciudades estan asociados los address_id,por lo que para acceder a las ciudades,necesito a tabla address
-- ,debo unir JOIN la tabla city con la tabla address,para obtener el city_id
-- otro JOIN a la tabla store desde customer a store,ya que tienen en comun store_id
-- asi se puede acceder al store.store_id y al city.city_id

-- 5. ¿Qué consulta realizarías para obtener todas las películas 
-- con una "calificación = G" y "característica especial = detrás de escena",
--  unidas por actor_id = 15? Su consulta debe devolver el título de la película,
--  la descripción, el año de lanzamiento, la calificación y la función especial.
--  Sugerencia: puede usar la función LIKE para obtener la parte 'detrás de escena'.


SELECT film.title,film.description,film.release_year,film.rating,film.special_features
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.rating = "G" AND film.special_features LIKE "%Behind the Scenes" AND actor.actor_id = 15;

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla film: title,,description,release_yer,rating,special_features
-- (desde film
-- tenemos que unir JOIN la tabla film con film_actor: usando film_id 
-- necesito saber a que actor estan asociados los film_id,por lo que para acceder a los actores,necesito la tabla actor
-- ,debo unir JOIN la tabla actor con la tabla film_actor,para obtener el actor_id
-- a través del WHERE la condicion de rating G, Behind the scenes y actor_id = 15

-- 6. ¿Qué consulta harías para obtener todos los actores que
--  se unieron en el film_id = 369? Su consulta debe devolver 
-- film_id, title, actor_id y actor_name.

SELECT film.title,film.film_id,actor.actor_id,actor.first_name,actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film_actor.film_id = 369; 

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla film: title,film_id
-- seleccionar de la tabla actor: actor_id,first_name,last_name
-- (desde film
-- tenemos que unir JOIN la tabla film con film_actor: usando film_id 
-- necesito saber a que actor.id estan asociados los film_id,por lo que para acceder a los actores,necesito la tabla actor
-- ,debo unir JOIN la tabla actor con la tabla film_actor,para obtener el actor_id
-- a través del WHERE la condicion de film_actor.film_id= 369

-- 7. ¿Qué consulta harías para obtener todas las películas dramáticas 
-- con una tarifa de alquiler de 2.99? 
-- Su consulta debe devolver el título de la película, 
-- la descripción, el año de estreno, la calificación, 
-- las características especiales y el género (categoría).

SELECT film.title,film.description,film.release_year,film.rating,film.special_features,film.rental_rate,category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Drama" AND film.rental_rate= 2.99;

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla film: title,description,release year,rating,special features,rental_rate
-- seleccionar de la tabla category: name
-- (desde film 
-- tenemos que unir JOIN la tabla film con category: usando film_id 
-- necesito saber a que actegoria estan asociados los film_id,por lo que para acceder a las categorias,debo unir info con la tabla category
-- la que contiene una id que es category_id, y se hara JOIN con la tabla film_category
-- asi se puede acceder a la categoria de las peliculas y se filtra por "comedy" con el WHERE

-- 8. ¿Qué consulta harías para obtener todas las películas de acción
--  a las que se une SANDRA KILMER? Su consulta debe devolver el título de la película,
--  la descripción, el año de estreno, la calificación, las características especiales,
--  el género (categoría) y el nombre y apellido del actor.

SELECT film.title,film.description,film.release_year,film.rating,film.special_features,category.name,actor.first_name,actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.first_name = "SANDRA" AND actor.last_name = "KILMER" AND category.name = "Action"; 

-- EXPLICACION DE LA CONSULTA:
-- seleccionar de la tabla film: title,description,release year,rating,special features
-- seleccionar de la tabla category: name
-- seleccionar de la tabla actor: first_name ,last_name
-- (desde film 
-- tenemos que unir JOIN la tabla film con category: usando film_id 
-- necesito saber a que actegoria estan asociados los film_id,por lo que para acceder a las categorias,debo unir info con la tabla category
-- la que contiene una id que es category_id, y se hara JOIN con la tabla film_category
-- para llegar al nombre del actor,hay que unir la tabla actor con film_actor a traves de la actor.id
-- asi se puede acceder a la categoria de las peliculas y se filtra por "SANDRA" con el WHERE


