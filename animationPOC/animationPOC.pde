// spi-osc-processing POC sketch
// GH

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemotelocation;
//declare variables
int[] clr = new int[3];
float rad;
int n;

void setup() {
  size(400,400);
  frameRate(30);
  oscP5 = new OscP5(this,8000); //set up osc connection, localhost port 8000
}

void draw() {
  smooth();
  background(0);
  //set fill color and draw ellipse
  fill(clr[0], clr[1], clr[2]);
  ellipse(200, 388-n, rad, rad);
}

void oscEvent(OscMessage theOscMessage){
  
  if (theOscMessage.checkAddrPattern("/n")==true)
  {
    n = theOscMessage.get(0).intValue();
  }
  if (theOscMessage.checkAddrPattern("/clr")==true)
  {
    clr[0]= theOscMessage.get(0).intValue();
    clr[1]= theOscMessage.get(1).intValue();
    clr[2]= theOscMessage.get(2).intValue();
  }
  if (theOscMessage.checkAddrPattern("/rad")==true)
  {
    rad= theOscMessage.get(0).floatValue();
  }
}
  
