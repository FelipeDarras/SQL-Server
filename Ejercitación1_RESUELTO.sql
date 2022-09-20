-- EXEC sp_help 'HumanResources.Employee';    para la metadata de las tablas

-- Ejercicio 1

SELECT city,  count(CITY) AS CantidadCiudades
FROM Person.Address
GROUP BY city
ORDER BY COUNT(CITY) DESC;

-- Ejercicio 2

SELECT 
	e.JobTitle,
	DATEDIFF(YEAR,e.BirthDate ,GETDATE()) as EdadEmpleado
FROM HumanResources.Employee AS e;

-- Ejercicio 3 

SELECT  p.Name,
		p.ProductNumber, 
		CASE p.MakeFlag
			WHEN 0 THEN 'El producto se compra'
			ELSE 'El producto se fabrica en la empresa'
			END AS MakeFlag,
		CASE 
			WHEN p.Color IS NULL THEN 'No color'
			ELSE Color
			END AS Color, 
		CAST(p.SellStartDate AS DATE) AS SellStartDate, 
		p.SellEndDate
FROM Production.Product AS p

-- Ejercicio 4 y 5

SELECT 
	CONCAT_WS(' ',per.FirstName,per.LastName) AS Nombre,
	pph.PhoneNumber AS NumeroTelefono
FROM Person.Person AS per JOIN Person.PersonPhone AS pph
ON per.BusinessEntityID = pph.BusinessEntityID

-- Ejercicio 6

SELECT 
	p.Name AS NombreProducto,
	sc.Name AS CategoriaProducto
FROM Production.Product AS p LEFT JOIN Production.ProductSubcategory AS sc
ON P.ProductSubcategoryID = sc.ProductSubcategoryID
ORDER BY CategoriaProducto DESC;

-- Ejercicio 7 

SELECT
	sc.Name,
	COUNT(*) AS Cantidad
FROM Production.Product AS p LEFT JOIN Production.ProductSubcategory AS sc
ON p.ProductSubcategoryID = sc.ProductSubcategoryID
GROUP BY sc.Name
ORDER BY Cantidad DESC;

-- Ejercicio 8

SELECT P.FirstName, s.SalesYTD AS Total
FROM Person.Person AS p JOIN Sales.SalesPerson AS s
ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY p.FirstName;

-- Ejercicio 9 

SELECT P.FirstName, s.SalesLastYear
FROM Person.Person AS p JOIN Sales.SalesPerson AS s
ON p.BusinessEntityID = s.BusinessEntityID
WHERE s.SalesLastYear > (
	SELECT AVG(SalesLastYear) FROM Sales.SalesPerson);

-- Ejercicio 10

SELECT p.Name, stock.Total
FROM Production.Product AS p
INNER JOIN
	(SELECT TOP 1 ProductID, SUM(Quantity) AS Total
	FROM Production.ProductInventory
	GROUP BY ProductID
	ORDER BY Total DESC) AS stock
ON p.ProductID = stock.ProductID



EXEC sp_help 'HumanResources.Employee';