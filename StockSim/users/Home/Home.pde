import controlP5.*;
import java.io.*;

ControlP5 cp5;
PFont font, f, f2;
Button logIn, register;
Textfield usr, pass;
User x1, x2;

boolean logInPressed = true;
boolean registerPressed = true;
boolean loggedIn = false;
String [] file;
String[] info;

PrintWriter writer;
BufferedReader reader;
String line;
PrintWriter output;
String fileName = "accounts.txt";

void settings() {
  size(1200, 700);
}
//-----------------------------------------------------------SETUP----------------------
void setup() {  
  reader = createReader(fileName); 

  font = createFont("arial", 32);
  f = createFont("arial", 80);
  f2 = createFont("arial", 50);

  cp5 = new ControlP5(this);
  int y = 200;
  int spacing = 100;

  usr = new Textfield(cp5, "user");
  usr.setPosition(575, y).setSize(300, 42).setFont(font).setFocus(true)
    .setColorBackground(color(255, 255, 255)).setColor(color(0));
  y += 75;

  pass = new Textfield(cp5, "pass");
  pass.setPosition(575, y).setSize(300, 42).setFont(font).setFocus(true)
    .setColorBackground(color(255, 255, 255)).setPasswordMode(true).setColor(color(0));
  y += spacing;

  logIn = new Button(cp5, "Log In");
  logIn.setPosition(450, y).setSize(300, 40).setFont(font)
    //.setColorBackground(color(255,255,255))
    .activateBy(ControlP5.RELEASE);

  register = new Button(cp5, "Register");   
  register.setPosition(450, y+56).setSize(300, 40).setFont(font)
    //.setColorBackground(color(255,255,255))
    .activateBy(ControlP5.RELEASE);
  textFont(font);
}
//-------------------------------------------------------------DRAW----------------------
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
    if (usr.getText().length() < 1) text("Username is not long enough", 350, 350);
    else {
      load(usr.getText(), pass.getText());
      logInPressed = false;
    }
  }

  if (registerPressed && register.isPressed() ) {
    if (usr.getText().length() < 1) text("Username is not long enough", 350, 600);
    else if (pass.getText().length() < 6) text("Password is not long enough", 350, 600);
    else {
      register(usr.getText(), pass.getText());
      registerPressed = false;
    }
  }
}

boolean signIn(String user, String pass, String[] line) {

  if (line[0].equals(user)) {
    if (line[1].equals(pass)) {
      println("LOGGED IN");
      return true;
    } 
    println("Password does NOT match");
  }
  println("Username does NOT match");
  return false;
}

int load(String user, String pass) {
  info = loadStrings("accounts.txt");
  String[] line;
  //println(info[0]);

  for (int i = 0; i < info.length; i++) {
    line = info[i].split(",");
    if (signIn(user, pass, line)) {
      return i;
    }
  }
  return (-1);
}

void register(String user, String pass) {
  info = loadStrings("accounts.txt");
  String[] info2 = new String[(info.length)+1];
  x2 = new User(user, pass);

  for (int i = 0; i < info.length; i++) {
    info2[i] = info[i];
    info2[info2.length-1] = x2.toString();
  }
  rewrite(info, info2);
  System.out.println("DONE");
}

void rewrite(String[] info, String[] info2) {
  writer = createWriter("data/accounts.txt");
  for (int x = 0; x<info2.length; x++) {
    writer.println(info2[x]);
  }
  writer.flush();
  writer.close();
}