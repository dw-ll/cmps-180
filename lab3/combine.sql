-- Case 2 where tuple ALREADY exists.
UPDATE Customers
SET custName = NewCustomers.custName, address=NewCustomers.address
FROM NewCustomers
WHERE Customers.customerID = NewCustomers.customerID;
-- Case 1 where tuple is new.
INSERT INTO Customers(customerID,custName,address,isValidCustomer)
(SELECT customerID,custName,address,TRUE
FROM NewCustomers
WHERE NOT EXISTS(SELECT * 
    FROM Customers
    WHERE customerID = NewCustomers.customerID
    AND custName = NewCustomers.custName
    AND address = NewCustomers.address));