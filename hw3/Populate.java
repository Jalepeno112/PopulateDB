/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.*;
import org.json.simple.*;
import java.io.*;
import java.util.Scanner;
import java.util.Arrays;


import oracle.jdbc.OracleDriver;

/**
 *
 * @author giovannib
 */
public class Populate {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
      System.out.println("Hello world");
      Populate pop = new Populate();
      pop.run(args);

    }


   public void run(String [] args) {
     for (int i = 0; i < args.length; i++) {
       System.out.println(i + ": " + args[i]);


       // try and open a file and read the data
       // if we can succesfully open the file, then we will remove all entries from the current table
       //    DELETE FROM <table_name>
       // then we will insert new data
       //    INSERT INTO <table_name> VALUES(<array of values>)

		Connection con = null;

		try {
			System.out.println("Opening connection");
			con = openConnection();
		} catch (ClassNotFoundException e) {
			System.err.println("Cannot find the database driver");
		} catch(Throwable any) {
			System.err.println("ERROR: "+any);
			System.exit(1);
		}
		// for each line in the file, we want to make an entry into our database
		// we need to split the line into the components, construct the Insert statements, and then insert

		try {

			System.out.println("Writing data to table");
			writeToTable(con, args[i]);

		} catch (SQLException e) {
			System.err.println("Errors occurs when communicating with the database server: " + e.getMessage());
			e.printStackTrace();
		} catch (Throwable any) {
			System.out.println("Java ERROR: "+any);
			any.printStackTrace();
		}finally {
			// Never forget to close database connection
			closeConnection(con);
		}
     }

   }

	private void writeToTable(Connection con, String filename) throws SQLException{
		// declare scanner
		/*Scanner s = null;

		try {
			s = new Scanner(new File(filename));
		}catch(FileNotFoundException fnfe) {
		   System.out.println("ERROR: " + fnfe.getMessage());
		}*/
		try {
			FileInputStream fis = new FileInputStream(filename);
			BufferedReader s = new BufferedReader(new InputStreamReader(fis));


			String table_name = filename.substring(0, filename.lastIndexOf('.'));
			table_name = table_name.substring(table_name.lastIndexOf("/")+1).replace("-","_");

			System.out.println("TABLE NAME: " + table_name);

			Statement stmt = con.createStatement();
			// remove values from table
			stmt.executeUpdate("DELETE FROM " + table_name);

			// consume the first line since it's just the header info
			/*if(s.hasNextLine()) {
				s.nextLine();
			}*/

			String line = s.readLine();
			line = s.readLine();
			while (line != null) {
			   //System.out.println("LINE: " + line);
			   String [] split = line.split("\t", 0);
			   //System.out.println("SPLIT: " + Arrays.toString(split));
			    for(int x = 0; x < split.length; x++) {
				//System.out.println("Checking for isNumeric: " + split[x]);
				if (split[x].equals("\\N")) {
					split[x] = null;
				}
				else if(!isNumeric(split[x])){
						split[x] = split[x].replace("'", "''");
						split[x] = "'" + split[x] + "'";
				}
			    }
			    String values = String.join(",", split);

			    String inst = "INSERT INTO " + table_name + " VALUES("+values+")";

			    System.out.println("Making statement: " + inst);

			    stmt.executeUpdate(inst);
			    line = s.readLine();
			}
			//System.out.println("has next line: " + s.hasNextLine());
			stmt.close();
			s.close();
		} catch (FileNotFoundException ex) {
			System.err.println("File not found");
		} catch (IOException ex) {
			System.err.println("IO Exception");
		}
	}


	public boolean isNumeric(String s) {
	    return s.matches("[-+]?\\d*\\.?\\d+");
	}

	/**
	*
	* @return a database connection
	* @throws SQLException when there is an error when trying to connect database
	* @throws ClassNotFoundException when the database driver is not found.
	*/
	private Connection openConnection() throws SQLException, ClassNotFoundException {
		// Load the Oracle database driver
		System.out.println("openConnection");
		System.out.println("Registering Driver");

		//System.out.println(oracle.jdbc.OracleDriver);

		DriverManager.registerDriver(new oracle.jdbc.OracleDriver());

		/*
		Here is the information needed when connecting to a database
		server. These values are now hard-coded in the program. In
		general, they should be stored in some configuration file and
		read at run time.
		*/
		String host = "localhost";
		String port = "1521";
		String dbName = "orcl";
		String userName = "SYSTEM";
		String password = "admin";
    // https://localhost:1158/em

		// Construct the JDBC URL
		String dbURL = "jdbc:oracle:thin:@" + host + ":" + port + ":" + dbName;

		System.out.println("Attempting connection!");
		return DriverManager.getConnection(dbURL, userName, password);
	}

	/**
	* Close the database connection
	* @param con
	*/
	private void closeConnection(Connection con) {
		try {
		   con.close();
		} catch (SQLException e) {
		   System.err.println("Cannot close connection: " + e.getMessage());
		}
	}
}
