-- 1. Utwórz now¹ bazê danych nazywaj¹c j¹ firma.
CREATE DATABASE firma2; 

-- 2. Dodaj schemat o nazwie ksiegowosc.
CREATE SCHEMA ksiegowosc; 

-- 4. Dodaj cztery tabele: 
--pracownicy(id_pracownika, imie, nazwisko, adres, telefon) 
CREATE TABLE ksiegowosc.pracownicy
	(
		id_pracownika INT PRIMARY KEY,
		imie NVARCHAR(30) NOT NULL,
		nazwisko NVARCHAR(50) NOT NULL,
		adres NVARCHAR(120) NOT NULL,
		telefon VARCHAR(12) NULL
	);

-- komentarz
EXEC sys.sp_addextendedproperty 
@name=N'Komentarz', 
@value=N'Tabela pracowników - informacje',
@level0type=N'SCHEMA',
@level0name='ksiegowosc',
@level1type=N'TABLE',
@level1name='pracownicy'
GO

--wyswietlanie
SELECT value AS Komentarz
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pracownicy')
  AND minor_id = 0
  AND class = 1;

SELECT * FROM ksiegowosc.pracownicy

--godziny(id_godziny, data, liczba_godzin , id_pracownika)

CREATE TABLE ksiegowosc.godziny
	(
		id_godziny INT PRIMARY KEY,
		data DATE NOT NULL,
		liczba_godzin INT NOT NULL,
		id_pracownika INT NOT NULL
	);

-- komentarz

EXEC sys.sp_addextendedproperty 
@name=N'Komentarz', 
@value=N'Tabela godzin - liczba godzin przepracowanych w ciagu dnia',
@level0type=N'SCHEMA', 
@level0name='ksiegowosc',
@level1type=N'TABLE', 
@level1name='godziny'
GO

-- wyswietlanie komentarza

SELECT value AS Komentarz
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.godziny')
  AND minor_id = 0
  AND class = 1;

-- klucze
ALTER TABLE ksiegowosc.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

--pensja(id_pensji, stanowisko, kwota) 

CREATE TABLE ksiegowosc.pensja 
	(
	id_pensji INT PRIMARY KEY,
	stanowisko NVARCHAR(50) NOT NULL,
	kwota MONEY NOT NULL
	);

--komentarz

EXEC sys.sp_addextendedproperty 
@name=N'Komentarz', 
@value=N'Tabela pensji - wysokosc wynagrodzenia dla pracownika',
@level0type=N'SCHEMA', 
@level0name='ksiegowosc',
@level1type=N'TABLE', 
@level1name='pensja'
GO
-- wyswietlanie komentarza

SELECT value AS Komentarz
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pensja')
  AND minor_id = 0
  AND class = 1;

--premia(id_premii, rodzaj, kwota)  

CREATE TABLE ksiegowosc.premia
	(
		id_premii INT PRIMARY KEY,
		rodzaj NVARCHAR(80) NULL,
		kwota MONEY NULL
	);

-- komentarz
EXEC sys.sp_addextendedproperty 
@name=N'Komentarz', 
@value=N'Tabela premii - wysokosc premii dla pracownika',
@level0type=N'SCHEMA', 
@level0name='ksiegowosc',
@level1type=N'TABLE', 
@level1name='premia'
GO

-- wyswietlanie komentarza

SELECT value AS Komentarz
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.premia')
  AND minor_id = 0
  AND class = 1;

--wynagrodzenie(id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) 

CREATE TABLE ksiegowosc.wynagrodzenie
	(
		id_wynagrodzenia INT PRIMARY KEY,
		data DATE NOT NULL,
		id_pracownika INT NOT NULL,
		id_godziny INT NOT NULL,
		id_pensji INT NOT NULL,
		id_premii INT NOT NULL
	);

--komentarz
EXEC sys.sp_addextendedproperty 
@name=N'Komentarz', 
@value=N'Tabela wynagrodzen - wysokosc wynagrodzenia dla pracownika',
@level0type=N'SCHEMA', 
@level0name='ksiegowosc',
@level1type=N'TABLE', 
@level1name='wynagrodzenie'
GO

--wyswietlenie komentarza
SELECT value AS Komentarz
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.wynagrodzenie')
  AND minor_id = 0
  AND class = 1;

--klucze
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
	
ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

