// Inspired by: https://openprocessing.org/sketch/160305
// Programming for Artists - Sketch 50
import oscP5.*;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

OscP5 oscP5;

// oscEvent() runs on the network thread while draw() iterates this list on the
// animation thread, so it must be a thread-safe collection.
List<KeyEvent> keys = new CopyOnWriteArrayList<KeyEvent>();
DrumEvent kick, snare, cymbal;

// One shared font for all key labels. createFont() rasterizes glyphs, so it must
// not run per note event.
PFont keyFont;

//color cStroke = color(0, 150, 255, 100);
color cStroke = color(0, 102, 153);

void setup() {
    // start oscP5, listening for incoming messages at port 8000
    oscP5 = new OscP5(this, 8000);
    
    //size(1600, 1600, P3D);
    fullScreen(P3D);
    //fullScreen(P3D, 2); // Use external monitor
    stroke(cStroke);
    strokeWeight(2);

    // Sphere tessellation and the label font are global, frame-invariant state.
    // Setting them once here keeps them out of the per-sphere render path.
    sphereDetail(30);
    keyFont = createFont("Gill Sans MT Bold", 36, true);
    textFont(keyFont);

    kick = new DrumKick(cStroke, color(255, 128, 0));
    snare = new DrumSnare(cStroke, color(255, 200, 0));
    cymbal = new DrumCymbal(cStroke, color(0, 255, 153));
     
    //frameRate(10); // Slow down the frame rate since my computer is not handling the default 60fps very well
}

void draw() {
    background(0, 40);
    
    renderSound();
    
}

void renderSound() {
    translate(width / 2, height / 2);

    // Render all drums
    kick.render();
    snare.render();
    cymbal.render();

    // Remove keys with the sphere offscreen
    removeOffscreenKeys();

    // Render all keys
    for (KeyEvent key : keys) {
        key.render();
    }
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
    }
    else if (msg.checkAddrPattern("/key")) {
        if (msg.get(0).stringValue().equals("solo")) {
            KeyEvent keySolo = new KeySolo(cStroke, color(68, 102, 102), random(-10, 10), random(-10, 10), 10);
            keySolo.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
            keys.add(keySolo);
            // solo.initPos();
            // solo.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
        }
        else if (msg.get(0).stringValue().equals("bass")) {
            KeyEvent keyBass = new KeyBass(cStroke, color(255, 180, 0), -10, random(-10, 10), 10);
            keyBass.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
            keys.add(keyBass);
            // bass.initPos();
            // bass.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
        }
        else if (msg.get(0).stringValue().equals("chord")) {
            KeyEvent keyChord = new KeyChord(cStroke, color(204, 102, 0), 10, random(-10, 10), 10);
            keyChord.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
            keys.add(keyChord);
            // chord.initPos();
            // chord.set(msg.get(0).stringValue(), msg.get(1).intValue(), msg.get(2).floatValue(), 0, 1);
        }
    }
}

color complementaryColor(color c) {
    return color(255 - red(c), 255 - green(c), 255 - blue(c));
}

// Convert MIDI note number to note name
String noteName(int note) {
    String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    return notes[note % 12];
}

// Remove all keys with the sphere offscreen from the list (to save memory).
// removeIf does this in a single pass; index removal on a CopyOnWriteArrayList
// would copy the backing array once per removed element.
void removeOffscreenKeys() {
    keys.removeIf(key -> key.offscreen);
}
