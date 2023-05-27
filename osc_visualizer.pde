import oscP5.*;

OscP5 oscP5;

// declare variables for pulse amplitude, frequency, and color
float pulseAmp;
float pulseFreq;
int pulseColor;

// declare variables for circle position and size
float circleX;
float circleY;
float circleSize;
float circleMinSize;
float circleMaxSize;

// declare variables for circle color
int circleColor;

// declare variables for piano keyboard
PianoKeyboard pianoKeyboard;

void setup() {
  size(640, 480);
  frameRate(30);
  smooth();
  //noStroke();

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this, 8000);

  // initialize variables
  pulseAmp = 0;
  circleX = width/2;
  circleY = height/2;
  circleMinSize = 10;
  circleMaxSize = height/2-circleMinSize;
  circleSize = 0;
  circleColor = 0;

  pianoKeyboard = new PianoKeyboard("top", width, height, 10, 2, 5);

}

// draw a circle of circleMinSize at the center of the screen
// which grows and shrinks in size based on the value of pulseAmp
// and changes color  between blue and red based on the value of pulseAmp
void draw() {
  background(255);
  
  // calculate the size of the circle based on pulseAmp
  circleSize = map(pulseAmp, 0, 1, circleMinSize, circleMaxSize);
  
  // calculate the color of the circle based on pulseAmp
  circleColor = (int)map(pulseAmp, 0, 1, 0, 255);

  // draw the piano keyboard
  pianoKeyboard.render();    

  // draw the circle
  fill(circleColor, 0, 255-circleColor);
  ellipse(circleX, circleY, circleSize, circleSize);
  pulseAmp = 0.0;
}

// oscEvent is called whenever a message is received
void oscEvent(OscMessage msg) {
  // check if theOscMessage has an address pattern we are looking for
  if(msg.checkAddrPattern("/kick_amp")) {
    // parse theOscMessage and extract the values from the osc message arguments
    pulseAmp = msg.get(0).floatValue();
  }

  if (msg.checkAddrPattern("/note")) {
    int note = msg.get(0).intValue();
    pianoKeyboard.resetKeys();
    pianoKeyboard.setKeyPressed(note, true);
  }
}