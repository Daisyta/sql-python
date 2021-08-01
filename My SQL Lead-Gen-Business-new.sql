-- 1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?

SELECT MONTHNAME(charged_datetime) AS month, SUM(amount) AS amount
FROM billing 
WHERE charged_datetime >= "2012/03/01" AND charged_datetime  <= "2012/03/31"
GROUP BY MONTHNAME(charged_datetime);


-- 2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?

SELECT client_id as Cliente, SUM(amount) AS Ingresos_Totales FROM billing WHERE client_id ="2";

-- 3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?

SELECT domain_name,client_id FROM sites WHERE client_id ="10";

-- SELECT client_id AS Id_Cliente, domain_name AS Sitio_Web FROM sites WHERE client_id = 10 (alternativa de respuesta)


-- 4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el cliente con una identificación de 1? 
-- ¿Qué pasa con el cliente = 20?

SELECT client_id, COUNT(domain_name) as number_of_websites, MONTHNAME(created_datetime) AS month_created, YEAR (created_datetime) AS year_created FROM sites
WHERE client_id =1
GROUP BY created_datetime;


-- 5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios entre el 1 de enero de 2011 
-- y el 15 de febrero de 2011?

SELECT sites.domain_name AS website, COUNT(leads.leads_id) AS number_of_leads, 
CONCAT(MONTHNAME(leads.registered_datetime), ' ', DAY(leads.registered_datetime), ', ', YEAR(leads.registered_datetime)) AS leads_clients FROM sites
LEFT JOIN leads ON sites.site_id = leads.site_id 
WHERE leads.registered_datetime BETWEEN '2011-1-1' AND '2011-2-15'
GROUP BY leads.leads_id;

-- 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
-- que hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?

SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-1-1' AND '2011-12-31'
GROUP BY CONCAT(clients.first_name, ' ', clients.last_name), clients.client_id
ORDER BY clients.client_id; 


-- 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
-- que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?

SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads,
DATE_FORMAT(leads.registered_datetime, '%M') as month_generated  
FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE EXTRACT(MONTH FROM leads.registered_datetime)>= 1
AND  EXTRACT(MONTH FROM leads.registered_datetime)<= 6
AND DATE_FORMAT(leads.registered_datetime, '%Y') = '2011'
GROUP BY CONCAT(clients.first_name, ' ', clients.last_name), leads.registered_datetime
ORDER BY leads.registered_datetime; 


-- 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
-- que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? 
-- Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los clientes, los nombres del sitio
--  y el número total de clientes potenciales generados en cada sitio en todo momento.

SELECT CONCAT(clients.first_name, ' ' , clients.last_name) AS client_name, 
sites.domain_name AS website,
COUNT(leads.leads_id) AS number_of_leads, 
DATE_FORMAT(MAX(leads.registered_datetime), "%M %e, %Y") AS date_generated
FROM sites
JOIN clients ON sites.client_id = clients.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-1-1' AND '2011-12-31'
GROUP BY clients.client_id, sites.domain_name
ORDER BY clients.client_id;



-- 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. 
-- Pídalo por ID de cliente.

SELECT CONCAT(clients.first_name, ' ' , clients.last_name) AS client_name, 
SUM(billing.amount) AS Total_Revenue,
DATE_FORMAT(billing.charged_datetime, '%M') AS month_charge,
DATE_FORMAT(billing.charged_datetime, '%Y') AS year_charge
FROM billing
LEFT JOIN clients ON billing.client_id = clients.client_id
GROUP BY clients.client_id, DATE_FORMAT(billing.charged_datetime, '%M'), DATE_FORMAT(billing.charged_datetime,'%Y') 
ORDER BY clients.client_id, DATE_FORMAT(billing.charged_datetime,'%Y') ASC, DATE_FORMAT(billing.charged_datetime, '%M') ASC;

-- 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados para que 
-- cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene 
-- todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)

SELECT CONCAT(clients.first_name, ' ' , clients.last_name) AS client_name, 
GROUP_CONCAT(sites.domain_name SEPARATOR' / ') AS sites
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
GROUP BY clients.client_id;

