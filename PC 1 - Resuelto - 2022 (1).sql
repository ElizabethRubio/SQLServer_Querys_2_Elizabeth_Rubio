
/*
1. El orden lógico es muy importante a la hora de escribir nuestras consultas SQL; teniendo en
cuenta este gráfico:

	SELECT			<select list>
	FROM			<table source>
	WHERE			<search condition>
	GROUP BY		<group by list>
	HAVING			<search condition>
	ORDER B Y		<order by list>

Crea 2 consultas; 1 que funcione y 1 que no funcione POR ORDEN LÓGICO, Solo hasta el GROUP BY  */
-- Funciona

select *
from Production.Products
go 

select 
	supplierid as [Proveedor],
	unitprice as [Unidades vendidas]	 
from Production.Products
where supplierid BETWEEN 10 AND 20
group by supplierid
go

-- No funciona
select 
	supplierid		as [Proveedor],
	unitprice		as [Unidades vendidas]	 
from Production.Products
group by supplierid
where supplierid BETWEEN 10 AND 20
go

/*
2. Se necesita tener una lista de códigos de productos mayores iguales a 60 y menores iguales
a 70 (USA TSQL – Production.Products)
*/
select
	productid	as [CodigoProducto],
	productname as [NombreProducto],
	categoryid	as [CodigoCategoria],
	unitprice	as [PrecioUnitario]
from  Production.Products
where productid BETWEEN 60 and 70
order by productid asc
GO

/*
3. Se necesita categorizar las ventas por la siguiente regla (USA TSQL; Sales.OrdersDetails):
		-  Ventas Totales Mayores iguales a 500 – “ALTAS”
		-  Ventas Totales Menores a 500 – “BAJAS”
*/

select 
	orderid			as [codigoorden],
	productid		as [codigoproducto],
	unitprice		as [preciounitario],
	qty				as [cantidad],
	(unitprice*qty) as [ventatotal],
	case when (unitprice*qty)>=500 then 'Altas' else 'Bajas' end categoria 
from Sales.OrderDetails
order by orderid asc
go 

/*
4. Se necesita tener (USE TSQL Sales.Orders, Sales.OrdersDetails, Sales.Customers y
Production.Products):
	•Una lista únicamente con las ventas realizadas por los siguientes campos: IdCliente,
	NombreCliente, OrderID, NombreProducto, Venta

	NOTA: Solo mostrar ventas de clientes con código mayor igual a 34 y ventas totales mayores
	iguales a 1000




 -- Production.Products y Production.Categories se relacionan en categoryid
 -- Production.Products y Production.Supplier se reacionan en supplierid

*/

select 
	C.custid			as [IdCliente],
	C.contactname		as [NombreCliente],
	O.orderid			as [OrderID],
	PC.categoryname		as [CategoriaProducto],
	P.productname		as [NombreProducto],
	PS.contactname		as [NombreProveedor],
	OD.unitprice*OD.qty as [Venta]
from  Sales.Customers as C
inner join Sales.Orders as O
on C.custid=O.custid
inner join Sales.OrderDetails as OD		on O.orderid=OD.orderid
inner join Production.Products as P		on OD.productid=p.productid
inner join Production.Categories as PC	on P.categoryid=PC.categoryid
inner join Production.Suppliers as PS	on P.supplierid=PS.supplierid
where C.custid >=34 and OD.unitprice*OD.qty>=1000
order by productname asc
GO

