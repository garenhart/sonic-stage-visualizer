import oscP5.*;
import netP5.*;

OscP5 oscP5;

int octaves = 4;
int whiteKeyWidth;
int whiteKeyHeight;
int blackKeyWidth;
int blackKeyHeight;

boolean[] isKeyPressed;

void setup() {
  fullScreen();
  //size(500, 500);
  calculateKeySizes();

  oscP5 = new OscP5(this, 8000);  // Replace with your desired OSC port number

  isKeyPressed = new boolean[octaves * 12];  // Initialize key press states
}

void draw() {
  background(255);
  drawKeyboard();
}

void calculateKeySizes() {
  whiteKeyWidth = width / (octaves * 7);
  whiteKeyHeight = height / 10;
  blackKeyWidth = whiteKeyWidth / 2;
  blackKeyHeight = whiteKeyHeight / 2;
}

void drawKeyboard() {
  int keyboardWidth = octaves * 7 * whiteKeyWidth;
  int xOffset = (width - keyboardWidth) / 2;

  // Draw white keys
  for (int octave = 0; octave < octaves; octave++) {
    for (int i = 0; i < 7; i++) {
      int note = octave * 12 + i;
      int midiNumber = 48 + note; // Calculate MIDI number
      
      int x = xOffset + octave * 7 * whiteKeyWidth + i * whiteKeyWidth;
      int y = 0;
      
      if (isKeyPressed[note]) {
        fill(200);
      } else {
        fill(255);
      }
      
      rect(x, y, whiteKeyWidth, whiteKeyHeight);
      
      // Draw MIDI number label
      fill(0);
      textAlign(CENTER, CENTER);
      text(midiNumber, x + whiteKeyWidth/2, y + whiteKeyHeight/2);
    }
  }

  // Draw black keys
  for (int octave = 0; octave < octaves; octave++) {
    for (int i = 0; i < 7; i++) {
      if (i != 0 && i != 3) {
        int note = octave * 12 + i;
        int midiNumber = 48 + note; // Calculate MIDI number
        
        int x = xOffset + octave * 7 * whiteKeyWidth + i * whiteKeyWidth - blackKeyWidth / 2;
        int y = 0;

        if (isKeyPressed[note]) {
          fill(100);
        } else {
          fill(0);
        }
        
        rect(x, y, blackKeyWidth, blackKeyHeight);
        
        // Draw MIDI number label
        fill(255);
        textAlign(CENTER, CENTER);
        text(midiNumber, x + blackKeyWidth/2, y + blackKeyHeight/2);
      }
    }
  }
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/note")) {
    int note = msg.get(0).intValue();
    print(note+ " ");
    if (note >= 0 && note < octaves * 12) {
      isKeyPressed[note] = true;
    }
  }
}

void keyReleased() {
  // Reset all key press states
  for (int i = 0; i < octaves * 12; i++) {
    isKeyPressed[i] = false;
  }
}
