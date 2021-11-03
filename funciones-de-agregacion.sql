/* Micro desafío - Paso 1: */

/* Listar los títulos y el
nombre del género de todas las series de la base de datos. */

SELECT title AS Título, name AS Género
FROM series
INNER JOIN genres ON  genres.id = series.genre_id 


/* Listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada
uno de ellos. */

SELECT title, first_name, last_name
FROM episodes
INNER JOIN actor_episode ON actor_episode.episode_id = episodes.id
INNER JOIN actors ON actors.id = actor_episode.actor_id


/* Micro desafío - Paso 2: */

/* Obtener a todos los actores o actrices (mostrar
nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las
galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada
actor/actriz. */

SELECT DISTINCT first_name, last_name
FROM actors
INNER JOIN actor_movie ON actors.id = actor_movie.actor_id
INNER JOIN movies ON movies.id = actor_movie.movie_id
WHERE movies.title LIKE "%guerra%galaxias%"


/* Micro desafío - Paso 3: */

/* Debemos listar los títulos de cada película con su género correspondiente. En el caso de
que no tenga género, mostraremos una leyenda que diga "no tiene género". */

SELECT title AS Título, COALESCE(name, "No tiene género") AS Género
FROM movies
LEFT JOIN genres ON genres.id = movies.genre_id

/* Micro desafío - Paso 4: */

/* Mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
la particularidad de que a la columna que mostrará dicha cantidad la renombraremos:
“Duración”. */

SELECT title AS Título, DATEDIFF(end_date, release_date) AS Duración
FROM series

/* Micro desafío - Paso 5: */

/* Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres. */

SELECT first_name, last_name
FROM actors
WHERE LENGTH(first_name) > 6
ORDER BY  first_name


/* Debemos mostrar la cantidad total de los episodios guardados en la base de datos. */

SELECT COUNT(*) AS "Cantidad total de episodios"
FROM episodes

/* Obtener el título de todas las series y el total
de temporadas que tiene cada una de ellas. */

SELECT series.title AS Título, COUNT(seasons.id) AS "Cantidad de temporadas"
FROM series
INNER JOIN seasons ON series.id = seasons.serie_id
GROUP BY series.title


/* Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor
o igual a 3. */

SELECT name AS Género, COUNT(movies.id) AS "Cantidad de películas"
FROM genres
INNER JOIN movies ON genres.id = movies.genre_id
GROUP BY name 
HAVING COUNT(movies.id) >= 3