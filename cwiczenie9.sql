CREATE DATABASE Tabela_geochronologiczna;
CREATE SCHEMA tab;
 
--tworzenie tabeli
CREATE TABLE tab.GeoEon(
	id_eon INT PRIMARY KEY,
	nazwa_eon VARCHAR(30));
	
CREATE TABLE tab.GeoEra( 
	id_era INT PRIMARY KEY, 
	nazwa_era VARCHAR(30),
	id_eon INT);

CREATE TABLE tab.GeoOkres(
	id_okres INT PRIMARY KEY,
	nazwa_okres VARCHAR(30),
	id_era INT);

CREATE TABLE tab.GeoEpoka(
	id_epoka INT PRIMARY KEY, 
	nazwa_epoka VARCHAR(30),
	id_okres INT);

CREATE TABLE tab.GeoPietro(
	id_pietro INT PRIMARY KEY,
	nazwa_pietro VARCHAR(30),
	id_epoka INT);

--dodawanie kluczy obcych
ALTER TABLE tab.GeoEra 
ADD FOREIGN KEY (id_eon) 
REFERENCES GeoEon (id_eon);

ALTER TABLE tab.GeoOkres 
ADD FOREIGN KEY (id_era) 
REFERENCES GeoEra (id_era);

ALTER TABLE tab.GeoEpoka 
ADD FOREIGN KEY (id_okres) 
REFERENCES GeoOkres (id_okres);

ALTER TABLE tab.GeoPietro 
ADD FOREIGN KEY (id_epoka) 
REFERENCES GeoEpoka (id_epoka);

--wypelnianie tabel
INSERT INTO tab.GeoEon VALUES
(1,'fanerozoik');

INSERT INTO tab.GeoEra VALUES
(1,'paleozoik',1),
(2,'mezozoik',1),
(3,'kenozoik',1);

INSERT INTO tab.GeoOkres VALUES
(1, 'dewon',1),
(2, 'karbon',1),
(3, 'perm',1),
(4, 'trias',2),
(5, 'jura',2),
(6, 'kreda',2),
(7, 'palogen',3),
(8, 'neogen',3),
(9, 'czwartorzed',3);

SELECT*FROM tab.GeoOkres

INSERT INTO tab.GeoEpoka VALUES
(1, 'dolny', 1),
(2, 'srodkowy', 1),
(3, 'gorny', 1),
(4, 'dolny', 2),
(5, 'gorny', 2),
(6, 'dolny', 3),
(7, 'gorny', 3),
(8, 'dolny', 4),
(9, 'srodkowy', 4),
(10, 'gorny', 4),
(11, 'dolna', 5),
(12, 'srodkowa', 5),
(13, 'gorna', 5),
(14, 'dolna', 6),
(15, 'gorna', 6),
(16, 'paleocen', 7),
(17, 'eocen', 7),
(18, 'oligocen', 7),
(19, 'miocen', 8),
(20, 'pliocen', 8),
(21, 'plejstocen', 9),
(22, 'holocen', 9);


INSERT INTO tab.GeoPietro VALUES 
(1,'megalaj',22),
(2,'nortgryp',22),
(3,'grenland',22),
(4,'tarant',21),
(5,'chiban',21),
(6,'kalabr',21),
(7,'gelas',21),
(8,'piacent',20),
(9,'zankl',20),
(10,'messyn',19),
(11,'torton',19),
(12,'serrawal',19),
(13,'lang',19),
(14,'burdyga',19),
(15,'akwitan',19),
(16,'szat',18),
(17,'rupel',18),
(18,'priabon',17),
(19,'barton',17),
(20,'lutet',17),
(21,'iprez',17),
(22,'tanet',16),
(23,'zeland',16),
(24,'dan',16),
(25,'mastrycht',15),
(26,'kampan',15),
(27,'santon',15),
(28,'koniak',15),
(29,'turon',15),
(30,'cenoman',15),
(31,'alb',14),
(32,'apt',14),
(33,'barrem',14),
(34,'hoteryw',14),
(35,'walanzyn',14),
(36,'berrias',14),
(37,'tyton',13),
(38,'kimeryd',13),
(39,'oksford',13),
(40,'kelowej',12),
(41,'baton',12),
(42,'bajos',12),
(43,'aalen',12),
(44,'toark',11),
(45,'pliensbach',11),
(46,'synemur',11),
(47,'hettang',11),
(48,'retyk',10),
(49,'noryk',10),
(50,'karnik',10),
(51,'ladyn',9),
(52,'anizyk',9),
(53,'olenek',8),
(54,'ind',8),
(55,'czangsing',7),
(56,'wucziaping',7),
(57,'kapitan',7),
(58,'word',7),
(59,'road',7),
(60,'kungur',6),
(61,'artinsk',6),
(62,'sakmar',6),
(63,'assel',6),
(64,'gzel',5),
(65,'kasimow',5),
(66,'moskow',5),
(67,'baszkir',5),
(68,'serpuchow',4),
(69,'wizen',4),
(70,'turnej',4),
(71,'famen',3),
(72,'fran',3),
(73,'zywet',2),
(74,'eifel',2),
(75,'ems',1),
(76,'prag',1),
(77,'lochkow',1);

