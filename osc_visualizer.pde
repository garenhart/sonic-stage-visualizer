import oscP5.*;

OscP5 oscP5;

ArrayList <ParticleController> pcs = new ArrayList <ParticleController>();

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

PImage imgDrum;

// declare variables for piano keyboard
PianoKeyboard pianoKeyboard;

void setup() {
  size(1800, 900);
  //fullScreen();
  frameRate(30);
  smooth();
  //noStroke();

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this, 8000);

  pianoKeyboard = new PianoKeyboard("top", width, height, 10, 2, 5);

  //imgDrum = loadImage("comic-jazz-drum-800.png");
  imgDrum = loadImage("black-blue-yellow-drum.png");

  imgDrum.loadPixels();


  // initialize variables
  pulseAmp = 0;
  circleX = width/2;
  circleY = height/2 + pianoKeyboard.height/2;
  circleMinSize = 10;
  circleMaxSize = height/2-circleMinSize;
  circleSize = 0;
  circleColor = 0;
}

// draw a circle of circleMinSize at the center of the screen
// which grows and shrinks in size based on the value of pulseAmp
// and changes color  between blue and red based on the value of pulseAmp
void draw() {
  background(100);
  
  // calculate the size of the circle based on pulseAmp
  circleSize = map(pulseAmp, 0, 1, circleMinSize, circleMaxSize);
  
  // calculate the color of the circle based on pulseAmp
  circleColor = (int)map(pulseAmp, 0, 1, 0, 255);

  // draw the piano keyboard
  pianoKeyboard.render();    

  // draw the image in the middle of the screen
  // image(imgDrum, width/2-imgDrum.width/2, height/2-imgDrum.height/2);

  pushMatrix();
  translate(width/2-imgDrum.width/2, height/2+pianoKeyboard.height-imgDrum.height/2);
  // draw the image in the middle of the screen below the piano keyboard
  image (imgDrum, 0, 0);

  for (ParticleController current : pcs) {
      current.update(imgDrum, 100); // second parameter specifies the distance particles can travel before being removed
      current.render(imgDrum);
  }
  popMatrix();

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

void mouseClicked() {
    ParticleController pCont = new ParticleController();
    
    translate(width/2-imgDrum.width/2, height/2+pianoKeyboard.height-imgDrum.height/2);
    pCont.createParticles(mouseX-(width/2-imgDrum.width/2), mouseY-(height/2+pianoKeyboard.height-imgDrum.height/2), 50);
    // Add new controller to the array
    pcs.add(pCont);
}


void keyPressed() {
    if (key == 'q') {
        for (ParticleController current : pcs) {
            int numbers = current.ar.size();
            println(numbers);
        }
    }
}