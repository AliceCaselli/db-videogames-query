-- SELECT 

-- 1
SELECT *
FROM software_houses
WHERE country = 'united states';

--2
SELECT *
FROM players
WHERE city = 'rogahnland';

--3
SELECT *
FROM players
WHERE name LIKE '%a';

--4
SELECT *
FROM reviews
WHERE player_id = 800;

--5
SELECT *
FROM tournaments
WHERE year = 2015;

--6
SELECT *
FROM awards
WHERE description LIKE '%facere%';

--7
SELECT DISTINCT videogame_id
FROM category_videogame
WHERE category_id = 2
OR category_id = 6;


--8
SELECT *
FROM reviews
WHERE rating >= 2
AND rating <= 4;

--9
SELECT *
FROM videogames
WHERE release_date LIKE '2020%';

--10
SELECT DISTINCT videogame_id
FROM reviews
WHERE rating = 5;

--BONUS--

--11
SELECT COUNT(videogame_id), AVG(rating)
FROM reviews
WHERE videogame_id = 412;

--12
SELECT COUNT(software_house_id)
FROM videogames
WHERE release_date LIKE '2018%'
AND software_house_id = 1;



--GROUP BY

--1
SELECT COUNT(id)
FROM software_houses
GROUP BY country;

--2
SELECT COUNT(videogame_id)
FROM reviews
GROUP BY videogame_id;

--3
SELECT COUNT(videogame_id)
FROM pegi_label_videogame
GROUP BY pegi_label_id;

--4
SELECT COUNT(id)
FROM videogames
GROUP BY YEAR(release_date);

--5
SELECT COUNT(videogame_id)
FROM device_videogame
GROUP BY device_id;

--6
SELECT videogame_id, AVG(rating) AS media
FROM reviews
GROUP BY videogame_id
ORDER BY media;



--JOIN

--1
SELECT DISTINCT players.*
FROM players
INNER JOIN reviews
ON players.id = reviews.player_id;

--2
SELECT DISTINCT videogame_id
FROM tournament_videogame
INNER JOIN tournaments
ON tournaments.id = tournament_videogame.tournament_id
WHERE year = 2016;

--3
SELECT videogames.*
FROM category_videogame
INNER JOIN videogames
ON videogames.id = category_videogame.videogame_id;

--4
SELECT DISTINCT software_houses.*
FROM software_houses
INNER JOIN videogames 
ON software_houses.id = videogames.software_house_id
WHERE videogames.release_date >= '2020';


--5
SELECT awards.id AS premio, awards.name AS nome, software_houses.name
FROM awards

INNER JOIN award_videogame 
ON award_videogame.award_id = awards.id

INNER JOIN videogames
ON award_videogame.videogame_id = videogames.id

INNER JOIN software_houses
ON videogames.software_house_id = software_houses.id;


--6
SELECT DISTINCT vg.id, vg.name as videoname, categories.name AS catename, pegi_labels.name
FROM videogames vg
INNER JOIN reviews revs ON revs.videogame_id = vg.id
INNER JOIN category_videogame ON category_videogame.videogame_id = vg.id
INNER JOIN categories ON category_videogame.category_id = categories.id
INNER JOIN pegi_label_videogame ON pegi_label_videogame.videogame_id = vg.id
INNER JOIN pegi_labels ON pegi_label_videogame.pegi_label_id = pegi_labels.id
WHERE revs.rating >= 4;

--7
SELECT DISTINCT videogames.*
FROM videogames

INNER JOIN tournament_videogame 
ON tournament_videogame.videogame_id = videogames.id

INNER JOIN tournaments
ON tournament_videogame.tournament_id = tournaments.id

INNER JOIN player_tournament
ON player_tournament.tournament_id = tournaments.id

INNER JOIN players
ON player_tournament.player_id = players.id

WHERE players.name LIKE 's%';


--8
SELECT tournaments.city
FROM tournaments

INNER JOIN tournament_videogame ON tournament_videogame.tournament_id = tournaments.id

INNER JOIN videogames ON tournament_videogame.videogame_id = videogames.id

INNER JOIN award_videogame ON award_videogame.videogame_id = videogames.id

INNER JOIN awards ON award_videogame.award_id = awards.id

WHERE awards.name = "gioco dell'anno"
AND award_videogame.year = 2018;


--9
SELECT CONCAT(players.name, ' ', players.lastname, ' (', players.nickname, ')') AS giocatore, videogames.name AS gioco, tournaments.name AS torneo
FROM players

INNER JOIN player_tournament ON player_tournament.player_id = players.id
INNER JOIN tournaments ON player_tournament.tournament_id = tournaments.id

INNER JOIN tournament_videogame ON tournament_videogame.tournament_id = tournaments.id
INNER JOIN videogames ON tournament_videogame.videogame_id = videogames.id

INNER JOIN award_videogame ON award_videogame.videogame_id = videogames.id
INNER JOIN awards ON award_videogame.award_id = awards.id

WHERE award_videogame.year = 2018
AND awards.name = 'gioco più atteso'
AND tournaments.year = 2019;


