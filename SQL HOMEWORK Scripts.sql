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






-- 6a from DBost
select sum(p.amount), c.first_name, c.last_name
from payment p
join customer c
on (c.customer_id = p.customer_id)
group by c.last_name;

