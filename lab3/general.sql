-- Check that Quotes price is positive.
ALTER TABLE Quotes
ADD CONSTRAINT pos_price
CHECK (price >0);
--  Check that Trades cost (price * volume) is positive
ALTER TABLE Trades
ADD CONSTRAINT pos_cost
CHECK ((price * volume)>0);
-- Check when buyer and seller IDs in Trades are different
ALTER TABLE Trades
ADD CONSTRAINT diff_id
CHECK (buyerID <> sellerID);
-- Check when a Customer's category is H then they are a valid 
-- customer as well
ALTER TABLE Customers
ADD CONSTRAINT h_flag CHECK ((category='H'AND isValidCustomer=TRUE));

