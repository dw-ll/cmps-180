SELECT COUNT(DISTINCT t.symbol), c.customerID
FROM Trades t, Customers c 
WHERE c.customerID = t.sellerID
GROUP BY c.customerID;