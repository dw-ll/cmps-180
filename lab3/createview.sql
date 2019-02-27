-- Helper view to obtain opening price for a stock on each day it traded.
CREATE VIEW openPrice AS
SELECT  exchangeID, symbol, quoteTS, price, DATE(quoteTS)
FROM Quotes 
WHERE quoteTS::TIME IN (SELECT  MIN(q.quoteTS::TIME) 
                        FROM Quotes q
                         WHERE exchangeID=q.exchangeID AND DATE(q.quoteTS)=DATE(quoteTS)
                         GROUP BY exchangeID, symbol,DATE(quoteTS)  );

-- Helper view to obtain closing price for a stock on each day it traded.
CREATE VIEW closePrice AS
SELECT  exchangeID, symbol, quoteTS, price, DATE(quoteTS)
FROM Quotes 
WHERE quoteTS::TIME IN (SELECT  MAX(q.quoteTS::TIME) 
                        FROM Quotes q
                         WHERE exchangeID=q.exchangeID AND DATE(q.quoteTS)=DATE(quoteTS)
                         GROUP BY exchangeID, symbol,DATE(quoteTS));

-- View that displays the following: exchangeID, stock symbol, date traded, lowest price for that stock, 
-- highest price for that stock, opening price for that stock on that day, and closing price for that stock
-- on that day.
CREATE VIEW QuotesSummary AS
SELECT DISTINCT q.exchangeID, q.symbol,q.quoteTS::DATE as theDate, MIN(q.price) as lowPrice, MAX(q.price) as highPrice,
p.price AS openingPrice, c.price AS closingPrice
FROM Quotes q, openPrice p, closePrice c 
WHERE DATE(p.quoteTS) = DATE(q.quoteTS) AND DATE(c.quoteTS) = DATE(q.quoteTS) AND p.exchangeID = q.exchangeID 
AND p.exchangeID = c.exchangeID AND q.exchangeID = c.exchangeID
GROUP BY q.exchangeID, q.symbol, theDate, openingPrice, closingPrice
ORDER BY theDate;

