import oscP5.*;
import netP5.*;

int xBall=50; //ball size
int yBall=50;
 
int xPosA=25;//ball position
int yPosA=25;
int xPosB=475;
int yPosB=25;
 
int xVelA=2;//velocity
int yVelA=5;
int xVelB=5;
int yVelB=3;

OscP5 myOscP5;
NetAddress myRemoteLocation;

void setup() {
  size(500, 200);
  smooth();
  noStroke();
  frameRate(30);
  ellipseMode(LEFT);//draw the circle on the left
  
  myOscP5 = new OscP5(this,30001); //sends messagses out, this is the sketch, 30000 is the port
  myRemoteLocation = new NetAddress("127.0.0.1", 30000);
}
void draw(){
  
  background(0);
  
  pushMatrix();{
    translate(-width,0);
     ellipse(xPosA,yPosA,xBall,yBall);
     fill(255,0,200);
  }popMatrix();
  
  pushMatrix();{
    translate(-width,0);
    ellipse(xPosB,yPosB,xBall,yBall);
    fill(140, 255, 0);
  }popMatrix();
  
}
  
void oscEvent(OscMessage message){ 
    xBall = message.get(0).intValue();
    yBall = message.get(1).intValue();
    xPosA = message.get(2).intValue();
    yPosA = message.get(3).intValue();
    xPosB = message.get(4).intValue();
    yPosB = message.get(5).intValue();

}


