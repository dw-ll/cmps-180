-- Foreign Key Unit Tests (Failing)
INSERT INTO Trades (exchangeID,symbol,tradeTS,buyerID,sellerID,price,volume)
            VALUES ('NYSE','CLDR','2018-11-20 13:03:24',0101,1489,10,1000);
INSERT INTO Trades (exchangeID,symbol,tradeTS,buyerID,sellerID,price,volume)
            VALUES ('NYSE','CLDR','2018-11-20 13:03:24',1489,1101,10,1000);
INSERT INTO Trades (exchangeID,symbol,tradeTS,buyerID,sellerID,price,volume)
            VALUES ('WOMBT','RBT','2018-11-20 13:03:24',1489,1456,10,1000);
INSERT INTO Quotes (exchangeID,symbol,quoteTS,price)
            VALUES ('CAML','RBT','2018-11-20 13:03:24',5000);
-- General Constraint Unit Tests (1 Pass 1 Fail)
-- pos_price
UPDATE Quotes
set price =50;
UPDATE Quotes
set price =-1;

-- pos_cost
UPDATE Trades
set price =1, volume =2;
UPDATE Trades
set price = 0, volume = 100;

-- diff_id
UPDATE Trades
set buyerID = 1, sellerID = 2;
UPDATE Trades 
set buyerID = 1, sellerID = 1;

-- h_flag
UPDATE Customers
set isValidCustomer=true
WHERE (category = 'H');
UPDATE Customers
set isValidCustomer=false
WHERE (category = 'H');


