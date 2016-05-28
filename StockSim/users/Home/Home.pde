import controlP5.*;

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
BufferedReader reader;
String line;

void settings() {
  size(1200, 700);
}

void setup() {  
  font = createFont("arial", 32);
  f = createFont("arial", 80);
  f2 = createFont("arial", 50);

  reader = createReader("accounts.csv"); 

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

    signIn(usr.getText(), pass.getText());
    logInPressed = false;
  }

  if (registerPressed && register.isPressed() ) {
    //text(usr.getText(), 100, 100);
    //text(pass.getText(),150,150);
    if (usr.getText().length() < 1) text("Username is not long enough", 350, 600);
    else if (pass.getText().length() < 6) text("Password is not long enough", 350, 600);
    else {
      x2 = new User(usr.getText(), pass.getText());
      System.out.println(x2.toString());

      registerPressed = false;
    }
  }
}


void signIn(String user, String pass) {
  try {
    line = reader.readLine();
    String[] logArray = new String[2];
    logArray = line.split(",");
    if (usr.getText().equals(logArray[0])) loggedIn = true;
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    noLoop();
  } else {
    //String[] pieces = split(line, TAB);
    //int x = int(pieces[0]);
    //int y = int(pieces[1]);
    //point(x, y);
  }
}