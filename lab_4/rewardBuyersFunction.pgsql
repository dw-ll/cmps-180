CREATE FUNCTION rewardBuyersFunction(
    IN theSellerID INTEGER,
    IN theCount INTEGER
)
    RETURNS INTEGER AS $$
    DECLARE sellerRelation CURSOR 
    FOR SELECT DISTINCT b1.sellerID, b1.buyerID, b1.totalCost, c.category
    FROM Trades t, Customers c, BuyerSellerTotalCost b1
    WHERE b1.buyerID = c.customerID
    GROUP BY b1.sellerID, b1.buyerID, b1.totalCost, c.category
    ORDER BY b1.totalCost DESC;
    -- Local Var
    currentSeller INTEGER;
    currentBuyer INTEGER;
    theCost INTEGER;
    buyerCategory CHAR(1);
    numberOfRewards INTEGER := 0;
    rewarded INTEGER := 0;
    rowsUpped INTEGER := 0;
    BEGIN
    OPEN sellerRelation;
  
    LOOP  
    FETCH sellerRelation INTO currentSeller,currentBuyer,theCost,buyerCategory;

    EXIT WHEN NOT FOUND;
    IF numberOfRewards > theCount THEN EXIT; END IF;
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
    RETURN rewarded;

    END; $$
    LANGUAGE plpgsql;