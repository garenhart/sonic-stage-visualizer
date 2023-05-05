// spi-osc-processing sketch
// GH
import oscP5.*;

OscP5 oscP5;

int[] clr = new int[3];
float rad;
float kickAmp;

// Which number are we using
float size = 50;
float beatSize = 50;

void setup() {
  size(300, 300);
  //stroke(max-10);
  frameRate(30);
  oscP5 = new OscP5(this,8000); //set up osc connection, localhost port 8000
}

void draw() {
  // Every frame we access one element of the array
  background(size);
  translate(width/2, height/2);
  beatSize = size + size*kickAmp; // increase the size based on the beat amplitude.
  ellipse(0, 0, beatSize, beatSize);
  kickAmp = 0.0;
}

void oscEvent(OscMessage msg) {
  
  if (msg.checkAddrPattern("/kick_amp")==true) 
  {
    kickAmp = msg.get(0).floatValue();
  } 
}
