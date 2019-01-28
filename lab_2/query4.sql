select trades.exchangeID, trades.buyerID, trades.price * trades.volume as cost, customers.category
from customers, trades
where NOT(cost < 5000 and customers.isValidCustomer = 't' and customers.category = NULL);