import oscP5.*;
import netP5.*;

OscP5 oscP5;

ArrayList<CelestialBody> bodies;

void setup() {
    size(800, 600);
    
    // Set up OSC communication
    oscP5 = new OscP5(this, 12000);
    
    // Create initial celestial bodies
    bodies = new ArrayList<CelestialBody>();
    bodies.add(new CelestialBody(width/2, height/2, 50, color(255, 0, 0)));
    bodies.add(new CelestialBody(width/2 + 100, height/2, 30, color(0, 255, 0)));
    bodies.add(new CelestialBody(width/2 - 100, height/2, 20, color(0, 0, 255)));
}

void draw() {
    background(0);
    
    // Update position of each celestial body based on incoming OSC messages
    for (CelestialBody body : bodies) {
        OscMessage msg = oscP5.get("/" + body.getName());
        if (msg != null) {
            float x = msg.get(0).floatValue();
            float y = msg.get(1).floatValue();
            body.updatePosition(x, y);
        }
    }
    
    // Draw each celestial body
    for (CelestialBody body : bodies) {
        body.draw();
    }
}

void oscEvent(OscMessage msg) {
    // Print incoming OSC messages to console
    println("Received OSC message: " + msg);
}

class CelestialBody {
    float x, y, size;
    int clr;
    String name;
    
    CelestialBody(float x, float y, float size, int clr) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.clr = clr;
        this.name = "body_" + (int)random(1000); // Generate a random name for the body
    }
    
    void updatePosition(float x, float y) {
        this.x = x;
        this.y = y;
    }
    
    void draw() {
        fill(color);
        ellipse(x, y, size, size);
    }
    
    String getName() {
        return name;
    }
}
