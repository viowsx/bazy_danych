USE AdventureWorks2019;

--1)Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako argument wejœciowy liczbê n. Generowanie ci¹gu Fibonacciego musi zostaæ zaimplementowane jako osobna funkcja,wywo³ywana przez procedurê.

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

--2)Napisz trigger DML, który po wprowadzeniu danych do tabeli Personszmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami. 
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

-- Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu ‘TaxRate’o wiêcej ni¿ 30%.
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
