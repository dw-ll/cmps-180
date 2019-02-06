select distinct t.exchangeID, t.symbol, t.buyerID, t.price * t.volume AS theCost, c.category
from trades t, customers c
where  t.price*t.volume >= 5000
    and c.isvalidcustomer=TRUE
    and c.category is NOT NULL
    and t.buyerID=c.customerID;