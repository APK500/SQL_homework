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

ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(45) not null AFTER first_name;


-- NOW MOVE the MIDDLE_NAME column to be after the first_name column
alter table actor modify middle_name varchar(45) after first_name;

-- VIEW the updated table to make sure middle_name column is in proper position.
select * from actor;





-- 3B: You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`.
-- A BLOB is a binary large object that can hold a variable amount of data,
-- as stated in the SQL documentation, etc. 

alter table actor
modify middle_name BLOB;


-- verify the table to make sure changes occured.  Although in this case
-- it's not viewable.  Action ouput prompt confirms it did affect the rows.  So should be OK!


select * from actor;



-- 3c. Now delete the `middle_name` column.   *** AFTER all that work--  we are now
-- asked to DELETE IT!!!!    O WELL   :)

ALTER TABLE actor
DROP COLUMN middle_name;


-- verify to make sure column was deleted.   It is all good!!

select * from actor;





-- 4A:  List the last names of actors, as well as how many actors have that last name.

select last_name, count(last_name) as "# of actors with same last name"
from actor
Group by last_name;




-- 4B:  List last names of actors and the number of actors who have that last name, but only for names 
-- that are shared by at least two actors


-- initial query code will be the same as above:
select last_name, count(last_name) as "# of actors with same last name"
from actor
group by last_name

-- NOW we add the conditional that must be >1 or >=2
having count(last_name) >=2;




-- 4C:  Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as 
-- GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. 
-- Write a query to fix the record.


update actor
set first_name = 'Harpo'
where first_name = 'Groucho' and last_name = 'Williams';


-- Now check the table to make sure changes carried over from code:

select first_name, last_name from actor 
where first_name = 'Harpo' and last_name = 'Williams';

-- looks good!



-- 4D:  Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that 
-- GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently 
-- HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that 
-- is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME 
 -- OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)--
 
 
-- first we select the actor_id for Harpo:

select actor_id from actor
where first_name = 'Harpo' and last_name = 'Williams';

-- That yields 172.


-- now we query with "then"/else:   

UPDATE actor
 SET first_name = CASE 
 WHEN first_name = 'HARPO' 
THEN 'GROUCHO'
ELSE 'MUCHO GROUCHO'
 END
 WHERE actor_id = 172;
 
 
 -- check the table to make sure change carried over:  (to Groucho for first name)
 
 select first_name, last_name from actor
 where first_name = 'Groucho' and last_name = 'Williams';
 
 -- now check table to make sure no other actor's names were changes over to "Groucho"
 
 select first_name, last_name from actor;
 
 -- names look ok!!
 
 
 
 
 
 
 -- 5a. You cannot locate the schema of the address table. 
 -- Which query would you use to re-create it?

 SHOW CREATE TABLE sakila.address;

-- After running the above code, THE BELOW OUTPUT (4 line sample)
--  is what is shown in the create table cell:
 
-- CREATE TABLE `address` (
-- `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
-- `address` varchar(50) NOT NULL,
-- `address2` varchar(50) DEFAULT NULL,

 
 
 
 -- 6A:  Use `JOIN` to display the first and last names, as well as the address, 
 -- of each staff member. Use the tables `staff` and `address`:

-- we will assign variables "s" and "a" for staff and address:
select first_name, last_name, address
from staff s
inner join address a
on s.address_id = a.address_id;
 
-- check table to make sure code captured all staff members (2 of them, total):

select * from staff;
 
 





 -- 6B:  Use `JOIN` to display the total amount rung up by each staff member 
 --      in August of 2005. Use tables `staff` and `payment`. 
 
select sum(p.amount), s.first_name, s.last_name
from payment p 
join staff s
on (p.staff_id = s.staff_id)
where payment_date between '2005-08-01 00:00:00' and '2005-09-01 00:00:00'
group by s.first_name;

 -- verify on table the amount are sums:   OK
 
 
 
 
 -- 6c. List each film and the number of actors who are listed for that film. 
 --     Use tables `film_actor` and `film`. Use inner join.
  	
 -- check firm_actor and film tables respectivly to see common data/columns and
 -- what to join on.alter
 
 select * from film_actor;
 select * from film;
 
-- assign variables to film and film actor:  Inner join on film actor: 
select f.title, count(a.actor_id)
from film f
inner join film_actor a
on (f.film_id = a.film_id)
group by f.title;





-- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

-- assignm variables i to inventory and f for film:
select count(i.film_id)
from inventory i
join film f
on (f.film_id = i.film_id)
where f.title = 'Hunchback Impossible';





-- 6e. Using the tables payment and customer, and the JOIN command, 
--   list the total paid by each customer. List the customers alphabetically by last name:

-- assign variables p for payment and c for customer:
select sum(p.amount), c.first_name, c.last_name
from payment p
join customer c
on (c.customer_id = p.customer_id)
group by c.last_name;






-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
--    As an unintended consequence, films starting with the letters K and Q 
--    have also soared in popularity. Use subqueries to display the titles of movies 
--    starting with the letters K and Q whose language is English. 


 
 
 
 
  	
 
 
























































-- 6a from DBost
select sum(p.amount), c.first_name, c.last_name
from payment p
join customer c
on (c.customer_id = p.customer_id)
group by c.last_name;

