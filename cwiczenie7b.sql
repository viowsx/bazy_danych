USE AdventureWorks2019
GO;
--1)Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. Procedura musi przyjmowa� jako argument wej�ciowy liczb� n. Generowanie ci�gu Fibonacciego musi zosta� zaimplementowane jako osobna funkcja,wywo�ywana przez procedur�.

CREATE OR ALTER FUNCTION dbo.fib(@wyraz int)
RETURNS @wynik TABLE(fintab int)
AS
BEGIN
	DECLARE @wyraz1 INT;
	DECLARE @wyraz2 INT;
	DECLARE @temp INT;
	DECLARE @iter INT;
	SET @temp = 0;
	SET @wyraz1 = 0;
	SET @wyraz2 = 1;
	SET @iter = 2;
	
	WHILE(@iter <=@wyraz + 1)
	BEGIN
		SET @temp = @wyraz1 + @wyraz2;
		SET @wyraz1=@wyraz2;
		SET @wyraz2=@temp;
		SET @iter=@iter+1;
		INSERT INTO @wynik VALUES (@wyraz2)
		END
	RETURN
END;

CREATE OR ALTER PROCEDURE dbo.fin(@x INT)
AS
BEGIN
SELECT*FROM dbo.fib(@x)
END; 

EXEC dbo.fin 10;

--2)Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Personszmodyfikuje nazwisko tak, aby by�o napisane du�ymi literami. 
CREATE OR ALTER TRIGGER triggerupper
ON Person.Person
AFTER INSERT
AS
BEGIN
UPDATE Person.Person 
SET Person.LastName = UPPER(Person.LastName) 
WHERE LastName IN (SELECT LastName FROM INSERTED)
END;

INSERT INTO Person.BusinessEntity(rowguid)
VALUES(newid());

INSERT INTO Person.Person (BusinessEntityID,PersonType,FirstName,MiddleName,LastName) 
VALUES (20778,'IN','Anna','Karolina','Kowalska');


SELECT * FROM Person.BusinessEntity
SELECT * FROM Person.Person WHERE Person.LastName = 'Kowalska'

-- Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi zmiana warto�ci w polu �TaxRate�o wi�cej ni� 30%.
CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
DECLARE @NEWTaxRate INT, @TaxRate INT
SELECT @NEWTaxRate = TaxRate FROM INSERTED
SELECT @TaxRate = TaxRate FROM DELETED
IF @NEWTaxRate > 1.3* @TaxRate
PRINT 'ERROR'
END


SELECT * FROM Sales.SalesTaxRate;


UPDATE Sales.SalesTaxRate 
SET TaxRate =  150.00
WHERE SalesTaxRateID = 5;