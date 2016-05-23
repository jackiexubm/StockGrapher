import controlP5.*;

ControlP5 cp5;
PFont font, f, f2;

Button logIn;
Button register;
Textfield usr;
Textfield pass;

User x1;


void settings() {
  size(1400, 700);
}

void setup() {  
  font = createFont("arial",32);
  f = createFont("arial", 80);
  f2 = createFont("arial", 50);
  
  cp5 = new ControlP5(this);
  int y = 240;
  int spacing = 100;
  
  usr = new Textfield(cp5, "user");
   usr.setPosition(635,y)
       .setSize(300,42)
       .setFont(font)
       .setFocus(true)
       .setColorBackground(color(255,255,255))
       .setColor(color(0))
       ;
     y += 75;

pass = new Textfield(cp5, "pass");
  pass.setPosition(634,y)
       .setSize(300,42)
       .setFont(font)
       .setFocus(true)
       .setColorBackground(color(255,255,255))
       .setPasswordMode(true)
       .setColor(color(0))
       ;
     y += spacing;
     
    logIn = new Button(cp5, "Log In");
   logIn.setPosition(485,y)
       .setSize(300,35)
       .setFont(font)
       //.setColorBackground(color(255,255,255))
       .activateBy(ControlP5.RELEASE);
    
     register = new Button(cp5, "Register");   
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


String signIn() {
  if(register.isPressed()) {
    x1 = new User();
    x1.setUsername(usr.getText() );
    x1.setPassword(pass.getText() );
  }
}