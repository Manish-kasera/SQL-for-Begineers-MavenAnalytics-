show databases;

use mavenmovies;

show tables;

select * from rental;

SELECT customer_id,rental_date
from rental;

select * from customer;
select 
 first_name,
 last_name,
 email 
from customer;

select 
 distinct rental_duration
from film;

select * 
from payment where 
customer_id<=100; 

select * from payment;
select
 payment_id,
 customer_id,
 amount,
 payment_date
from payment
where amount =0.99
and payment_date >'2006-01-01';

select * 
from payment where 
customer_id between 1 AND customer_id<=100; 


select 
 customer_id,
 rental_id,
 amount,
 payment_date
from payment 
where 
 customer_id<=100
 and amount > 5
 and payment_date > '2006-01-01'; 
 
 
 select 
  customer_id,
  rental_id,
  amount,
  payment_date
from payment
where  amount > 5
 or customer_id = 42
 or customer_id = 53 
 or customer_id = 60 
 or customer_id = 75;
 
  select 
  customer_id,
  rental_id,
  amount,
  payment_date
from payment
where  amount > 5
 or customer_id in(42,53,60,75);
 
 
 select title,description from film
 where description like '%Epic%';
 
 select title,special_features from film
 where special_features like '%Behind the scenes%';
 
 select 
  rental_duration,
  count(rental_duration) as film_with_this_rental_duration
  from film 
  group by rental_duration;
 
 select 
  rating,
  count(rating)
  from film 
  group by rating;
 
 
 -- 5 for rental_duration 5 for rating => 25
 select 
  rental_duration,
  rating,
  count(rental_duration) as film_with_this_rental_duration
  from film 
  group by rental_duration,rating;
 
 select 
  rating,
  count(rating),
  rental_duration,
  count(rental_duration)
  from film 
  group by rating,rental_duration;
  
  
  select * from film;
  
select 
   replacement_cost,
   count(film_id) as number_of_films,
   min(rental_rate) as cheapest_rental,
   max(rental_rate) as expensive_rental,
   avg(rental_rate) as average_rental
from film
group by replacement_cost;  

select * from rental;

select customer_id,count(*) as total_rental 
from rental
group by customer_id;

select customer_id,count(*) as total_rental 
from rental
group by customer_id
having total_rental > 30; 

select 
 customer_id,
 count(*) as total_rental 
from rental 
group by customer_id 
having total_rental < 15;
-- or
-- having count(*) > 30;

select title,length,rental_rate from film
order by length desc;

select * from category ;
select * from film;

select title,length,
 CASE
  WHEN length <= 60 THEN "Under 1 Hr"
  WHEN length <= 90 THEN "Under 1-1.5 Hr"
  WHEN length > 90 THEN  "Over 1.5 Hr"
  ELSE "Please check Logic"
 END as length_bucket
from film;


select first_name ,last_name,store_id ,active, 
CASE
 WHEN store_id = 1 and active = 1 THEN "store 1 active"
 WHEN store_id = 1 and active = 0 THEN "store 1 inactive"
 WHEN store_id = 2 and active = 1 THEN "store 2 active"
 WHEN store_id = 2 and active = 0 THEN "store 2 inactive"
 ELSE "Please check logic"
END as store_and_status 
from customer;


-- "Pivoting" with Count and Case
select store_id,
    count(CASE WHEN active = 1 THEN customer_id ELSE NULL END) as active ,
    count(CASE WHEN active = 0 THEN customer_id ELSE NULL END) as inactive
from customer
group by store_id;