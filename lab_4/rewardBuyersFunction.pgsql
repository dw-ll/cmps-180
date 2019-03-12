CREATE FUNCTION rewardBuyersFunction(
    IN theSellerID INTEGER,
    IN theCount INTEGER
)  
    RETURNS INTEGER AS $$
    -- Define a cursor using a query on BuyerSellerTotalCost, Trades, and Customers to 
    -- populate cursor with necessary info 
    DECLARE sellerRelation CURSOR 
    FOR SELECT DISTINCT b1.sellerID, b1.buyerID, b1.totalCost, c.category
    FROM Trades t, Customers c, BuyerSellerTotalCost b1
    WHERE b1.buyerID = c.customerID
    GROUP BY b1.sellerID, b1.buyerID, b1.totalCost, c.category
    ORDER BY b1.totalCost DESC;
    -- Local Variables
   
    currentSeller INTEGER;
    currentBuyer INTEGER;
    theCost INTEGER;
    buyerCategory CHAR(1);
    numberOfRewards INTEGER := 0;
    rewarded INTEGER := 0;
    rowsUpped INTEGER := 0;
    BEGIN
    -- Open created cursor
    OPEN sellerRelation;
  
    LOOP  
    -- Load current attributes of cursor into local vars
    FETCH sellerRelation INTO currentSeller,currentBuyer,theCost,buyerCategory;
    -- Move if tuple does not exist
    EXIT WHEN NOT FOUND;
    -- We've reached the right amount of different customers, our job is done
    IF numberOfRewards > theCount THEN EXIT; END IF;
    -- If not, do the required updates below
-- Higher category
    IF buyerCategory='H' THEN 
    UPDATE Trades t
    SET volume = volume + 50
    WHERE t.sellerID = theSellerID AND t.buyerID = currentBuyer;
    GET DIAGNOSTICS rowsUpped = ROW_COUNT;
    rewarded:=rewarded+rowsUpped;
    numberOfRewards:=numberOfRewards+1;
    
-- Medium Category 
    ELSIF buyerCategory='M' THEN 
    UPDATE Trades t
    SET volume = volume + 20
    WHERE t.sellerID = theSellerID AND t.buyerID = currentBuyer;
    GET DIAGNOSTICS rowsUpped = ROW_COUNT;
    rewarded:=rewarded+rowsUpped;
    numberOfRewards:=numberOfRewards+1;
-- Low Category 
    ELSIF buyerCategory='L' THEN 
    UPDATE Trades t
    SET volume = volume + 5
    WHERE t.sellerID = theSellerID AND t.buyerID = currentBuyer;
    GET DIAGNOSTICS rowsUpped = ROW_COUNT;
    rewarded:=rewarded+rowsUpped;
    numberOfRewards:=numberOfRewards+1;
    ELSE 
    -- No Category 
    UPDATE Trades t
    SET volume = volume + 1
    WHERE t.sellerID = theSellerID AND t.buyerID = currentBuyer;
    GET DIAGNOSTICS rowsUpped = ROW_COUNT;
    rewarded:=rewarded+rowsUpped;
    numberOfRewards:=numberOfRewards+1;
    END IF;
    END LOOP;
    -- Return the amount of rows theSeller rewarded
    RETURN rewarded;

    END; $$
    LANGUAGE plpgsql;