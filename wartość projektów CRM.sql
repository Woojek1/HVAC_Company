select a.pnum numer_projektu, a.pnam nazwa_projektu, sum(a.sm) wartosc_sprzedazy, a.koord koordynator
from (		
	select 
		ord.ProductName 
		,ord.ProductNumber
		,ord.ProductInvoicePriceNetto
		,ord.ProductDiscount
		,sum(ord.ProductNumber * ord.ProductInvoicePriceNetto) sm
		,p.ProjectNumber pnum
		,p.ProjectName pnam
		,o.OfferNumber
		,o.OrderNumber
		,o.OrderStatus
		,o.OrderDate
		,concat(w.workersurname," ",w.workername) koord
	from orderproductrel ord join orders o
	on ord.OrderId = o.OrderId 
	join project p 
	on o.ProjectId = p.ProjectId
	join worker w 
	on p.ProjectContractorId = w.workerid
	where o.orderstatus = 4
	group by o.OrderNumber
	order by o.OrderNumber desc
	) as a
group by 1
order by 1 desc
