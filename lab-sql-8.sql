# 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT TITLE, LENGTH, RANK() OVER (ORDER BY LENGTH DESC) AS "RANK"
FROM FILM 
WHERE LENGTH > 0;

SELECT TITLE, LENGTH, DENSE_RANK() OVER (ORDER BY LENGTH DESC) AS "RANK"
FROM FILM 
WHERE LENGTH > 0;

# 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
SELECT RATING, TITLE, LENGTH, RANK() OVER (PARTITION BY RATING ORDER BY LENGTH DESC) AS "RANK"
FROM FILM 
WHERE LENGTH > 0;

SELECT RATING, TITLE, LENGTH, DENSE_RANK() OVER (PARTITION BY RATING ORDER BY LENGTH DESC) AS "RANK"
FROM FILM 
WHERE LENGTH > 0;

# 3.How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT C.category_id, COUNT(F.film_id) AS Num_films
FROM category C
INNER JOIN film_category F 
ON C.category_id = F.category_id
GROUP BY category_id
ORDER BY Num_films DESC;

# 4. Which actor has appeared in the most films?
SELECT DISTINCT A.last_name, COUNT(F.film_id) AS Num_films
FROM actor A
INNER JOIN film_actor F
ON A.actor_id = F.actor_id
GROUP BY last_name
ORDER BY Num_films DESC
LIMIT 1;

# 5. Most active customer (the customer that has rented the most number of films)
SELECT C.customer_id, C.first_name, C.last_name, COUNT(R.rental_id) AS Num_rentals
FROM customer C
INNER JOIN rental R
ON C.customer_id = R.customer_id
GROUP BY customer_id, first_name, last_name
ORDER BY Num_rentals DESC
LIMIT 1;

# Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
SELECT F.title, COUNT(R.rental_id) AS num_rentals, I.inventory_id
FROM film F
INNER JOIN inventory I
ON F.film_id = I.film_id
INNER JOIN rental R 
ON I.inventory_id = R.inventory_id
GROUP BY title
ORDER BY num_rentals DESC
LIMIT 10;