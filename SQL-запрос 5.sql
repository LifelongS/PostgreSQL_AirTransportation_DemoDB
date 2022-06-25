--Выдайте информацию о количестве забронированных мест

--Назначим схему bookings в качестве текущей
set search_path = bookings;

--Запрашиваем количество бронирований
SELECT r.min_sum, r.max_sum, count( b.* )
FROM bookings b RIGHT OUTER 
JOIN ( VALUES (0, 1000000) ) /*Пусть максимальная сумма в одном
--бронировании составляет 1000000 рублей*/
AS r ( min_sum, max_sum )
ON b.total_amount >= r.min_sum AND
b.total_amount < r.max_sum
GROUP BY r.min_sum, r.max_sum
ORDER BY r.min_sum;
