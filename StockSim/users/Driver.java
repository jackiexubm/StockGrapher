import java.util.*;

public class Driver{

    //PrintWriter writer = new PrintWriter("accounts.csv", "UTF-8");
    //writer.println("The first line");
    //writer.println("The second line");
    public static Scanner sc = new Scanner(System.in);
    
    public static void main(String[] args) {
	hasAccount();
    }    

    public static void hasAccount(){
	System.out.print("Do you have an account? (yes/no)");
	if (sc.next().equalsIgnoreCase("no")) {
	    signUp();
	} else if (sc.next().equalsIgnoreCase("yes")) {
	    signIn();
	} 
	
    }
    
    public static void signUp() {
	System.out.print("Enter a username:");
	String username = sc.next();
	
	System.out.print("Enter a password:");
	String password = sc.next();
	
	User a = new User(username, password);
    }
    
    public static void signIn() {
	System.out.print("Enter your username:");
	String usr = sc.next();
	
	
    }
    
    //writer.close();

}