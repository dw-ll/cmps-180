select distinct stocks.exchangeID, stocks.stockName
from stocks, quotes
where quotes.price < 314.15 
and stocks.symbol = quotes.symbol
and quotes.exchangeID = stocks.exchangeID;
