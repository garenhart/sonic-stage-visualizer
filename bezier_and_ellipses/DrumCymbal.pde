class DrumCymbal extends DrumEvent {
    DrumCymbal(color c1, color c2) {
        super(c1, c2);
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(beat ? c2 : 255, alpha);
        noFill();
        bezier(x + x2, y + y2, x, y, x2, y2, x2 + x, y2 + y);
       
        // fill(c2, alpha);
        ellipse(x + x2, y + y2, size(), size());
    }
}