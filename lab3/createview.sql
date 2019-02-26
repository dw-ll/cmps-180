CREATE VIEW openPrice AS
SELECT exchangeID, symbol, quoteTS, price, DATE(quoteTS)
FROM Quotes 
WHERE quoteTS::TIME IN(SELECT MIN(q.quoteTS::TIME) FROM Quotes q WHERE exchangeID=q.exchangeID AND  AND DATE(q.quoteTS)=DATE(quoteTS) );


CREATE VIEW QuotesSummary AS
SELECT exchangeID, symbol,quoteTS::DATE as theDate, MIN(price) as lowPrice, MAX(price) as highPrice
FROM Quotes
GROUP BY exchangeID, symbol, theDate
ORDER BY theDate;

