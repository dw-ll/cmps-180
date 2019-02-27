-- Case 2 where tuple ALREADY exists, check for customerID similarity.
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE Customers
SET custName = NewCustomers.custName, address=NewCustomers.address
FROM NewCustomers
WHERE Customers.customerID = NewCustomers.customerID;
-- Case 1 where tuple is new, update Customers table at ID, Name and Address 
-- and flip isValidCustomer to true.
INSERT INTO Customers(customerID,custName,address,isValidCustomer)
(SELECT customerID,custName,address,TRUE
FROM NewCustomers
WHERE NOT EXISTS(SELECT * 
    FROM Customers
    WHERE customerID = NewCustomers.customerID
    AND custName = NewCustomers.custName
    AND address = NewCustomers.address));

COMMIT;