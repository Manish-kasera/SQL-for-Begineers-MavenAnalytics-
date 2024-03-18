/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

select * from store; -- store_id,manager_staff_id,address_id
select * from staff; -- staff_id (first_name,last_name)
select * from address; -- address_id,city_id (address,district)
select * from city; -- city_id,country_id (city)
select * from country; -- country_id (country)

select 
  staff.first_name as manager_first_name ,
  staff.last_name as manager_last_name,
  address.address,
  address.district,
  city.city,
  country.country
from store 
  left join staff on store.manager_staff_id = staff.staff_id
  left join address on store.address_id = address.address_id
  left join city on address.city_id = city.city_id
  left join country on city.country_id = country.country_id;
  





	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

select * from inventory; -- inventory_id,film_id,store_id
select * from film; -- film_id (title,rating,rental_rate,replacement_cost)

select 
  inventory.store_id,
  inventory.inventory_id,
  film.title as film_name,
  film.rating,
  film.rental_rate,
  film.replacement_cost
from inventory
  inner join film
    on inventory.film_id = film.film_id ;
  


/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/


select 
  inventory.store_id,
  film.rating, 
  count(inventory_id) as inventory_times
from inventory
  left join film
    on inventory.film_id = film.film_id 
group by inventory.store_id,film.rating;





/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

select * from inventory; -- film_id,inventory_id,store_id
select * from film; -- film_id (replacement_cost)
select * from film_category; -- film_id,category_id (name)
select * from category; -- category_id



SELECT 
	store_id, 
    category.name AS category, 
	COUNT(inventory.inventory_id) AS films, 
    AVG(film.replacement_cost) AS avg_replacement_cost, 
    SUM(film.replacement_cost) AS total_replacement_cost
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
	LEFT JOIN film_category
		ON film.film_id = film_category.film_id
	LEFT JOIN category
		ON category.category_id = film_category.category_id
GROUP BY 
	store_id, 
    category.name
ORDER BY 
	SUM(film.replacement_cost) DESC;



/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/


select * from customer; -- customer_id,store_id,address_id (first_name,last_name)
select * from address; -- address_id,city_id (address,district)
select * from city; -- city_id,country_id (city)
select * from country; -- country_id (country)

select 
  first_name,
  last_name,
  store_id,
  active,
  address,
  city ,
  country
from customer
  left join address on customer.address_id = address.address_id  
  left join city on address.city_id = city.city_id
  left join country on city.country_id = country.country_id;
  








/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

select * from customer; -- customer_id (first_name,last_name)
select * from payment; -- payment_id,customer_id,rental_id (amount)

select 
   first_name ,
   last_name,
   customer.customer_id,
   count(rental.rental_id) as total_rental,
   sum(amount) as total_payment
from customer
   left join payment on customer.customer_id = payment.customer_id
   left join rental on rental.rental_id = payment.rental_id
group by customer.customer_id
order by total_payment desc;
   










    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

select * from advisor; -- advisor_id (first_name,last_name)
select * from investor; -- investor_id (first_name,last_name)


select "advisory" as type, first_name, last_name,NULL from advisor
union all
select "investor" as type, first_name,last_name,company_name from investor;




/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

