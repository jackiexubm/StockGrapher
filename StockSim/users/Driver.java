import java.util.*;
import java.io.*;

public class Driver{

    //PrintWriter writer = new PrintWriter("accounts.csv", "UTF-8");
    //writer.println("The first line");
    //writer.println("The second line");
    public static Scanner sc = new Scanner(System.in);
    public static String[] userArray;
    public static void main(String[] args) {
	hasAccount();
    }    

    public static void hasAccount(){
	System.out.println("Do you have an account? (yes/no)");
	String yesNo = sc.next();
	if (yesNo.equalsIgnoreCase("no")) {
	    signUp();
	} else if (yesNo.equalsIgnoreCase("yes")) {
	    signIn();
	} 	
    }
    
    public static void signUp() {
	System.out.print("Enter a username: ");
	String username = sc.next();
	
	System.out.print("Enter a password: ");
	String password = sc.next();
	
	User a = new User(username, password);
    }

    public static void signIn() {
        String fileName = "accounts.csv";
        String line = null;

        try {
            FileReader fileReader = new FileReader(fileName); 
	    BufferedReader bR =  new BufferedReader(fileReader);
	    
	    System.out.println("Enter your username: ");
	    String usr = sc.next();

            while ((line = bR.readLine()) != null) {
		//line = bR.readLine();
		userArray = line.split(",");
		if (userArray[0].equals(usr) ) {
		    System.out.println("Enter your password: ");
		    String pass = sc.next();	
		    if (userArray[1].equals(pass) ) { 
			System.out.println("WELCOME TO THE STOCK SIMULATOR");
		    } else {
			System.out.println("Password does NOT match");
			    }
		} else {
		    System.out.println("Username does NOT exist");
			}
            }   
            bR.close();         
        }
        catch(FileNotFoundException ex) {
            System.out.println("Unable to open file '" + fileName + "'");                
        }
        catch(IOException ex) {
            System.out.println("Error reading file '" + fileName + "'");                  
            // Or we could just do this: 
            // ex.printStackTrace();
        }
    }

}