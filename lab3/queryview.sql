-- A query to determine how many times a stock closes on it's high price
-- on a certain date. Tables used: Exchanges, Stocks || Views used: QuotesSummary

SELECT e.exchangeName,s.stockName, COUNT(q.theDate) as numHighClosing
FROM Exchanges e, Stocks s, QuotesSummary q
WHERE q.symbol = s.symbol AND s.exchangeID = q.exchangeID AND e.exchangeID = q.exchangeID
GROUP BY e.exchangeName , s.stockName
HAVING COUNT(q.theDate) >=2;
-- Output
--      exchangename       |           stockname            | numhighclosing
-------------------------+--------------------------------+----------------
-- NASDAQ Stock Exchange   | Cloudera                       |              3
-- NASDAQ Stock Exchange   | Hewlett Packard Enterprise Co. |              2
-- New York Stock Exchange | Cloudera,Inc.                  |              3
-- New York Stock Exchange | HP Enterprise                  |              2

-- Delete of two possible tuples in Quotes.
DELETE 
FROM Quotes 
WHERE (exchangeID = 'NYSE' AND symbol = 'CLDR');

DELETE
FROM Quotes
WHERE exchangeID = 'NASDAQ' AND symbol = 'ANF';

-- Output of queryview.sql after DELETE statements.
--      exchangename       |           stockname            | numhighclosing
-------------------------+--------------------------------+----------------
-- NASDAQ Stock Exchange   | Hewlett Packard Enterprise Co. |              2
--  New York Stock Exchange | HP Enterprise                  |              2