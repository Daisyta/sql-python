USE world;
-- 1. ¿Qué consulta harías para obtener todos los países que hablan esloveno?
 -- Tu consulta debe devolver el nombre del país, el idioma y el porcentaje de idioma.
 -- Tu consulta debe organizar el resultado por porcentaje de idioma en orden descendente. (1)
 
 
 -- EXPLICACION CONSULTA:
 -- selecciono los nombres de los paises(que estan en la tabla countries)
 -- selecciono language,percentage (estan en la tabla language)
 -- desde languages (porque son muchos)
 -- uno countries On countries.id (esta id esta en la tabla language)
 
SELECT countries.name,language,percentage
FROM languages
JOIN countries ON countries.id= languages.country_id
WHERE languages.language = "Slovene"
ORDER BY percentage DESC;

SELECT name,language,percentage
FROM countries
JOIN languages ON countries.id= languages.country_id
WHERE languages.language = "Slovene"
ORDER BY percentage DESC;



-- 2. ¿Qué consulta ejecutarías para mostrar el número total de ciudades para cada país? 
-- Su consulta debe devolver el nombre del país y el número total de ciudades. 
-- Tu consulta debe organizar el resultado por el número de ciudades en orden descendente. (3)


SELECT countries.name, COUNT(*)
FROM cities
JOIN countries ON cities.country_id = countries.id
GROUP BY countries.name
ORDER BY COUNT(*) DESC;
 -- EXPLICACION CONSULTA:
 -- selecciono los nombres de los paises(que estan en la tabla countries) (por cada pais,por eso se leecciona pais)
 -- funcion contar asterisco porque contaré los paises (un pais tiene muchas ciudades)
 -- desde ciudades (porque son muchas)
 -- uno countries On cities.country_id (esta id esta en la tabla cities)
 -- esta union es igual a countries.id porque un pais puede tener muchas ciudaddes el muchas es countries.id
 -- se agrupan por el nombre del pais con group by
 -- se hace el conteo descendente con el order by count  desc
 
 -- 3. ¿Qué consulta harías para obtener todas las ciudades de México 
 -- con una población de más de 500,000? Tu consulta debe organizar el 
 -- resultado por población en orden descendente. (1)
 
 SELECT cities.name,cities.population,cities.country_id
 FROM cities
 JOIN countries  ON cities.country_id= countries.id
 WHERE countries.name= "Mexico" AND cities.population >= 500000
 ORDER BY countries.population DESC;
 
-- EXPLICACION CONSULTA:
 -- selecciono los nombres de las ciudades (cities.name),poblacion de las ciudades(cities.opulation),
 -- y cities.country_id la que me conectara con la tabla countries
 -- desde cities (porque son muchas)
 -- uno countries On cities.country_id (esta id esta en la tabla cities)
-- busco el pais mexico con where y la poblacion menor o igual a 500000
 -- se hace el conteo descendente con el order by count  desc
 
 
 -- 4. ¿Qué consulta ejecutarías para obtener todos los idiomas
 -- en cada país con un porcentaje superior al 89%?
 -- Tu consulta debe organizar el resultado por porcentaje en orden descendente. (1)
 
 SELECT countries.name,languages.language,languages.percentage
 FROM languages
 JOIN countries ON languages.country_id = countries.id
 WHERE languages.percentage > "89%"
 ORDER BY languages.percentage DESC;
 
 -- EXPLICACION CONSULTA:
 -- selecciono los nombres de los paises (countries.name),lenguajes ciudades(languages.language), 
 -- y el porcentaje (language.percentage)
 -- desde languages (porque son muchos) y tiene una id con la que se puede coedctar a otras tablas.rojo
 -- uno countries On languages.country_id = countries.id (esta id esta en la tabla countries)
-- busco el porentaje mayor a 89 con el where 
 -- se hace el conteo descendente con el order by   desc
 
 -- 5. ¿Qué consulta haría para obtener todos los países 
 -- con un área de superficie inferior a 501 
 -- y una población superior a 100,000? (2)
 
 SELECT countries.name,countries.population,countries.surface_area
 FROM countries
 WHERE countries.surface_area < 501 AND countries.population > 100000;
 
  -- EXPLICACION CONSULTA:
 -- selecciono los nombres de los paises (countries.name),
 -- poblacion paises(countries.population), 
 -- y el area (countries.surface area)
 -- desde paises (porque son muchos), filtro con el where la poblacion y el AREA
 -- Aqui no es necesario hacer join porque los parametros 
 -- que piden estan en la misma tabla
 
 
 -- 6. ¿Qué consulta harías para obtener países
 -- con solo Monarquía Constitucional con un capital superior a 200
 -- y una esperanza de vida superior a 75 años? (1)
 
 SELECT countries.name,countries.government_form,countries.capital,countries.life_expectancy
 FROM countries
 WHERE countries.government_form = "Constitutional Monarchy" AND countries.capital > 200 
 AND countries.life_expectancy > 75
 
  -- EXPLICACION CONSULTA:
 -- selecciono los nombres de los paises (countries.name),
 -- forma de gobierno(countries.govrenment_form), 
 -- capital (countries.capital)
 -- y la esperanza de vida (countries.life_expectancy)
 -- desde paises (porque son muchos), filtro con el where la forma de gobierno,capital,esperanza vida
 -- Aqui no es necesario hacer join porque los parametros 
 -- que piden estan en la misma tabla
 -

-- 7. ¿Qué consulta harías para obtener todas las ciudades de Argentina 
-- dentro del distrito de Buenos Aires y tener una población superior a 500,000? 
-- La consulta debe devolver el nombre del país, el nombre de la ciudad, 
-- el distrito y la población. (2)

SELECT countries.name AS Country,cities.name AS City,cities.district,cities.population
FROM cities
JOIN countries ON cities.country_id = countries.id
WHERE countries.name = "Argentina" AND cities.district = "Buenos Aires" AND cities.population > 500000;

  -- EXPLICACION CONSULTA:
 -- selecciono los nombres de los paises (countries.name),
 -- ciudades(cities.name), 
 -- distrito (cities.district)
 -- y poblacion (cities.population)
 -- desde ciudades (porque son muchos)
 -- uno la tabla paises con la de cities con la id coutry__id y queda cities.coutry_id = countries.id
 -- despues con where buscar Argentina,distrito Buenos Aires y poblacion mayor a 500000
 
 -- 8. ¿Qué consulta harías para resumir el número de países en cada región?
 -- La consulta debe mostrar el nombre de la región y el número de países. 
 -- Además, la consulta debe organizar el resultado por el número de países 
 -- en orden descendente. (2)
 
SELECT countries.region, COUNT(countries.name) AS Paises_en_cada_region from countries
GROUP BY countries.region
ORDER BY COUNT(*) desc;

-- EXPLICACION CONSULTA:
 -- selecciono la region de los paises (countries.region),
 -- contar los paises(countries.name) count cuenta los valores en una columna, 
 -- desde paises (porque son muchos)
 -- agrupo por region (countries.region)
 -- los ordeno descendente ORDER BY COUNT
 