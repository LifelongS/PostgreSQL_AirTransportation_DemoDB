--Узнаем, сколько рейсов выполняется за неделю
set search_path = bookings;

SELECT array_length( days_of_week, 1 )
--в столбце days_of_week  
--содержатся массивы номеров дней недели, 
--когда выполняется данный рейс
AS days_per_week,
count( * ) AS num_routes
FROM routes
GROUP BY days_per_week
ORDER BY 1 desc;