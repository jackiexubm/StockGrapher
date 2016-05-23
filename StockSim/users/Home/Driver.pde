/*

import java.util.*;
import java.io.*;

public class Driver{

    //PrintWriter writer = new PrintWriter("accounts.csv", "UTF-8");
    //writer.println("The first line");
    //writer.println("The second line");
    public static Scanner sc = new Scanner(System.in);
    public static String[] userArray;
    public static String fileName = "accounts.csv";
    public static File f = new File(fileName);

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
  System.out.println(username);
  
  System.out.print("Enter a password: ");
  String password = sc.next();
  System.out.println(password);

  User a = new User(username, password);
  System.out.println(a.toString());
  
  try{      
      FileWriter fw = new FileWriter(fileName, true);
      fw.append(a.toString());
      BufferedWriter bw = new BufferedWriter(fw);
      //PrintWriter pw = new PrintWriter(bw); 
      //pw.println(a.toString());
      bw.append(a.toString());
      //bw.append(username+','+password + "/n");
      System.out.println("DONE");
      //fw.flush();
      //fw.close();
      bw.close();
  } catch (IOException e) {
      System.out.println( "IOException!!!!");
  }
    }
    
    public static void signIn() {
        String line = null;
  
        try {
            FileReader fR = new FileReader(f); 
      BufferedReader bR =  new BufferedReader(fR);
      //line = bR.readLine();
      //System.out.println(line);
      
      System.out.println("Enter your username: ");
      String usr = sc.next();

      //      if (bR.readLine() == null) {
      //System.out.println("NO users exist. SIGN UP!");
      //signUp();
      //} else { 
    while ((line = bR.readLine()) != null) {
    //while (line != null) {
        userArray = line.split(",");
        if (userArray.length <1) { 
      System.out.println("NO users exist! SIGN UP!");
      signUp();
        }
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
        }
    }
   
}

*/