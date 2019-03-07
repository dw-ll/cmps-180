SELECT c.customerID, count(*)
FROM Customers c, Trades t 
WHERE c.customerID = t.sellerID
GROUP BY c.customerID;