public class Driver{

    //PrintWriter writer = new PrintWriter("accounts.csv", "UTF-8");
    //writer.println("The first line");
    //writer.println("The second line");
    Scanner sc = new Scanner(System.in);
    
    public static void main(String[] args) {
	hasAccount();
    }    

    /*    public void hasAccount(){
	System.out.println("Do you have an account? (yes/no)");
	if (sc.nextLine().equalsIgnoreCase("no")) {
	    signUp();
	} else if (sc.nextLine().equalsIgnoreCase("yes")) {
	    signIn();
	} 

    }

    public void signUp() {
	System.out.print("Enter a username:");
	String username = sc.next();
	
	System.out.print("Enter a password:");
	String password = encrypt( sc.next());

	User a = new User(username, password);
    }

    public void signIn() {
	System.out.print("Enter your username:");
	String usr = sc.next();

	
    }
    */
    //writer.close();

}