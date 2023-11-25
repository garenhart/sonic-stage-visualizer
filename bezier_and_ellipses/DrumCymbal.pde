class DrumCymbal extends DrumEvent {
    DrumCymbal(color c1, color c2) {
        super(c1, c2);
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(cymbal.lintColor());
        noFill();
        bezier(x + x2, y + y2, x, y, x2, y2, x2 + x, y2 + y);
       
        fill(complementaryColor(cymbal.c2));
        ellipse(x + x2, y + y2, cymbal.size(), cymbal.size());
    }
}