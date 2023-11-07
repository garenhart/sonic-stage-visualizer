class SnareEvent extends SoundEvent {
    SnareEvent(color c1, color c2) {
        super(c1, c2);
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(snare.lintColor());
        noFill();
        bezier(x - x2, y - y2, x, y, x2, y2, x - x2, y - y2);

        fill(complementaryColor(snare.c2));
        ellipse(x - x2, y - y2, snare.size(), snare.size());
    }
}