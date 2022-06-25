--Выберите день, когда было перевезено максимальное количество пассажиров

--Назначим схему bookings в качестве текущей
set search_path = bookings;
--Посадочные талоны boarding_no сообщают о тех, кто прошел на борт самолета как пассажир
with boarded as (
 select
  f.flight_id,
  f.flight_no,
  f.aircraft_code,
  f.departure_airport,
  f.scheduled_departure,
  f.actual_departure,
--CTE boarded получает количество выданных посадочных талонов по каждому рейсу
  count(bp.boarding_no) boarded_count
 from flights f 
 join boarding_passes bp on bp.flight_id = f.flight_id 
--отбираем только те рейсы, которые вылетели (actual_departure заполнено)
 where f.actual_departure is not null
 group by f.flight_id 
) 
 select 
 b.flight_no,
 b.departure_airport,
 b.scheduled_departure,
 b.actual_departure,
 b.boarded_count,
 sum(b.boarded_count) over (partition by (b.departure_airport, b.actual_departure::date) order by b.actual_departure) "Итого пассажиров по датам"
from boarded b 