import java.io.*;
import java.util.*;

public class SignUp{
    /*
     * To change this template, choose Tools | Templates
     * and open the template in the editor.
     */
    package commandssvn;
 
//    public static void main(String[] args) throws IOException {
//	generateCsvFile();
//	run();
        
    //   }
    public static void run() {
		        
	BufferedReader br = null;
	String line = "";
	String cvsSplitBy = ",";
	
	try {
	    br = new BufferedReader(new FileReader(csvFile));
	    
	    
	    boolean firstTime=false;
	    int i=0;
	    while ((line = br.readLine()) != null) {
		firstTime=false;
                
		arrayStrings[i] = line.split(cvsSplitBy);
                
		i++;
		if(i==4)
		    {
			i=0;
			generateCsvFile(arrayStrings);
		    }
		
	    }
	} catch (FileNotFoundException e) {
	    e.printStackTrace();
	} catch (IOException e) {
	    e.printStackTrace();
	} finally {
	    if (br != null) {
		try {
		    br.close();
		} catch (IOException e) {
		    e.printStackTrace();
		}
	    }
	}
	
        
    }
      
    private static void generateCsvFile()
    {
	try
	    {
		FileWriter writer = new FileWriter("accounts.csv",false);
		writer.append('\n');
		
		writer.flush();
		writer.close();
	    }
	catch(IOException e)
	    {
		e.printStackTrace();
	    }
    }
    
    
    private static void fileWrite(String usr) {
	try
	    {
		FileWriter writer = new FileWriter("accounts.csv");
		writer.append(usr+',');
		writer.append();
		writer.append('\n');
		
		//generate whatever data you want
		
		writer.flush();
		writer.close();
	    }
	
	catch(IOException e) {
	    e.printStackTrace();
	}
	
    }
}

    public String encrypt(String password) {
        String hash = "";
        try {
            MessageDigest md5 = MessageDigest.getInstance("SHA-512");
            byte [] digest = md5.digest(password.getBytes("UTF-8"));
            hash = Arrays.toString(digest);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return hash;
    }

}