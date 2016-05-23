import controlP5.*;

ControlP5 cp5;
PFont font, f, f2;

Button logIn; 
Button register;

Textfield usr;
Textfield pass; 

void settings() {
  size(1400, 700);
}

void setup() {  
  font = createFont("arial",32);
  f = createFont("arial", 80);
  f2 = createFont("arial", 50);
  
Button logIn = new Button(cp5, "Log In");
Button register = new Button(cp5, "Register");
Textfield usr = new Textfield(cp5, "user");
Textfield pass = new Textfield(cp5, "pass");

  
  cp5 = new ControlP5(this);
  int y = 240;
  int spacing = 100;
  
    usr.setPosition(635,y)
       .setSize(300,42)
       .setFont(font)
       .setFocus(true)
       .setColorBackground(color(255,255,255))
       .setColor(color(0))
       ;
     y += 75;
     
     pass.setPosition(635,y)
       .setSize(300,42)
       .setFont(font)
       .setFocus(true)
       .setColorBackground(color(255,255,255))
       .setPasswordMode(true)
       .setColor(color(0))
       ;
     y += spacing;
     
     
     logIn.setPosition(485,y)
       .setSize(300,35)
       .setFont(font)
       //.setColorBackground(color(255,255,255))
       .activateBy(ControlP5.RELEASE);
       
     register.setPosition(485,y+50)
       .setSize(300,35)
       .setFont(font)
       //.setColorBackground(color(255,255,255))
       .activateBy(ControlP5.RELEASE);
 
 textFont(font); 
}
 void draw() {
   background(256, 256, 256);
   textFont(f);
   fill(0);
   text("STOCK SIMULATOR", 265, 150);

textFont(f2);
text("Username:", 375, 275);
text("Password:", 387, 351);  

 }
String username;
String password;

void signIn() {
  if(logIn.isPressed()) {
    username = usr.getText();
    password = pass.getText();
    User x1 = new User(username, password);
    print(x1.username + "  " + x1.password);
  }
}