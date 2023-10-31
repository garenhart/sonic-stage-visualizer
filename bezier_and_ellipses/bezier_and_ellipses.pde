// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;

OscP5 oscP5;

SoundEvent kick, snare, cymbal, solo, bass, chord;

float minX = 260;
float step = 10, delta;
//color cStroke = color(0, 150, 255, 100);
color cStroke = color(0, 102, 153);
color cEllipse1 = color(255, 150, 0);
color cEllipse2 = color(255, 255, 255);
color cEllipse3 = color(0, 255, 0);

void setup() {
    // start oscP5, listening for incoming messages at port 8000
    oscP5 = new OscP5(this, 8000);
    
    //size(800, 800);
    fullScreen();
    stroke(cStroke);
    strokeWeight(2);
    
    kick = new SoundEvent(cStroke, color(204, 102, 0));
    snare = new SoundEvent(cStroke, color(136, 102, 51));
    cymbal = new SoundEvent(cStroke, color(68, 102, 102));

    solo = new SoundEvent(cStroke, color(#6A8759));

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

    translate(width / 2, height / 2);
    //for (int i = se.minDeg; i < se.maxDeg; i += step) {
    for (int i = 0; i < 360; i += step) {
        x = sin(radians(i + delta)) * maxX;
        y = cos(radians(i + delta)) * maxX;
        x2 = sin(radians(i + step - delta)) * maxX;
        y2 = cos(radians(i + step - delta)) * maxX;
        noFill();
        //strokeWeight(1 + se.amp*20);

        // set stroke color between cStroke and kick.c
        // depending on value of kick.amp
        stroke(kick.lintColor());
        bezier(x, y, x - x2, y - y2, x2 - x, y2 - y, x2, y2);
        bezier(x, y, x + x2, y + y2, x2 + x, y2 + y, x2, y2);
        
        stroke(snare.lintColor());
        bezier(x - x2, y - y2, x, y, x2, y2, x2 - x, y2 - y);

        stroke(cymbal.lintColor());
        bezier(x + x2, y + y2, x, y, x2, y2, x2 + x, y2 + y);
        
        println("kick amp: " + kick.amp);
        println("kick size: " + kick.size());       
        fill(complementaryColor(kick.c2));
        //println(se.instrument);
        ellipse(x, y, kick.size(), kick.size());
        ellipse(x2, y2, kick.size(), kick.size());
        
        fill(complementaryColor(snare.c2));
        ellipse(x - x2, y - y2, snare.size(), snare.size());
    
        
        fill(complementaryColor(cymbal.c2));
        ellipse(x + x2, y + y2, cymbal.size(), cymbal.size());
        
    }
    
     //if (se.instrument.equals("solo")) {
    if (solo.note > 0) {
        //stroke(cStroke);
        fill(solo.lintColor());
        textSize(64);
        textAlign(CENTER, CENTER);
        text(noteName(solo.note), 0, 0); 
    }  
}

void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/drum")) {
        if (msg.get(0).stringValue().equals("kick")) {
            kick.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
        }
        else if (msg.get(0).stringValue().equals("snare")) {
            snare.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
        }
        else if (msg.get(0).stringValue().equals("cymbal")) {
            cymbal.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
        }
        //se.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
    }
    else if (msg.checkAddrPattern("/key")) {
        if (msg.get(0).stringValue().equals("solo")) {
            solo.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue());
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
