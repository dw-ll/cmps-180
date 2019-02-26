-- Foreign Key Unit Tests (Failing)
INSERT INTO Trades (exchangeID,symbol,tradeTS,buyerID,sellerID,price,volume)
            VALUES ('NYSE','CLDR','2018-11-20 13:03:24',0101,1489,10,1000);
INSERT INTO Trades (exchangeID,symbol,tradeTS,buyerID,sellerID,price,volume)
            VALUES ('NYSE','CLDR','2018-11-20 13:03:24',1489,1101,10,1000);
INSERT INTO Trades (exchangeID,symbol,tradeTS,buyerID,sellerID,price,volume)
            VALUES ('WOMBT','AAPL','2018-11-20 13:03:24',1489,1456,10,1000);
INSERT INTO Quotes (exchangeID,symbol,quoteTS,price)
            VALUES ('NYSE','RBT','2018-11-20 13:03:24',5000);