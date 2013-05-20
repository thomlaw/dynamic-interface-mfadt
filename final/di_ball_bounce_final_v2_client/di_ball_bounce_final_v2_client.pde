import oscP5.*;
import netP5.*;

int x = 0; //varibale x at global scope
int y = 0;
int foo = 0; //varibale x at global scope
int bar = 0;
int ball1 = 0; //varibale x at global scope
int ball2 = 0;

int ballWidth = 25;
int ballHeight = 25;

OscP5 myOscP5;
NetAddress myRemoteLocation;

void setup() {
  size(500,200);
  smooth();
  noStroke();
  frameRate(30);
  ellipseMode(LEFT);//draw the circle on the left
  
  myOscP5 = new OscP5(this,30001); //sends messagses out, this is the sketch, 30000 is the port
  myRemoteLocation = new NetAddress("127.0.0.1", 30000);
}
void draw(){
  
  background(0);
  //fill(0,255,0);

  
  pushMatrix();{
    translate(-width,0);
     ellipse(x,y,ballWidth,ballHeight);
     fill(0,255,0);
  }popMatrix();
  
  pushMatrix();{
    translate(-width,0);
    ellipse(foo,bar,ballWidth,ballHeight);
    fill(255,0,255);
  }popMatrix();
  
  pushMatrix();{
    translate(-width,0);
    ellipse(ball1,ball2,ballWidth,ballHeight);
    fill(0,255,255);
  }popMatrix();
    fill(0,255,255);fill(0,255,255);
}
  


void oscEvent(OscMessage message){ //automatically called when osc messgaed is called on that port
//  if(message.checkAddrPattern("/update") == true){
    x = message.get(0).intValue();
    y = message.get(1).intValue();
    foo = message.get(2).intValue();
    bar = message.get(3).intValue();
    ball1 = message.get(4).intValue();
    ball2 = message.get(5).intValue();
//  }
}


