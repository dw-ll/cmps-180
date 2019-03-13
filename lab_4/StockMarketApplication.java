import java.sql.*;
import java.util.*;

/**
 * The class implements methods of the StockMarket database interface.
 *
 * All methods of the class receive a Connection object through which all
 * communication to the database should be performed. Note: the Connection
 * object should not be closed by any method.
 *
 * Also, no method should throw any exceptions. In particular, in case an error
 * occurs in the database, then the method should print an error message and
 * call System.exit(-1);
 */

public class StockMarketApplication {

    private Connection connection;

    /*
     * Constructor
     */
    public StockMarketApplication(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection() {
        return connection;
    }

    /**
     * Takes as argument an integer called numDifferentStocksSold. Returns the
     * customerID for each customer in Customers that has been the seller of at
     * least numDifferentStocksSold different stocks in Trades. If
     * numDifferentStocksSold is not positive, that's an error.
     */

    public List<Integer> getCustomersWhoSoldManyStocks(int numDifferentStocksSold) {
        List<Integer> result = new ArrayList<Integer>();
        // your code here
        // If invalid argument is given.
        if (numDifferentStocksSold <= 0) {
            System.out.println("numDifferentStocksSold has to be greater than 0.");
            System.exit(-1);
        }
        // Create a new statement, set up a try-catch. Adapted from PostgreSQL driver
        // doc.
        try {
            Statement customerQuery = connection.createStatement();
            ResultSet customerBag = customerQuery.executeQuery(
                    "SELECT COUNT(DISTINCT t.symbol), c.customerID FROM Trades t, Customers c  WHERE c.customerID = t.sellerID GROUP BY c.customerID;");
            while (customerBag.next()) {
                // Iterate through the ResultSet and if the current COUNT is greater than
                // numDifferentStocks sold, add it to our result list. Else move on.
                if (customerBag.getInt(1) >= numDifferentStocksSold) {
                    result.add(customerBag.getInt(2));
                } else {
                    continue;
                }

            }
        } catch (Exception e) {
            return null;
        }

        // end of your code
        return result;
    }

    /**
     * The updateQuotesForBrexit method has one string argument, theExchangeID,
     * which is the exchangeID for an exchange. updateQuotesForBrexit should update
     * price in Quotes for every quote that has that exchangedID, multiplying price
     * by 0.87. updateQuotesForBrexit should return the number of quotes whose
     * prices were updated.
     */

    public int updateQuotesForBrexit(String theExchangeID) {

        if(theExchangeID == null || theExchangeID.length() > 6){
            System.out.println("Invalid exhchangeID for updateQuotesForBrexit.");
            System.exit(-1);
        }
        int rowsConverted = 0;
        // your code here; return 0 appears for now to allow this skeleton to compile.
        // Code adapted from "Performing Updates" in the PostgreSql JDBC docs.
        try {
            // Set up a prepared statement which will be used to update the database
            // where conditions are met.
            PreparedStatement quoteUpdate = connection
                    .prepareStatement("UPDATE Quotes SET price = price *0.87 WHERE exchangeID = ?");
            // use setString to assign theExchangeID to the wildcard in the above update
            // statement.
            quoteUpdate.setString(1, theExchangeID);
            // Execute the update and save the amount of rows that were update. Close the
            // statement.
            rowsConverted = quoteUpdate.executeUpdate();
            quoteUpdate.close();
        } catch (Exception e) {
            System.out.println("updateQuotesForBrexit ran into the error: " + e);
            System.exit(-1);
        }
        return rowsConverted;
        // end of your code
    }

    /**
     * rewardBestBuyers has two integer parameters, theSellerID and theCount. It
     * invokes a stored function rewardBuyersFunction that you will need to
     * implement and store in the database according to the description in Section
     * 5. rewardBuyersFunction should have the same two parameters, theSellerID and
     * theCount.
     *
     * Trades has a volume attribute. rewardBuyersFunction will increase the volume
     * for some trades whose sellerID is theSellerID; Section 5 explains which trade
     * volumes should be increased, and how much they should be increased. The
     * rewardBestBuyers method should return the same integer result as the
     * rewardBuyersFunction stored function.
     *
     * The rewardBestBuyers method must only invoke the stored function
     * rewardBuyersFunction, which does all of the assignment work; do not implement
     * the rewardBestBuyers method using a bunch of SQL statements through JDBC.
     * However, rewardBestBuyers should check to see whether theCount is greater
     * than 0, and report an error if it’s not.
     */

    public int rewardBestBuyers(int theSellerID, int theCount) {
        // There's nothing special about the name storedFunctionResult
        if(theCount < 0){
            System.out.println("Invalid input for theCount for rewardBestBuyers.");
            System.exit(-1);
        }
        int storedFunctionResult = 0;

        // your code here
        // Code adapted from "Performing Updates" in the PostgreSql JDBC docs.
        try {
            // Set up another prepared statement to call upon rewardBuyersFunction
            // given a particular set of parameters
            PreparedStatement rewardBuyers = connection.prepareStatement("SELECT * FROM rewardBuyersFunction(?,?);");
            // Assign those parameters to the wildcards in rewardBuyersFunction
            // (theSellerId, theCount)
            rewardBuyers.setInt(1, theSellerID);
            rewardBuyers.setInt(2, theCount);
            // Set up a result set to look at the row returned by the query.
            ResultSet rewardBag = rewardBuyers.executeQuery();
            // Had a bug with ResultSet, so I used .next() to position it correctly.
            rewardBag.next();
            // Define the return variable to be the value in the row returned.
            storedFunctionResult = rewardBag.getInt(1);
        } catch (Exception e) {
            System.out.println("rewardBestBuyers ran into the error: " + e);
            System.exit(-1);
        }
        // end of your code
        return storedFunctionResult;

    }

};