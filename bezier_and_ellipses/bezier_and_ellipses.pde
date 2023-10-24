// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;

OscP5 oscP5;

SoundEvent se;

float minX = 260;
float step = 10, delta;
color cStroke = color(0, 150, 255, 100);
color cEllipse1 = color(255, 150, 0);
color cEllipse2 = color(255, 255, 255);
color cEllipse3 = color(0, 255, 0);

void setup() {
    // start oscP5, listening for incoming messages at port 8000
    oscP5 = new OscP5(this, 8000);
    
    size(800, 800);
    //fullScreen();
    stroke(cStroke);
    strokeWeight(2);
    
    se = new SoundEvent();
    frameRate(10); // Slow down the frame rate since my computer is not handling the default 60fps very well
}

void draw() {
    background(0, 40);
    
    renderSound(se);
    
    se.reset();
    delta += 0.5;
    if (delta > 360) delta = 0;
}

void renderSound(SoundEvent se) {
    float maxX = minX; //+ map(se.amp, 0, 1, 1, 100);
    float x, y, x2, y2;
    float size = map(se.amp, 0, 1, 5, 15);
        //stroke(cStroke);
        stroke(se.c);
    
    translate(width / 2, height / 2);
    //for (int i = se.minDeg; i < se.maxDeg; i += step) {
    for (int i = 0; i < 360; i += step) {
        x = sin(radians(i + delta)) * maxX;
        y = cos(radians(i + delta)) * maxX;
        x2 = sin(radians(i + step - delta)) * maxX;
        y2 = cos(radians(i + step - delta)) * maxX;
        noFill();
        //strokeWeight(1 + se.amp*20);
        bezier(x, y, x - x2, y - y2, x2 - x, y2 - y, x2, y2);
        bezier(x, y, x + x2, y + y2, x2 + x, y2 + y, x2, y2);
        
        bezier(x - x2, y - y2, x, y, x2, y2, x2 - x, y2 - y);
        bezier(x + x2, y + y2, x, y, x2, y2, x2 + x, y2 + y);
        
        
        fill(complementaryColor(se.c));
        
        // Draw the ellipses of radius 5 + the amplitude of the sound
        if (se.instrument.equals("kick")) {
            //println(se.instrument);
            ellipse(x, y, size, size);
            ellipse(x2, y2, size, size);
        }
        
        if (se.instrument.equals("cymbal")) {
            ellipse(x - x2, y - y2, size, size);
        }
        
        if (se.instrument.equals("snare")) {
            ellipse(x + x2, y + y2, size, size);
        }
    }
    
     //if (se.instrument.equals("solo")) {
    if (se.note > 0) {
        //stroke(cStroke);
        fill(cEllipse1);
        textSize(64);
        textAlign(CENTER, CENTER);
        text(noteName(se.note), 0, 0); 
    }  
}

void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/drum")) {
        se.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
    }
    else if (msg.checkAddrPattern("/key")) {
        se.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue());
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
