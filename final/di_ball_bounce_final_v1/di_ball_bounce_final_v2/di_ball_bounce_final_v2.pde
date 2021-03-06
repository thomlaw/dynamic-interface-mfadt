import oscP5.*;
import netP5.*;

int x = 0; //varibale x at global scope
int y = 0;
int foo = 0; //varibale x at global scope
int bar = 0;
int ball1 = 0; //varibale x at global scope
int ball2 = 0;


int xSpeed = 6;
int ySpeed = 5;
int xSpeed1 = 8;
int ySpeed2 = 9;
int xSpeed3 = 10;
int ySpeed4 = 12;

int ballWidth = 25;
int ballHeight = 25;

int realWidth;

OscP5 myOscP5;
NetAddress myRemoteLocation;

void setup() {
  size(500,200);
  smooth();
  noStroke();
  frameRate(30);
  ellipseMode(LEFT);//draw the circle on the left
  
  myOscP5 = new OscP5(this,30000); //sends messagses out, this is the sketch, 30000 is the port
  myRemoteLocation = new NetAddress("127.0.0.1", 30001);
  
  realWidth = width *2;
}
void draw(){
  x = xSpeed + x; //6 + 0 = 6, x = 6
  y = ySpeed + y;
  foo = xSpeed1 + foo;
  bar = ySpeed2 + bar;
  ball1 = xSpeed3 + ball1;
  ball2 = ySpeed4 + ball2;


//ball 1  
  if(y+ballHeight>height) ySpeed = ySpeed * -1;
  else if (y < 0) ySpeed *= -1;
  
  if(x>realWidth) x = x-realWidth;
  else if(x+realWidth <0) x = x+realWidth;

//ball 2 
  if(bar+ballHeight>height) ySpeed2 = ySpeed2 * -1;
  else if (bar < 0) ySpeed2 *= -1;
  
  if(foo>realWidth) foo = foo-realWidth;
  else if(foo+realWidth <0) foo = foo+realWidth;
  
//ball 3 
  if(ball2+ballHeight>height) ySpeed4 = ySpeed4 * -1;
  else if (ball2 < 0) ySpeed4 *= -1;
  
  if(ball1>realWidth) ball1 = ball1-realWidth;
  else if(ball1+realWidth <0) ball1 = ball1+realWidth;
  
  
  background(0);
  fill(0,255,255);
  ellipse(x,y,ballWidth,ballHeight);
  
  fill(0,255,0);
  ellipse(foo,bar,ballWidth,ballHeight);
  
  fill(255,0,255);
  ellipse(ball1,ball2,ballWidth,ballHeight);
  
  OscMessage message = new OscMessage("/update");
  message.add(x);
  message.add(y);
  message.add(foo);
  message.add(bar);
  message.add(ball1);
  message.add(ball2);
  
  myOscP5.send(message,myRemoteLocation);
}

void keyPressed(){
 
}

//add many, 20 bouncing at different speeds, switch number to 25 later  
