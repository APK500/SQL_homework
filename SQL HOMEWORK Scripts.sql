-- **** ADAM KNAPP'S SQL HOMEWORK SCRIPTS from MySQL !! ****

use sakila;


-- 1a. Display the first and last names of all actors from the table `actor`. 

select first_name, last_name FROM actor;




-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 

alter table actor 
	add ACTOR_NAME varchar(50) not null;
    
update actor
set actor_name =
	UPPER(concat(actor.first_name," ", actor.last_name));
 
     -- VERIFY our new column to make sure code works....
select actor_name from actor





-- 2A: You need to find the ID number, first name, and last name of an actor, 
-- of whom you know only the first name, "Joe." What is one query would you use to obtain this information?   

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';



-- 2b: Find all actors whose last name contain the letters `GEN`:
  	

SELECT last_name FROM actor
WHERE last_name LIKE '%GEN%';



-- 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%LI%';
Order by last_name, first_name;




-- 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: 
-- Afghanistan, Bangladesh, and China:

select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');





-- 3A: Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. 
-- Hint: you will need to specify the data type. 











































-- 6a from DBost
select sum(p.amount), c.first_name, c.last_name
from payment p
join customer c
on (c.customer_id = p.customer_id)
group by c.last_name;

