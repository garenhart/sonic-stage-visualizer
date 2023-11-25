// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;

OscP5 oscP5;

DrumEvent kick, snare, cymbal;
KeyEvent solo, bass, chord;

//color cStroke = color(0, 150, 255, 100);
color cStroke = color(0, 102, 153);

void setup() {
    // start oscP5, listening for incoming messages at port 8000
    oscP5 = new OscP5(this, 8000);
    
    size(1600, 1600, P3D);
    //fullScreen(P3D);
    stroke(cStroke);
    strokeWeight(2);
    
    kick = new DrumKick(cStroke, color(204, 102, 0));
    snare = new DrumSnare(cStroke, color(136, 102, 51));
    cymbal = new DrumCymbal(cStroke, color(68, 102, 102));
    
    solo = new KeySolo(cStroke, color(255, 170, 51), 0, -10, 60);
    bass = new KeyBass(cStroke, color(180, 180, 0), -10, -10, 60);
    chord = new KeyChord(cStroke, color(204, 102, 0), 10, -10, 60);
    
    //frameRate(10); // Slow down the frame rate since my computer is not handling the default 60fps very well
}

void draw() {
    background(0, 40);
    
    renderSound();
    
}

void renderSound() {
    float x, y, x2, y2;
    
    //stroke(cStroke);
    
    translate(width / 2, height / 2);
    
    //println("kick: " + kick.on);
    kick.render();
    snare.render();
    cymbal.render();
    
    solo.render();
    bass.render();
    chord.render();
}

void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/drum")) {
        if (msg.get(0).stringValue().equals("kick")) {
            kick.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue(), msg.get(2).intValue(), msg.get(3).intValue());
        }
        else if (msg.get(0).stringValue().equals("snare")) {
            snare.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue(), msg.get(2).intValue(), msg.get(3).intValue());
        }
        else if (msg.get(0).stringValue().equals("cymbal")) {
            cymbal.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue(), msg.get(2).intValue(), msg.get(3).intValue());
        }
        //se.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
    }
    else if (msg.checkAddrPattern("/key")) {
        if (msg.get(0).stringValue().equals("solo")) {
            solo.initPos();
            solo.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
        }
        else if (msg.get(0).stringValue().equals("bass")) {
            bass.initPos();
            bass.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
        }
        else if (msg.get(0).stringValue().equals("chord")) {
            chord.initPos();
            chord.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
        }
    }
}

color complementaryColor(color c) {
    return color(255 - red(c), 255 - green(c), 255 - blue(c));
}

// Method to convert MIDI note number to note name
String noteName(int note) {
    String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    //println(note, notes[note % 12]);
    return notes[note % 12];
}
