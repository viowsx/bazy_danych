USE firma2
GO

UPDATE ksiegowosc.pracownicy
SET telefon = '912345678'
WHERE id_pracownika = 454;

--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48)

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon varchar(20);

UPDATE ksiegowosc.pracownicy
SET ksiegowosc.pracownicy.telefon='(+48) '+ksiegowosc.pracownicy.telefon

SELECT * FROM ksiegowosc.pracownicy

--b) Zmodyfikuj atrybut telefonw tabeli pracownicytak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� 
UPDATE ksiegowosc.pracownicy
SET ksiegowosc.pracownicy.telefon=SUBSTRING(ksiegowosc.pracownicy.telefon, 1, 9)+'-'+SUBSTRING(ksiegowosc.pracownicy.telefon, 9, 3)+'-'+SUBSTRING(ksiegowosc.pracownicy.telefon, 12, 3);

--c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter

SELECT ksiegowosc.pracownicy.id_pracownika,
UPPER(ksiegowosc.pracownicy.imie) AS imie, 
UPPER(ksiegowosc.pracownicy.nazwisko) AS nazwisko
FROM ksiegowosc.pracownicy
WHERE LEN(pracownicy.nazwisko) = (select MAX(LEN(pracownicy.nazwisko)) from ksiegowosc.pracownicy);

-- d)  Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5 

SELECT 
HASHBYTES('md5', imie) AS imie, 
HASHBYTES('md5', nazwisko) AS nazwisko,
HASHBYTES('md5', CAST(ksiegowosc.pensja.kwota AS varchar(32))) AS pensje,
HASHBYTES('md5', adres) AS adres,
HASHBYTES('md5', telefon) AS telefon
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji

-- e) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.
SELECT 
ksiegowosc.pracownicy.imie, 
ksiegowosc.pracownicy.nazwisko, 
ksiegowosc.pensja.kwota AS pensje, 
ksiegowosc.premia.kwota AS premie
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia 
ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii;

--f)wygeneruj raport (zapytanie), kt�re zwr�ciw wyniki tre�� wg poni�szego szablonu:
--Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma� pensj� ca�kowit� na kwot� 7540 z�, gdzie wynagrodzenie zasadnicze wynosi�o: 5000 z�, premia: 2000 z�, nadgodziny: 540 z�

ALTER TABLE ksiegowosc.godziny
ADD liczba_nadgodzin INTEGER NULL;

UPDATE  ksiegowosc.godziny
SET liczba_nadgodzin = (liczba_godzin*20) - 160

SELECT * FROM ksiegowosc.godziny

SELECT 'Pracownik '+ imie +' '+ nazwisko +', w dniu '+ CONVERT(varchar(10), CONVERT(date, ksiegowosc.wynagrodzenie.data), 104)
+' otrzyma� pensj� ca�kowit� na kwot� '+ convert(varchar(10),(ksiegowosc.pensja.kwota+ksiegowosc.premia.kwota+
CASE WHEN liczba_nadgodzin <0 --(ksiegowosc.godziny.liczba_godzin*20)-160 < 0 
THEN 0 
ELSE liczba_nadgodzin*20 
END))
+ ' z�, gdzie wynagrodzenie zasadnicze wynosi�o '
+ CAST(ksiegowosc.pensja.kwota as varchar(10)) + ' z�, premia: ' + CAST(ksiegowosc.premia.kwota as varchar(10)) + ' z�, nadgodziny: '+ 
CONVERT(varchar(7),(CASE WHEN liczba_nadgodzin < 0 THEN 0 ELSE liczba_nadgodzin*20 END)) + ' z�.' as raport
FROM ksiegowosc.wynagrodzenie 
LEFT JOIN ksiegowosc.pracownicy 
ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensja 
ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji 
LEFT JOIN ksiegowosc.premia 
ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii
LEFT JOIN ksiegowosc.godziny 
ON ksiegowosc.wynagrodzenie.id_godziny=ksiegowosc.godziny.id_godziny;
SELECT * FROM ksiegowosc.godziny;
