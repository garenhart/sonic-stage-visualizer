// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;

OscP5 oscP5;

SoundEvent se;

float minX = 100;
float step = 20, delta;
color cStroke = color(0, 150, 255, 100);

void setup() {
    // start oscP5, listening for incoming messages at port 8000
    oscP5 = new OscP5(this, 8000);

    size(640, 640);
    stroke(cStroke);
    strokeWeight(2);

    se = new SoundEvent();
}

void draw() {
    //fill(0, 40);
    //rect( - 1, -1, width + 1, height + 1);
    background(0, 40);
    
    switch(se.instrument) {
        case "kick":
             break;
        case "snare":
            break;
        case "cymbal":
            break;
        default:
            break;
    }
    
    float maxX = minX + map(se.amp, 0, 1, 1, 250);
    
    translate(width / 2, height / 2);
    for (int i = 0; i < 360; i += step) {
        float x = sin(radians(i + delta)) * maxX;
        float y = cos(radians(i + delta)) * maxX;
        
        float x2 = sin(radians(i + step - delta)) * maxX;
        float y2 = cos(radians(i + step - delta)) * maxX;
        noFill();
        bezier(x, y, x - x2, y - y2, x2 - x, y2 - y, x2, y2);
        bezier(x, y, x + x2, y + y2, x2 + x, y2 + y, x2, y2);
        fill(255, 150, 0);
        ellipse(x, y, 5, 5);
        ellipse(x2, y2, 5, 5);
    }
    
    se.reset();
    delta += 0.5;
}


void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/drum")) {
        se.set(msg.get(0).stringValue(), 0, msg.get(1).floatValue());
    }
    else if (msg.checkAddrPattern("/key")) {
        se.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue());
    }
}
