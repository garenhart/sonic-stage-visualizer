class DrumKick extends DrumEvent {
    DrumKick(color c1, color c2) {
        super(c1, c2);
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(beat ? c2 : 255, alpha);
        noFill();
        bezier(x, y, x - x2, y - y2, x2 - x, y2 - y, x2, y2);
        bezier(x, y, x + x2, y + y2, x2 + x, y2 + y, x2, y2);

        // fill(c2, alpha);
        ellipse(x, y, size(), size());
        ellipse(x2, y2, size(), size());
    }
}