--5. Wype³nij ka¿d¹ tabelê 10 rekordami
-- pracownicy
INSERT INTO ksiegowosc.pracownicy VALUES
(
	'109',
	'Artur',
	'Kowalski',
	'S³oneczna 17/23, 12-345 Kraków',
	'+48234567890'
),
(
	'324',
	'Katarzyna',
	'Nowak',
	'Kwiatowa 12/34, 13-456 Kraków',
	'+48123456789'
),
(
	'181',
	'Jacek',
	'Makowski',
	'Polna 25/1, 56-432 Kraków',
	'+48456123789'
),
(
	'143',
	'Maria',
	'Bielska',
	'Szkolna 15/2, 24-053 Kraków',
	'+48900837229'
),
(
	'454',
	'Anna',
	'Milska',
	'Krakowska, 34-072 Wieliczka',
	'+48789987654'
),
(
	'238',
	'Piotr',
	'Czy¿ewski',
	'Opatowska, 32-321 Kraków',
	'+48459000392'
),
(
	'307',
	'Wojciech',
	'Witowski',
	'Leœna, 30-082 Kraków',
	'+48345229883'
),
(
	'123',
	'Adam',
	'Misiak',
	'Jana Kochanowskiego 2/13, 31-042 Kraków',
	'+48200292843'
),
(
	'329',
	'Danuta',
	'Sobota',
	'Piêkna, 32-073 Skawina',
	'+48432999028'
),
(
	'410',
	'Amelia',
	'Gwiazda',
	'Kosmiczna, 31-083 Kraków',
	NULL
)

SELECT * FROM ksiegowosc.pracownicy

--godziny
INSERT INTO ksiegowosc.godziny VALUES
(
	1,
	'2023-04-20',
	8,
	'109'
),
(
	2,
	'2023-04-20',
	8,
	'123'
),
(
	3,
	'2023-04-20',
	8,
	'143'
),
(
	4,
	'2023-04-20',
	8,
	'181'
),
(
	5,
	'2023-04-20',
	6,
	'238'
),
(
	6,
	'2023-04-20',
	8,
	'307'
),
(
	7,
	'2023-04-20',
	8,
	'324'
),
(
	8,
	'2023-04-20',
	10,
	'329'
),
(
	9,
	'2023-04-20',
	8,
	'410'
),
(
	10,
	'2023-04-20',
	6,
	'454'
)

SELECT * FROM ksiegowosc.godziny 

INSERT INTO ksiegowosc.pensja VALUES
	('109', 'Ksiêgowy/a', '6800'),
	('123', 'Ksiêgowy/a', '9000'),
	('143', 'Ksiêgowy/a', '5600'),
	('181', 'Ksiêgowy/a', '9600'),
	('238', 'Analityk', '12000'),
	('307', 'Analityk', '6000'),
	('324', 'Analityk', '7800'),
	('329', 'Analityk', '8500'),
	('410', 'Ksiêgowy/a', '7900'),
	('454', 'Ksiêgowy/a', '10000')

SELECT * FROM ksiegowosc.pensja

-- premie

INSERT INTO ksiegowosc.premia VALUES
(
	'11',
	NULL, 
	800
),
(
	'12',
	NULL,
	1200
),
(
	'13',
	NULL,
	950
),
(
	'14',
	NULL,
	550
),
(
	'15',
	NULL,
	1300
),
(
	'16',
	NULL,
	670
),
(
	'17',
	NULL,
	1200
),
(
	'18',
	NULL, 
	850
),
(
	'19',
	NULL,
	600
),
(
	'20',
	NULL,
	1500
)

SELECT * FROM ksiegowosc.premia

-- wynagrodzenia
INSERT INTO ksiegowosc.wynagrodzenie VALUES
	(111, '2023-04-20', 109, 1, 109, 11);
	(222, '2023-04-20', 123, 2, 123, 12);
	(333, '2023-04-20', 143, 3, 143, 13);
	(444, '2023-04-20', 181, 4, 181, 14);
	(555, '2023-04-20', 238, 5, 238, 15);
	(666, '2023-04-20', 307, 6, 307, 16);
	(777, '2023-04-20', 324, 7, 324, 17);
	(888, '2023-04-20', 329, 8, 329, 18);
	(999, '2023-04-20', 410, 9, 410, 19);
	(123, '2023-04-20', 454, 10, 454, 20);

SELECT * FROM ksiegowosc.wynagrodzenie

-- 6. Wykonaj nastêpuj¹ce zapytania: 
--a) Wyœwietl tylko id pracownika oraz jego nazwisko.

SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000.
SELECT ksiegowosc.wynagrodzenie.id_pracownika, ksiegowosc.pensja.kwota
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota>1000
ORDER BY ksiegowosc.wynagrodzenie.id_pracownika;

