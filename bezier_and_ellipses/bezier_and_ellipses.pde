// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;

OscP5 oscP5;

DrumEvent kick, snare, cymbal;
KeyEvent solo, bass, chord;

float minX = 260;
float step = 20, delta;
//color cStroke = color(0, 150, 255, 100);
color cStroke = color(0, 102, 153);

void setup() {
    // start oscP5, listening for incoming messages at port 8000
    oscP5 = new OscP5(this, 8000);
    
    size(800, 800);
    //fullScreen();
    stroke(cStroke);
    strokeWeight(2);
    
    kick = new KickEvent(cStroke, color(204, 102, 0));
    snare = new SnareEvent(cStroke, color(136, 102, 51));
    cymbal = new CymbalEvent(cStroke, color(68, 102, 102));

    solo = new SoloEvent(cStroke, color(#6A8759));
    bass = new BassEvent(cStroke, color(#6A8759));
    chord = new ChordEvent(cStroke, color(#6A8759));

    //frameRate(10); // Slow down the frame rate since my computer is not handling the default 60fps very well
}

void draw() {
    background(0, 40);
    
    renderSound();
        
    delta += 0.5;
    if (delta > 360) delta = 0;
}

void renderSound() {
    float maxX = minX; //+ map(se.amp, 0, 1, 1, 100);
    float x, y, x2, y2;

    //stroke(cStroke);

    step = map(kick.amp+snare.amp+cymbal.amp, 0, 3, 120, 10);
    //println(step, kick.amp, snare.amp, cymbal.amp);

    translate(width / 2, height / 2);

    kick.render(step, delta, maxX);
    snare.render(step, delta, maxX);
    cymbal.render(step, delta, maxX);

    solo.render();
    bass.render();
    chord.render();
}

void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/drum")) {
        if (msg.get(0).stringValue().equals("kick")) {
            kick.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue(), msg.get(2).intValue());
        }
        else if (msg.get(0).stringValue().equals("snare")) {
            snare.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue(), msg.get(2).intValue());
        }
        else if (msg.get(0).stringValue().equals("cymbal")) {
            cymbal.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue(), msg.get(2).intValue());
        }
        //se.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
    }
    else if (msg.checkAddrPattern("/key")) {
        if (msg.get(0).stringValue().equals("solo")) {
            solo.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0);
        }
        else if (msg.get(0).stringValue().equals("bass")) {
            bass.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0);
        }
        else if (msg.get(0).stringValue().equals("chord")) {
            chord.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0);
        }
    }
}

color complementaryColor(color c) {
    return color(255 - red(c), 255 - green(c), 255 - blue(c));
}

// Method to convert MIDI note number to note name
String noteName(int note) {
    String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    println(note, notes[note % 12]);
    return notes[note % 12];
}
