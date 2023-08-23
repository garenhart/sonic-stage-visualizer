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

// declare variables for piano keyboard
PianoKeyboard pianoKeyboard;

void setup() {
  size(1200, 600);
  //size(1800, 900);
  //fullScreen();
  frameRate(30);
  smooth();
  //noStroke();

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this, 8000);

  pianoKeyboard = new PianoKeyboard("top", width, height, 10, 2, 5);

  //imgDrum = loadImage("comic-jazz-drum-800.png");
  imgDrum = loadImage("red-blue-yellow-drum.png");

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

void draw() {
  background(bkColor);
  
  // calculate the size of the circle based on pulseAmp
  circleSize = map(pulseAmp, 0, 1, circleMinSize, circleMaxSize);
  
  // calculate the color of the circle based on pulseAmp
  circleColor = (int)map(pulseAmp, 0, 1, 0, 255);

  // draw the piano keyboard
  pianoKeyboard.render();    

  // draw the image in the middle of the screen
  // image(imgDrum, width/2-imgDrum.width/2, height/2-imgDrum.height/2);

  pushMatrix();
  translate(width/2-imgDrum.width/2, height/2-imgDrum.height/2+pianoKeyboard.height);
  // draw the image in the middle of the screen below the piano keyboard
  image (imgDrum, 0, 0);

  for (ParticleController current : pcs) {
      current.update(imgDrum);
      current.render(imgDrum);
  }
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
//     pianoKeyboard.resetKeys();
//     pianoKeyboard.setKeyPressed(note, true);
//   }
// }

// oscEvent is called whenever a message is received
void oscEvent(OscMessage msg) {
  int instX = 0;
  int instY = 0;

  // check if theOscMessage has an address pattern we are looking for
  if(msg.checkAddrPattern("/drum")) {
    switch(msg.get(0).stringValue()) {
      case "kick":
        instX = 530;
        instY = 530;
        break;
      case "snare":
        instX = 450;
        instY = 200;
        break;
      case "cymbal":
        instX = 650;
        instY = 50;
        break;
      default:
        instX = 0;
        instY = 0;
        break;
    }
      // parse theOscMessage and extract the values from the osc message arguments
    pulseAmp = msg.get(1).floatValue();
   
    ParticleController pCont = new ParticleController(bkColor, pulseAmp);
    
    pCont.createParticles(instX, instY, 10);
    // Add new controller to the array
    pcs.add(pCont);
  }
  else if (msg.checkAddrPattern("/key")) {
    int note = msg.get(1).intValue();
    pianoKeyboard.resetKeys();
    pianoKeyboard.setKeyPressed(note, true);
  }
}


void mouseClicked() {
    ParticleController pCont = new ParticleController(bkColor, -1);
    
    pCont.createParticles(mouseX-(width/2-imgDrum.width/2), mouseY-(height/2+pianoKeyboard.height-imgDrum.height/2), 50);
    // Add new controller to the array
    pcs.add(pCont);

    println(mouseX-(width/2-imgDrum.width/2), mouseY-(height/2+pianoKeyboard.height-imgDrum.height/2));
}


void keyPressed() {
    if (key == 'q') {
        for (ParticleController current : pcs) {
            int numbers = current.ar.size();
            println(numbers);
        }
    }
}