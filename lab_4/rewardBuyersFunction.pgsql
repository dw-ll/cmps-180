CREATE FUNCTION rewardBuyersFunction(
    IN seller INTEGER,
    IN theCount INTEGER
)
    RETURNS INTEGER AS
    $$
    DECLARE sellerRelation CURSOR 
        FOR SELECT buyerID
        FROM BuyerSellerTotalCost
        WHERE seller = sellerID
        ORDER BY totalCost DESC;
    currentBuyer INTEGER;
    numberOfRewards INTEGER := 0;

    BEGIN
    OPEN sellerRelation;
    LOOP 
    FETCH sellerRelation INTO currentBuyer;
    EXIT WHEN NOT FOUND;
    IF numberOfRewards = theCount THEN EXIT;
    END IF;
    IF 

    END;

    $$
    LANGUAGE plpgsql;