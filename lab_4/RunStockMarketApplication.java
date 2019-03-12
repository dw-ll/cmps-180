import java.sql.*;
import java.io.*;
import java.util.*;

/**
 * A class that connects to PostgreSQL and disconnects.
 * You will need to change your credentials below, to match the usename and password of your account
 * in the PostgreSQL server.
 * The name of your database in the server is the same as your username.
 * You are asked to include code that tests the methods of the StockMarketApplication class
 * in a similar manner to the sample RunStoresApplication.java program.
*/


public class RunStockMarketApplication
{
    public static void main(String[] args) {
    	
    	Connection connection = null;
    	try {
			//Register the driver
			
    		Class.forName("org.postgresql.Driver"); 
    	    // Make the connection.
            // You will need to fill in your real username abd password for your
            // Postgres account in the arguments of the getConnection method below.
            connection = DriverManager.getConnection(
                                                     "jdbc:postgresql://cmps180-db.lt.ucsc.edu/daswilli",
                                                     "daswilli",
													 "function02manager");
			StockMarketApplication app = new StockMarketApplication(connection);
            if (connection != null)
				System.out.println("Connected to the database!");

			// getCustomersWhoSoldManyStocks call and variables
			int numDifferentStocksSold = 4;
			// Fill list with ID's returned by getCustomers
			List<Integer> custIds = new ArrayList<Integer>();
			custIds = app.getCustomersWhoSoldManyStocks(numDifferentStocksSold);
			// Some error checking.
			if(custIds.isEmpty()){
				System.out.println("Nobody sold that many stocks.");
			}
			// Test output below
			/*
			 * /* Output of getCustomersWhoSoldManyStocks 
			 * /* when the parameter of numDifferentStocksSold is 4.
			 *    1456 1489 9731
			 */
			System.out.println("----- Customers who sold at least " + numDifferentStocksSold + " stocks -----");			
			for(int id : custIds){
				System.out.println(id);
			} 
			


		// UPDATE QUOTES FOR BREXIT //


			// updateQuotesForBrexit call and variables 
			String theExchangeID = "LSE   ";
			// Test Output
			/* Output of updateQuotesForBrexit when theExchangeID is LSE   .
			*
			*/
			int rowsConverted = app.updateQuotesForBrexit(theExchangeID);
			System.out.println("Number of quotes from '" + theExchangeID + "' converted due to Brexit: " + rowsConverted);
			


        // REWARD BEST BUYERS //

			// rewardBestBuyers call and variables
			int theSeller1 = 1456;
			int theCount1 = 2;
			int theCount2 = 4;
			// Test Output
			/*
			 * Output of rewardBestBuyers when theSellerID is 1456 and theCount is 2. 
			 * 7
			 */

			/*
			 * /* Output of rewardBestBuyers when theSellerID is 1456 and theCount is 4. 
			 * 8
			 */
			int rowsRewarded1 = app.rewardBestBuyers(theSeller1, theCount1);
			System.out.println(rowsRewarded1 + " trades updated that were sold by " + theSeller1 + " with theCount equal to "+ theCount1);
			int rowsRewarded2 = app.rewardBestBuyers(theSeller1, theCount2);
			System.out.println(rowsRewarded2 + " trades updated that were sold by " + theSeller1
					+ " with theCount equal to " + theCount2);

            /* Include your code below to test the methods of the StockMarketApplication class
             * The sample code in RunStoresApplication.java should be useful.
             * That code tests other methods for a different database schema.
             * Your code below: */
            


            
            /*******************
            * Your code ends here */
            
    	}
    	catch (SQLException | ClassNotFoundException e) {
    		System.out.println("Error while connecting to database: " + e);
    		e.printStackTrace();
    	}
    	finally {
    		if (connection != null) {
    			// Closing Connection
    			try {
					connection.close();
				} catch (SQLException e) {
					System.out.println("Failed to close connection: " + e);
					e.printStackTrace();
				}
    		}
    	}
    }
}
