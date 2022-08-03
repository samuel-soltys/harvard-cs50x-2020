SELECT name FROM people
WHERE people.id IN
(SELECT person_id FROM movies LEFT OUTER JOIN stars ON movies.id = stars.movie_id
WHERE id IN (SELECT movie_id FROM stars WHERE person_id IN
(SELECT id FROM people
WHERE name = "Kevin Bacon" AND birth = 1958))) AND NOT name = "Kevin Bacon";