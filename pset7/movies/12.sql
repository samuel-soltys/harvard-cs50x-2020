SELECT title FROM movies
LEFT OUTER JOIN stars ON movies.id = stars.movie_id
WHERE person_id IN
(SELECT id FROM people WHERE name = "Johnny Depp")
AND movies.id IN (SELECT movie_id FROM stars WHERE person_id IN
(SELECT id FROM people WHERE name = "Helena Bonham Carter"));