import oscP5.*;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

OscP5 oscP5;

// Using List interface (instead of the original ArrayList class) and instantiating CopyOnWriteArrayList class
//  avoids "Concurrent Modification Exception" when running many instances 
List <ParticleController> pcs = new CopyOnWriteArrayList <ParticleController>();

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

int bkColor = 100;

// declare variables for circle color
int circleColor;

PImage imgDrum;

// top-left position and scale of the drum image, fit into the band between the two keyboards
float imgX;
float imgY;
float imgScale;

// declare variables for piano keyboards
// topKeyboard (top) handles bass keys, bottomKeyboard (bottom) handles solo/chord keys
PianoKeyboard topKeyboard;
PianoKeyboard bottomKeyboard;

void setup() {
  //size(1200, 600);
  //size(1800, 900);
  fullScreen();
  //fullScreen(2); // for dual monitor setup
  frameRate(30);
  smooth();
  //noStroke();

  // start oscP5, listening for incoming messages at port 8000
  oscP5 = new OscP5(this, 8000);

  topKeyboard = new PianoKeyboard("top", width, height, 10, 3, 5);
  bottomKeyboard = new PianoKeyboard("bottom", width, height, 10, 3, 5);

  //imgDrum = loadImage("comic-jazz-drum-800.png");
  imgDrum = loadImage("red-blue-yellow-drum.png");

  imgDrum.loadPixels();

  // fit and center the drum image in the open band between the top and bottom keyboards,
  // scaling it down (never up) so it never overlaps either keyboard
  float bandTop = topKeyboard.height;
  float bandHeight = (height - bottomKeyboard.height) - bandTop;
  float fitHeight = bandHeight * 0.9; // leave a margin so the drum never touches the keys
  imgScale = min(1.0, min((float)width / imgDrum.width, fitHeight / imgDrum.height));
  float imgW = imgDrum.width * imgScale;
  float imgH = imgDrum.height * imgScale;
  imgX = (width - imgW) / 2;
  imgY = bandTop + (bandHeight - imgH) / 2;

  // initialize variables
  pulseAmp = 0;
  circleX = width/2;
  circleY = height/2 + topKeyboard.height/2;
  circleMinSize = 10;
  circleMaxSize = height/2-circleMinSize;
  circleSize = 0;
  circleColor = 0;
}

void draw() {
  background(bkColor);
  
  // calculate the size of the circle based on pulseAmp
  circleSize = map(pulseAmp, 0, 1, circleMinSize, circleMaxSize);
  
  // calculate the color of the circle based on pulseAmp
  circleColor = (int)map(pulseAmp, 0, 1, 0, 255);

  // draw the piano keyboards
  topKeyboard.render();
  bottomKeyboard.render();

  // draw the image in the middle of the screen
  // image(imgDrum, width/2-imgDrum.width/2, height/2-imgDrum.height/2);

  pushMatrix();
  translate(imgX, imgY);
  scale(imgScale);
  // draw the image centered between the two keyboards (particles share this scaled space)
  image (imgDrum, 0, 0);

  for (ParticleController current : pcs) {
      current.update(imgDrum);
      current.render(imgDrum);
  }
  // drop bursts that have fully faded so the list doesn't grow without bound
  pcs.removeIf(pc -> pc.isDone());
  popMatrix();

  // draw the circle
  // fill(circleColor, 0, 255-circleColor);
  // ellipse(circleX, circleY, circleSize, circleSize);
  pulseAmp = 0.0;
}

// oscEvent is called whenever a message is received
// void oscEvent(OscMessage msg) {
//   // check if theOscMessage has an address pattern we are looking for
//   if(msg.checkAddrPattern("/kick_amp")) {
//     // parse theOscMessage and extract the values from the osc message arguments
//     pulseAmp = msg.get(0).floatValue();
//   }

//   if (msg.checkAddrPattern("/note")) {
//     int note = msg.get(0).intValue();
//     topKeyboard.resetKeys();
//     topKeyboard.setKeyPressed(note, true);
//   }
// }

// oscEvent is called whenever a message is received
void oscEvent(OscMessage msg) {
  int instX = 0;
  int instY = 0;
  String shape = "cross";  // particle shape per drum voice

  // check if theOscMessage has an address pattern we are looking for
  if(msg.checkAddrPattern("/drum")) {
    switch(msg.get(0).stringValue()) {
      case "kick":
        instX = 530;
        instY = 530;
        shape = "circle";
        break;
      case "snare":
        instX = 450;
        instY = 200;
        shape = "star";
        break;
      case "cymbal":
        instX = 650;
        instY = 50;
        shape = "spark";
        break;
      default:
        instX = 0;
        instY = 0;
        shape = "cross";
        break;
    }
      // parse theOscMessage and extract the values from the osc message arguments
    pulseAmp = msg.get(1).floatValue();

    // Create a new ParticleController if amp, beat and on params are greater than 0
    if (pulseAmp > 0 && msg.get(2).intValue() > 0 && msg.get(3).intValue() > 0) {
      ParticleController pCont = new ParticleController(bkColor, pulseAmp, shape);

      pCont.createParticles(instX, instY, (int)(pulseAmp*100));
      // Add new controller to the array
      pcs.add(pCont);
    }
  }
  else if (msg.checkAddrPattern("/key")) {
    String inst = msg.get(0).stringValue();
    int note = msg.get(1).intValue();
    float amp = msg.get(2).floatValue();
    if (inst.equals("bass")) {
      topKeyboard.resetKeys();
      topKeyboard.setKeyPressed(inst, note, amp);
    } else {
      bottomKeyboard.resetKeys();
      bottomKeyboard.setKeyPressed(inst, note, amp);
    }
  }
}

void mouseClicked() {
    ParticleController pCont = new ParticleController(bkColor, -1, "cross");

    // map the screen click back into the image's (scaled) coordinate space
    float clickX = (mouseX - imgX) / imgScale;
    float clickY = (mouseY - imgY) / imgScale;
    pCont.createParticles(clickX, clickY, 50);
    // Add new controller to the array
    pcs.add(pCont);

    println(clickX, clickY);
}


void keyPressed() {
    if (key == 'q') {
        for (ParticleController current : pcs) {
            int numbers = current.ar.size();
            println(numbers);
        }
    }
}