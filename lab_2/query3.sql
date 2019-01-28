select distinct stocks.exchangeID, stocks.stockName
from stocks,quotes
where quotes.price < 314.15 and
stocks.exchangeID = quotes.exchangeID;