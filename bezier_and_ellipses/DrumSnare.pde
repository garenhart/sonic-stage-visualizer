class DrumSnare extends DrumEvent {
    DrumSnare(color c1, color c2) {
        super(c1, c2);
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(c2, alpha);
        noFill();
        bezier(x - x2, y - y2, x, y, x2, y2, x - x2, y - y2);

        fill(complementaryColor(c2), alpha);
        ellipse(x - x2, y - y2, snare.size(), snare.size());
    }
}