SELECT*FROM tab.GeoPietro
 
--finalna tabela geochronologiczna
CREATE TABLE tab.TabelaGeo AS (SELECT * FROM tab.GeoPietro NATURAL JOIN tab.GeoEpoka 
NATURAL JOIN tab.GeoOkres NATURAL JOIN tab.GeoEra NATURAL JOIN tab.GeoEon);

SELECT*FROM tab.TabelaGeo

--stworzenie tabeli dzesiec i milion 
CREATE TABLE tab.dziesiec(
	cyfra int,
	bit int);
CREATE TABLE tab.milion(
	liczba int,
	cyfra int, 
	bit int);


--wypelnianie tabel

INSERT INTO tab.dziesiec VALUES 
(0,1),
(1,1), 
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1);

SELECT*FROM tab.dziesiec

INSERT INTO tab.milion 
SELECT poz1.cyfra + 10*poz2.cyfra + 100*poz3.cyfra + 1000*poz4.cyfra
+ 10000*poz5.cyfra + 10000*poz6.cyfra AS liczba, 
poz1.cyfra AS cyfra, 
poz1.bit AS bit
FROM tab.dziesiec poz1, tab.dziesiec poz2, tab.dziesiec poz3, tab.dziesiec poz4, tab.dziesiec poz5, tab.dziesiec poz6;

SELECT*FROM tab.milion
ORDER BY tab.milion.liczba;

--zapytanie 1
SELECT COUNT(*) FROM tab.milion INNER JOIN tab.TabelaGeo ON 
(mod(tab.milion.liczba, 77)=(tab.TabelaGeo.id_pietro));

--zapytanie 2
SELECT COUNT(*) FROM tab.milion INNER JOIN tab.GeoPietro ON 
(mod(tab.milion.liczba, 77) = tab.GeoPietro.id_pietro) NATURAL JOIN tab.GeoEpoka NATURAL JOIN 
tab.GeoOkres NATURAL JOIN tab.GeoEra NATURAL JOIN tab.GeoEon;

--zapytanie 3
SELECT COUNT(*) FROM tab.milion WHERE mod(tab.milion.liczba, 77) = 
(SELECT id_pietro FROM tab.TabelaGeo WHERE mod(tab.milion.liczba, 77) = (id_pietro));

--zapytanie 4
SELECT COUNT(*) FROM tab.milion WHERE mod(tab.milion.liczba, 77) IN
(SELECT tab.GeoPietro.id_pietro FROM tab.GeoPietro NATURAL JOIN tab.GeoEpoka NATURAL JOIN tab.GeoOkres NATURAL JOIN tab.GeoEra NATURAL JOIN tab.GeoEon);

CREATE INDEX indexEon ON tab.GeoEon(id_eon);
CREATE INDEX indexEra ON tab.GeoEra(id_era, id_eon);
CREATE INDEX indexOkres ON tab.GeoOkres(id_okres, id_era);
CREATE INDEX indexEpoka ON tab.GeoEpoka(id_epoka, id_okres);
CREATE INDEX indexPietro ON tab.GeoPietro(id_pietro, id_epoka);
CREATE INDEX indexLiczba ON tab.Milion(liczba);
CREATE INDEX indexGeoTabela ON tab.TabelaGeo(id_pietro, id_epoka, id_era, id_okres,id_eon);