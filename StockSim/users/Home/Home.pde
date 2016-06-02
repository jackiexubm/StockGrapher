import controlP5.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.*;

ControlP5 cp5;
PFont font, f, f2;

Button logIn;
Button register;
Textfield usr;
Textfield pass;

boolean logInPressed = true;
boolean registerPressed = true;
boolean loggedIn = false;

User x1;
User x2;

FileWriter writer;
BufferedWriter writer2;
BufferedReader reader;
String line;

PrintWriter output;
String fileName = "accounts.csv";

void settings() {
  size(1200, 700);
}

void setup() {  
  try {
    FileWriter writer = new FileWriter(fileName, true); 
    writer2 = new BufferedWriter(writer);
  }
  catch(IOException e) {
    System.out.println("It Broke");
    e.printStackTrace();
  }

  //output = createWriter("data/accounts2.csv"); 
  reader = createReader(fileName); 

  font = createFont("arial", 32);
  f = createFont("arial", 80);
  f2 = createFont("arial", 50);

  cp5 = new ControlP5(this);
  int y = 200;
  int spacing = 100;

  usr = new Textfield(cp5, "user");
  usr.setPosition(575, y)
    .setSize(300, 42)
    .setFont(font)
    .setFocus(true)
    .setColorBackground(color(255, 255, 255))
    .setColor(color(0))
    ;
  y += 75;

  pass = new Textfield(cp5, "pass");
  pass.setPosition(575, y)
    .setSize(300, 42)
    .setFont(font)
    .setFocus(true)
    .setColorBackground(color(255, 255, 255))
    .setPasswordMode(true)
    .setColor(color(0))
    ;
  y += spacing;

  logIn = new Button(cp5, "Log In");
  logIn.setPosition(450, y)
    .setSize(300, 40)
    .setFont(font)
    //.setColorBackground(color(255,255,255))
    .activateBy(ControlP5.RELEASE);

  register = new Button(cp5, "Register");   
  register.setPosition(450, y+56)
    .setSize(300, 40)
    .setFont(font)
    //.setColorBackground(color(255,255,255))
    .activateBy(ControlP5.RELEASE);

  textFont(font);
}
void draw() {
  surface.setTitle(round(frameRate) + " fps");
  background(256, 256, 256);
  textFont(f);
  fill(0);
  text("STOCK SIMULATOR", 222, 150);

  textFont(f2);
  text("Username:", 309, 237);
  text("Password:", 320, 313);  

  if (logInPressed &&logIn.isPressed() ) {
    //text(usr.getText(), 100, 100);
    //text(pass.getText(),150,150);
    //x1 = new User(usr.getText(), pass.getText());
    //System.out.println(x1.toString());

    if (usr.getText().length() < 1) text("Username is not long enough", 350, 350);
    else {

      signIn(usr.getText(), pass.getText());
      logInPressed = false;
    }
  }

  if (registerPressed && register.isPressed() ) {

    //text(usr.getText(), 100, 100);
    //text(pass.getText(),150,150);
    if (usr.getText().length() < 1) text("Username is not long enough", 350, 600);
    else if (pass.getText().length() < 6) text("Password is not long enough", 350, 600);
    else {
      //x2 = new User(usr.getText(), pass.getText());
      //System.out.println(x2.toString());
      register(usr.getText(), pass.getText());

      registerPressed = false;
    }
  }
}

boolean signIn(String user, String pass) {
  try {
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    noLoop();
  } else {
    String[] info = split(line, ",");

    String fileUser = info[0];
    System.out.println(info[0]);

    String filePass = info[1];
    System.out.println(info[1]);


    if ( user.equals(fileUser)) {
      if (pass.equals(filePass)) {
        System.out.println("LOGGED IN");
        return true;
      } 
      System.out.println("ERROR: Password does not match");
    }
    System.out.println("ERROR: Username does not match");
  }
  return false;
}

void register(String user, String pass) {
  x2 = new User(user, pass);
  System.out.println(x2.toString());
  System.out.println("Bout to try");

  try {
    writer2.write(x2.toString());
    System.out.println(x2.toString());

    writer2.flush();
    writer2.close();
    System.out.println("DONE");
  }
  catch(IOException e) {
    println("It Broke");
    e.printStackTrace();
  }
  // output.print(x2.toString() );
  //output.flush();
  //output.close();

  System.out.println("DONE");
}