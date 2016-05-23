class User{
    public String username;
    public String password;

void setup() {
   this.username= "";
   this.password= "";
}
public User(String usrname, String passwrd) {
  this.username = usrname;
  this.password = passwrd;
    }
    
public String toString() {
  return (username+ ',' + password+ '\n');
    }
}