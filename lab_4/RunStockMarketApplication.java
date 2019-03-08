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
			Integer StocksSold = 4;
			List<Integer> custIds = new ArrayList<Integer>();
			custIds = app.getCustomersWhoSoldManyStocks(StocksSold);
			if(custIds.isEmpty()){
				System.out.println("Nobody sold that many stocks.");
			}
			for(int id : custIds){
				System.out.println(id);
			} 
			app.updateQuotesForBrexit("NYSE");

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
