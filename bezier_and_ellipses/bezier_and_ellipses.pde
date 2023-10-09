// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;

OscP5 oscP5;

SoundEvent se;

float minX = 200;
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
}

void renderSound(SoundEvent se) {
    float maxX = minX; //+ map(se.amp, 0, 1, 1, 100);
    
    translate(width / 2, height / 2);
    //for (int i = se.minDeg; i < se.maxDeg; i += step) {
    for (int i = 0; i < 360; i += step) {
        float x = sin(radians(i + delta)) * maxX;
        float y = cos(radians(i + delta)) * maxX;
        
        float x2 = sin(radians(i + step - delta)) * maxX;
        float y2 = cos(radians(i + step - delta)) * maxX;
        noFill();
        stroke(cStroke);
        //strokeWeight(1 + se.amp*20);
        bezier(x, y, x - x2, y - y2, x2 - x, y2 - y, x2, y2);
        bezier(x, y, x + x2, y + y2, x2 + x, y2 + y, x2, y2);
        
        bezier(x - x2, y - y2, x, y, x2, y2, x2 - x, y2 - y);
        bezier(x + x2, y + y2, x, y, x2, y2, x2 + x, y2 + y);
        
        
        fill(se.c);
        // Draw the ellipses of radius 5 + the amplitude of the sound
        if (se.instrument.equals("kick")) {
            //println(se.instrument);
            ellipse(x, y, 5 + se.amp * 20, 5 + se.amp * 20);
            ellipse(x2, y2, 5 + se.amp * 20, 5 + se.amp * 20);
        }
        
        if (se.instrument.equals("cymbal")) {
            ellipse(x - x2, y - y2, 5 + se.amp * 5, 5 + se.amp * 5);
        }
        
        if (se.instrument.equals("snare")) {
            ellipse(x + x2, y + y2, 5 + se.amp * 5, 5 + se.amp * 5);
        }
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
