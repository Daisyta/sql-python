-- Crea una base de datos llamada "amigos" y luego importe friends.sql. 
-- Esto creará dos nuevas tablas: usuarios y amistades.
-- Usando el siguiente ERD como referencia, escribe una consulta SQL 
-- ue devuelva una lista de usuarios junto con los nombres de sus amigos.

SELECT users.first_name AS Nombre_Usuario,users.last_name AS Apellido_Usuario,
user2.first_name AS Nombre_Amigo,user2.last_name AS Apellido_Amigo
FROM users 
LEFT JOIN friendships ON users.id = friendships.user_id
LEFT JOIN users AS user2 ON friendships.friend_id = user2.id;


-- Ejercicio Adicional
-- También escriba las consultas SQL necesarias para realizar 
-- las siguientes tareas:

-- 1- Devuelva a todos los usuarios que son amigos de Kermit, 
-- asegúrese de que sus nombres se muestren en los resultados.

SELECT users.first_name AS Nombre_Usuario,users.last_name AS Apellido_Usuario,
user2.first_name AS Nombre_Amigo,user2.last_name AS Apellido_Amigo
FROM users 
JOIN friendships ON users.id = friendships.user_id
JOIN users AS user2 ON friendships.friend_id = user2.id
WHERE users.first_name = "Kermit";

-- 2 Devuelve el recuento de todas las amistades.

SELECT COUNT(user_id) AS NumberOfFriends FROM friendships;

select users.first_name as nombre, users.last_name as apellido, count(user2.id) as Numero_de_Amigos from users
left join friendships on users.id = friendships.user_id
left join users as user2 on friendships.friend_id = user2.id
group by users.id;

-- 3 Descubre quién tiene más amigos y devuelve el recuento de sus amigos.

SELECT users.first_name AS Nombre_Usuario,users.last_name AS Apellido_Usuario,
COUNT(user2.id)
FROM users 
JOIN friendships ON users.id = friendships.user_id
JOIN users AS user2 ON friendships.friend_id = user2.id
GROUP BY users.id
ORDER BY COUNT(user2.id) ASC;

-- 4 Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.


select * from friendships; 
select * from users; 
INSERT INTO `friends`.`users`
(`first_name`,`last_name`,`created_at`)
VALUES ('Dai','Castillo', NOW());

INSERT INTO `friends`.`friendships`
(`user_id`, `friend_id`,`created_at`)
VALUES (6, 2, NOW());

INSERT INTO `friends`.`friendships`
(`user_id`, `friend_id`,`created_at`)
VALUES (6, 4, NOW());

INSERT INTO `friends`.`friendships`
(`user_id`, `friend_id`,`created_at`)
VALUES (6, 5, NOW());

-- 5.Devuelve a los amigos de Eli en orden alfabético.

SELECT * FROM users; 
SELECT users.first_name AS nombre, users.last_name AS apellido, user2.first_name AS Amigo_Nombre, user2.last_name AS Amigo_Apellido FROM users
JOIN friendships ON users.id = friendships.user_id
JOIN users AS user2 ON friendships.friend_id = user2.id
WHERE users.id = 2
ORDER BY user2.first_name ASC;

-- 6.Eliminar a Marky Mark de los amigos de Eli.

SELECT * FROM users; 
DELETE FROM `friendships`
WHERE user_id = 2 and friend_id = 5;

-- 7.Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos

SELECT CONCAT(users.first_name, " ", users.last_name) AS Usuario, CONCAT(user2.first_name, " ", user2.last_name) AS Amigo FROM users
JOIN friendships ON users.id = friendships.user_id
JOIN users AS user2 ON friendships.friend_id = user2.id;