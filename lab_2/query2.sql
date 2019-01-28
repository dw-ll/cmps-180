select stockName,symbol
from stocks
where not(exchangeID ='NASDAQ');