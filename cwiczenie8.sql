--Wykorzystuj¹c wyra¿enie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki pracownika oraz jego danych, a nastêpnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi¹¿ w oparciu o AdventureWorks.
WITH zad1 (JobTitle, BirthDate, Gender, HireDate, MaritalStatus, VacationHours, SickLeaveHours, Rate)
AS
(
	SELECT JobTitle, BirthDate, Gender, HireDate, MaritalStatus, VacationHours, SickLeaveHours, Rate FROM AdventureWorks2019.HumanResources.Employee AS em
	INNER JOIN AdventureWorks2019.HumanResources.EmployeePayHistory AS pe
	ON em.BusinessEntityID = pe.BusinessEntityID
)

SELECT * FROM zad1

--Uzyskaj informacje na tematprzychodówze sprzeda¿y wed³ug firmy i kontaktu (za pomoc¹ CTEi bazy AdventureWorksL). Wynik powinien wygl¹daæ nastêpuj¹co:

WITH zad2 (CompanyContact, Revenue)
AS
(
	SELECT concat(CompanyName, ' (', FirstName, LastName, ')') AS CompanyContact, TotalDue AS Revenue 
	FROM AdventureWorksLT2019.SalesLT.Customer AS Cust
	INNER JOIN AdventureWorksLT2019.SalesLT.SalesOrderHeader AS SalHe
	ON Cust.CustomerID = SalHe.CustomerID
)
SELECT * FROM zad2
ORDER BY CompanyContact;

--Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów.Wykorzystaj CTE i bazê AdventureWorksLT.
WITH zad3 (Category, SalesValue)
AS
(
SELECT kat.Name AS Category, ROUND(UnitPrice, 2) * OrderQty AS SalesValue FROM AdventureWorksLT2019.SalesLT.Product AS pro
INNER JOIN AdventureWorksLT2019.SalesLT.ProductCategory AS kat
ON pro.ProductCategoryID = kat.ProductCategoryID
INNER JOIN AdventureWorksLT2019.SalesLT.SalesOrderDetail AS det
ON pro.ProductID = det.ProductID
)
SELECT Category, SUM(SalesValue) AS SalesValue FROM zad3
GROUP BY Category
ORDER BY Category;