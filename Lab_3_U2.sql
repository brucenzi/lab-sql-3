use sakila;

-- 1. How many distinct (different) actors' last names are there?
select * from actor;
select count(distinct last_name) as "Distinct Actors Last Names" from actor;

-- 2. In how many different languages were the films originally produced? (Use the column language_id from the film table)
select * from film;
select count(distinct language_id) as "Unique Film Languages" from film;

-- 3. How many movies were released with "PG-13" rating?
select * from film;
select count(rating) as "Movies Rated PG-13" from film where rating = "PG-13";

-- 4. Get 10 the longest movies from 2006.
select * from film;
select * from film where release_year = 2006 order by length desc limit 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
	-- I am assuming "rental date" as the reference for company's operation period
select * from rental;
select datediff(max(rental_date), (min(rental_date))) as "company_operation_days" from rental;

-- 6. Show rental info with additional columns month and weekday. Get 20.
	-- I am assuming "rental_date" as the rental info required in this query
select * from rental;
select *, 
extract(month from (cast(rental_date as date))) as "rental_date_month", 
weekday(cast(rental_date as date)) as "rental_weekday" 
from rental limit 20;
	
    -- here I am testing the funtion "case" to insert the name of the weekdays.
select *, 
extract(month from (cast(rental_date as date))) as "rental_date_month", 
weekday(cast(rental_date as date)) as "rental_weekday", 
case 
when weekday(cast(rental_date as date)) = 0 then "Monday"
when weekday(cast(rental_date as date)) = 1 then "Tuesday"
when weekday(cast(rental_date as date)) = 2 then "Wednesday"
when weekday(cast(rental_date as date)) = 3 then "Thursday"
when weekday(cast(rental_date as date)) = 4 then "Friday"
when weekday(cast(rental_date as date)) = 5 then "Saturday"
else "Sunday"
end as "rental_weekday_name"
from rental limit 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
	-- didn't see this question coming, so the test I did above made this query way easier
select *, 
weekday(cast(rental_date as date)) as "rental_weekday", 
case 
when weekday(cast(rental_date as date)) = 5 then "weekend"
when weekday(cast(rental_date as date)) = 6 then "weekend"
else "workday"
end as "day_type"
from rental;

-- 8. How many rentals were in the last month of activity?
	-- I am assuming rental_date as reference for the last month of activity
select * from rental;
select extract(year_month from (cast(rental_date as date))) as "last_month", 
count(rental_id) as "number_of_rentals" from rental 
where extract(year_month from (cast(rental_date as date))) = 
(select (max(extract(year_month from (cast(rental_date as date))))) from rental) 
group by rental_date;