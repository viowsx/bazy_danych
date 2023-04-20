USE firma;
GO
-- 1) Tworzymy baze danych:

CREATE DATABASE firma; 

-- 2) Tworzymy nowy schemat rozliczenia:

CREATE SCHEMA rozliczenia;

-- 3) Tworzymy poszczególne tabele:

CREATE TABLE rozliczenia.pracownicy(
	id_pracownika CHAR(8) PRIMARY KEY,
	imie VARCHAR(50) NOT NULL,
	nazwisko VARCHAR(50) NOT NULL,
	adres VARCHAR(100) NOT NULL,
	telefon CHAR(12) NULL,
  );

CREATE TABLE rozliczenia.godziny(
	id_godziny CHAR(8) PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin SMALLINT NOT NULL,
	id_pracownika CHAR(8) NOT NULL,
); 

CREATE TABLE rozliczenia.premie(
	id_premii CHAR(8) PRIMARY KEY,
	rodzaj VARCHAR(30) NULL,
	kwota SMALLMONEY NOT NULL,
);

CREATE TABLE rozliczenia.pensje(
	id_pensji CHAR(8) PRIMARY KEY,
	stanowisko VARCHAR(60) NOT NULL,
	kwota SMALLMONEY NOT NULL,
	id_premii CHAR(8) NULL,
);

-- Dodajemy klucz obcy 

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

-- 4) Dodajemy po 10 rekordów do ka¿dej tabeli:

INSERT INTO rozliczenia.pracownicy(

	[id_pracownika],
	[imie],
	[nazwisko],
	[adres],
	[telefon]

)
VALUES
(
	'109D',
	'Artur',
	'Kowalski',
	'S³oneczna 17/23, 12-345 Kraków',
	'+48234567890'
),
(
	'324B',
	'Katarzyna',
	'Nowak',
	'Kwiatowa 12/34, 13-456 Kraków',
	'+48123456789'
),
(
	'181K',
	'Jacek',
	'Makowski',
	'Polna 25/1, 56-432 Kraków',
	'+48456123789'
),
(
	'143W',
	'Maria',
	'Bielska',
	'Szkolna 15/2, 24-053 Kraków',
	'+48900837229'
),
(
	'454J',
	'Anna',
	'Milska',
	'Krakowska, 34-072 Wieliczka',
	'+48789987654'
),
(
	'238L',
	'Piotr',
	'Czy¿ewski',
	'Opatowska, 32-321 Kraków',
	'+48459000392'
),
(
	'307C',
	'Wojciech',
	'Witowski',
	'Leœna, 30-082 Kraków',
	'+48345229883'
),
(
	'123P',
	'Adam',
	'Misiak',
	'Jana Kochanowskiego 2/13, 31-042 Kraków',
	'+48200292843'
),
(
	'329A',
	'Danuta',
	'Sobota',
	'Piêkna, 32-073 Skawina',
	'+48432999028'
),
(
	'410M',
	'Amelia',
	'Gwiazda',
	'Kosmiczna, 31-083 Kraków',
	NULL
)

--godziny

INSERT INTO rozliczenia.godziny(

	[data],
	[id_godziny],
	[id_pracownika],
	[liczba_godzin]

)
VALUES
(
	'2023-04-20',
	1,
	'109D',
	8
),
(
	'2023-04-20',
	2,
	'123P',
	8
),
(
	'2023-04-20',
	3,
	'143W',
	8
),
(
	'2023-04-20',
	4,
	'181K',
	8
),
(
	'2023-04-20',
	5,
	'238L',
	6
),
(
	'2023-04-20',
	6,
	'307C',
	8
),
(
	'2023-04-20',
	7,
	'324B',
	8
),
(
	'2023-04-20',
	8,
	'329A',
	10
),
(
	'2023-04-20',
	9,
	'410M',
	8
),
(
	'2023-04-20',
	10,
	'454J',
	6
)

--premie

INSERT INTO rozliczenia.premie(
	[id_premii],
	[kwota],
	[rodzaj]
)
VALUES
(
	'P1',
	800,
	NULL
),
(
	'P2',
	1200,
	NULL
),
(
	'P3',
	950,
	NULL
),
(
	'P4',
	550,
	NULL
),
(
	'P5',
	1300,
	NULL
),
(
	'P6',
	670,
	NULL
),
(
	'P7',
	1200,
	NULL
),
(
	'P8',
	850,
	NULL
),
(
	'P9',
	600,
	NULL
),
(
	'P10',
	1500,
	NULL
)

--pensje

INSERT INTO rozliczenia.pensje (
	[id_pensji],
	[id_premii],
	[kwota],
	[stanowisko]
)
VALUES
(
	'PEN1',
	'P1',
	6000,
	'Ksiêgowy/a'
),
(
	'PEN2',
	'P2',
	8500,
	'Kierownik dzia³u produkcji'
),
(
	'PEN3',
	'P3',
	6500,
	'Manager finansów'
),
(
	'PEN4',
	'P4',
	7800,
	'Ksiêgowy/a'
),
(
	'PEN5',
	'P5',
	8200,
	'Manager ds. marketingu'
),
(
	'PEN6',
	'P6',
	7500,
	'Manager Biura Obs³ugi Klienta'
),
(
	'PEN7',
	'P7',
	5600,
	'M³odszy specjalista ds. marketingu'
),
(
	'PEN8',
	'P8',
	7600,
	'Pracownik Biura Obs³ugi Klienta'
),
(
	'PEN9',
	'P9',
	9500,
	'Specjalista IT'
),
(
	'PEN10',
	'P10',
	8500,
	'Manager produkcji'
)

--5) Wyœwietlamy nazwiska i adresy pracowników:
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6) Przekonwertowanie daty w tabeli godziny, aby wyœwietlana by³a inf o dniu tygodnia i miesi¹cu:
SET LANGUAGE 'Polish';
SELECT DATEPART ( WEEKDAY , data ) as 'dzieñ ', DATEPART ( MONTH , data ) as 'miesi¹c' FROM rozliczenia.godziny;

--7) Zmieniamy nazwê na kwota brutto i dodajemy nowy atrybut kwota netto:
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje
ADD kwota_netto AS (pensje.kwota_brutto * 0.81);

SELECT * FROM rozliczenia.pensje;
