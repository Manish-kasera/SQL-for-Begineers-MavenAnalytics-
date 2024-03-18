select * from rental;
select * from customer;

select * from rental where inventory_id = 3021;

select r.customer_id,r.inventory_id,c.email
from rental r
inner join
customer c
on r.customer_id = c.customer_id;


select * from film;
select * from inventory;

select
 i.inventory_id, 
 i.store_id,
 f.title,
 f.description
 from film as f
   inner join inventory as i 
     on f.film_id = i.film_id
     limit 5000;
     
select * from film limit 5000;     
     
 select * from actor;
 select * from film_actor;
 
 select 
  first_name,
  last_name,
  count(fa.actor_id) number_of_films
  from actor as a
    left join film_actor as fa
      on a.actor_id = fa.actor_id
      group by first_name,last_name
      order by number_of_films desc;
 
 select * from actor limit 10000;
 
 
 select * from film;
 select * from film_actor;
  
  select f.title, count(fa.actor_id) as number_of_actor
  from film as f
  left join film_actor as fa
  on f.film_id = fa.film_id
  group by f.title
  order by number_of_actor;
  
  
  
  -- LEFT, INNER, RIGHT and FULL JOIN with best example
  
  select * from actor;
  select * from actor_award;
  
  
-- all actors who gets the awards and also not get the award
-- actor inner join actor_award   
-- 200 records

select 
 ac.actor_id,
 ac.first_name,
 ac.last_name,
 aw.awards 
 from actor as ac 
   left join actor_award as aw 
     on ac.actor_id = aw.actor_id 
order by ac.actor_id;

-- all actors who gets the awards 
-- actor left join actor_award  
-- 135 records

select
  ac.actor_id,
  ac.first_name,
  ac.last_name,
  aw.awards 
  from actor as ac 
    inner join actor_award as aw 
     on ac.actor_id = aw.actor_id
order by ac.actor_id ;

-- all awards get or not get by actor
-- actor right join actor_award  
-- 157 records
select 
  ac.actor_id,
  ac.first_name,
  ac.last_name,
  aw.awards  
  from actor as ac 
  right join actor_award as aw 
   on ac.actor_id = aw.actor_id
order by ac.actor_id ;

-- all the records from actors and  awards 
-- actor full outer join actor_award  


-- Some error in full outer join syntax 
-- select 
--   ac.actor_id,
--   ac.first_name,
--   ac.last_name,
--   aw.awards  
--   from actor as ac 
--   full outer join actor_award as aw 
--    on ac.actor_id = aw.actor_id
-- order by ac.actor_id ;


-- Bridging

select * from film; -- film_id
select * from category; -- category
select * from film_category; -- film_id , category_id

-- We want film title and category_name from film and category but there is no relationship btw them
-- so we use film_category as a bridge btw film and category

select 
  film.film_id,
  film.title , 
  category.name as category_name
from film
   inner join film_category
     on film.film_id = film_category.film_id
   inner join category
     on film_category.category_id = category.category_id;  
     
-- all actors with each title they appears

select * from actor; -- actor_id (first_name,last_name)
select * from film; -- film_id  (title)   
select * from film_actor; -- film_id,actor_id

select 
   actor.first_name, 
   actor.last_name,
   film.title
from actor 
    inner join film_actor
      on actor.actor_id = film_actor.actor_id
    inner join film
      on film_actor.film_id = film.film_id
order by actor.first_name;   


-- all actors with total number of title they appears 

select 
   actor.first_name, 
   actor.last_name,
   count(film.title) as total_title
from actor 
    inner join film_actor
      on actor.actor_id = film_actor.actor_id
    inner join film
      on film_actor.film_id = film.film_id
group by actor.first_name,actor.last_name
order by total_title desc;   


-- Multiple conditions query

-- list distinct title and their descriptions in store = 2

select * from film; -- film_id (title,description)
select * from inventory; -- film_id,store_id

select 
distinct film.title,
 film.description,
 inventory.store_id -- for checking
from film
 inner join inventory 
   on film.film_id = inventory.film_id
      and inventory.store_id = 2;

-- or with using where clause

select 
 distinct film.title,
 film.description,
 inventory.store_id -- for checking
from film
 inner join inventory 
   on film.film_id = inventory.film_id
 where inventory.store_id=2;  
  
 
 
 -- UNION (can contain's duplicate) and UNION ALL(unique values)
 
 select * from advisor;
 select * from investor;
 
 select "advisory" as type,first_name,last_name from advisor
 UNION ALL
 select "staff" as type,first_name,last_name from staff;