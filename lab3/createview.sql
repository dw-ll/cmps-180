--CREATE VIEW openPrice AS
--SELECT exchangeID, symbol, quoteTS, price, DATE(quoteTS)
--FROM Quotes 
--WHERE quoteTS::TIME IN(SELECT MIN(qquoteTS::TIME) FROM Quotes q WHERE exchangeID=qexchangeID AND  AND DATE(qquoteTS)=DATE(quoteTS) );


CREATE VIEW QuotesSummary AS
SELECT exchangeID, symbol,quoteTS::DATE as theDate, MIN(price) as lowPrice, MAX(price) as highPrice,
(SELECT MIN(q2.quoteTS::TIME)
FROM Quotes q2 
WHERE exchangeID = q2.exchangeID AND q2.symbol = symbol AND q2.quoteTS::DATE=quoteTS::DATE
ORDER BY MIN(q2.quoteTS::TIME)) openingPrice
FROM Quotes 
GROUP BY exchangeID, symbol, theDate
ORDER BY theDate;