--c) Wyœwietl id pracowników nieposiadaj¹cych premii,których p³aca jest wiêksza ni¿ 2000.
SELECT ksiegowosc.wynagrodzenie.id_pracownika,ksiegowosc.pensja.kwota, ksiegowosc.premia.rodzaj
FROM ksiegowosc.premia INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pensja.id_pensji=ksiegowosc.wynagrodzenie.id_pensji) ON ksiegowosc.premia.id_premii=ksiegowosc.wynagrodzenie.id_premii
WHERE ksiegowosc.pensja.kwota >2000 and ksiegowosc.premia.rodzaj LIKE 'brak';

UPDATE ksiegowosc.premia
SET rodzaj = 'brak'
WHERE id_premii= 11;
SELECT * FROM ksiegowosc.premia

--d) Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’. 

SELECT * FROM ksiegowosc.pracownicy 
WHERE ksiegowosc.pracownicy.imie LIKE 'J%';

--e) Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’.

SELECT * FROM ksiegowosc.pracownicy 
WHERE ksiegowosc.pracownicy.imie LIKE '%a' AND ksiegowosc.pracownicy.nazwisko LIKE '%n%';

--f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 160 h miesiêcznie. 

SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko,( ksiegowosc.godziny.liczba_godzin*20)-160 AS nadgodziny
FROM ksiegowosc.pracownicy 
INNER JOIN (ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.godziny
ON ksiegowosc.wynagrodzenie.id_godziny=ksiegowosc.godziny.id_godziny) 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
WHERE ( ksiegowosc.godziny.liczba_godzin*20)-160>0

--g) Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 1500 –3000PLN.

SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota
FROM (ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji) 
INNER JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
WHERE ksiegowosc.pensja.kwota BETWEEN 1500 AND 3000;

--h) Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinachi nie otrzymali premii.

SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie 
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
INNER JOIN ksiegowosc.godziny 
ON ksiegowosc.wynagrodzenie.id_godziny = ksiegowosc.godziny.id_godziny
INNER JOIN ksiegowosc.premia 
ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii 
WHERE (ksiegowosc.godziny.liczba_godzin*20)-160>0 AND ksiegowosc.premia.rodzaj LIKE 'brak'

--i) Uszereguj pracowników wed³ug pensji.

SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota
FROM (ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
ORDER BY ksiegowosc.pensja.kwota;

--j) Uszereguj pracowników wed³ug pensji i premii malej¹co.
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota, ksiegowosc.premia.kwota
FROM ((ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji) 
INNER JOIN ksiegowosc.premia 
ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
ORDER BY ksiegowosc.pensja.kwota DESC,ksiegowosc.premia.kwota DESC;
--ORDER BY ksiegowosc.premia.kwota DESC;

--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’.
SELECT pen.stanowisko, COUNT(pen.stanowisko)
FROM ksiegowosc.pracownicy AS pra 
INNER JOIN ksiegowosc.wynagrodzenie AS wyn 
ON pra.id_pracownika = wyn.id_pracownika 
INNER JOIN ksiegowosc.pensja AS pen 
ON wyn.id_pensji = pen.id_pensji
GROUP BY pen.stanowisko

--l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne).

SELECT ksiegowosc.pensja.stanowisko,AVG(ksiegowosc.pensja.kwota) AS srednia, Min(ksiegowosc.pensja.kwota) AS minimalna,
MAX(ksiegowosc.pensja.kwota) AS maksymalna
FROM ksiegowosc.pensja
WHERE ksiegowosc.pensja.stanowisko LIKE 'analityk'
GROUP BY ksiegowosc.pensja.stanowisko;

--m) Policz sumê wszystkich wynagrodzeñ.
SELECT SUM(pen.kwota)
FROM ksiegowosc.pracownicy AS pra
INNER JOIN ksiegowosc.wynagrodzenie AS wyn
ON pra.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja AS pen
ON wyn.id_pensji = pen.id_pensji

--f)Policz sumê wynagrodzeñ w ramach danego stanowiska.
SELECT pen.stanowisko, SUM(pen.kwota)
FROM ksiegowosc.pracownicy AS pra
INNER JOIN ksiegowosc.wynagrodzenie AS wyn
ON pra.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.pensja AS pen
ON wyn.id_pensji = pen.id_pensji
GROUP BY pen.stanowisko;
--g) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.

SELECT pen.stanowisko, COUNT(pre.id_premii)
FROM ksiegowosc.pracownicy AS pra
INNER JOIN ksiegowosc.wynagrodzenie AS wyn
ON pra.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.premia AS pre
ON wyn.id_premii = pre.id_premii
INNER JOIN ksiegowosc.pensja AS pen
ON wyn.id_pensji = pen.id_pensji
WHERE pre.kwota IS NOT NULL
GROUP BY pen.stanowisko;

--h) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.

DELETE ksiegowosc.pracownicy
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota<1200;

