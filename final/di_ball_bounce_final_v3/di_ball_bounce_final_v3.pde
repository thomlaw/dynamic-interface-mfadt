import oscP5.*;
import netP5.*;

int xBall=50; //ball size
int yBall=50;
 
int xPosA=25;//ball position
int yPosA=25;
int xPosB=300;
int yPosB=30; 

int xVelA=2;//velocity
int yVelA=5;
int xVelB=5;
int yVelB=3;

int realWidth;

OscP5 myOscP5;
NetAddress myRemoteLocation;

void setup() {
  size(500, 200);
  smooth();
  noStroke();
  frameRate(80);
  ellipseMode(LEFT);//draw the circle on the left
  myOscP5 = new OscP5(this,30000); //sends messagses out, this is the sketch, 30000 is the port
  myRemoteLocation = new NetAddress("127.0.0.1", 30001);
  
  realWidth = width *2;
}
void draw(){
  background(0);
  noStroke();
  //BallA
  fill(140, 255, 0);
  ellipse(xPosA,yPosA,xBall,yBall);
  //BallB
  fill(255,0,200);
  ellipse(xPosB,yPosB,xBall,yBall);
 
  xPosA=xPosA+xVelA;
  yPosA=yPosA+yVelA;
   
  xPosB=xPosB+xVelB;
  yPosB=yPosB+yVelB;    
  
  if (xPosA>realWidth-xBall/2||xPosA<xBall/2) { //reverse ball direction
    xVelA=xVelA*-1;
  }
  if (yPosA>height-xBall/2||yPosA<xBall/2) {
    yVelA=yVelA*-1;
  }
  if (xPosB>realWidth-xBall/2||xPosB<xBall/2) {
    xVelB=xVelB*-1;
  }
  if (yPosB>height-xBall/2||yPosB<xBall/2) {
    yVelB=yVelB*-1;
  }
  
  if (dist(xPosA,yPosA,xPosB,yPosB)<=xBall){ //ball colliding
    xVelA=xVelA-2*xVelA;
    yVelA=yVelA-2*yVelA;
    xVelB=xVelB-2*xVelB;
    yVelB=yVelB-2*yVelB;
  }
  
  OscMessage message = new OscMessage("/update");
  message.add(xBall);
  message.add(yBall);
  message.add(xPosA);
  message.add(yPosA);
  message.add(xPosB);
  message.add(yPosB);
  
  myOscP5.send(message,myRemoteLocation);
}


