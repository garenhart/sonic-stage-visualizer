class BassEvent extends KeyEvent {
    BassEvent(color c1, color c2) {
        super(c1, c2);
    }

    void render() {
        draw();
    }
    
    void draw() {
        stroke(lintColor());
        noFill();
        if (note > 0) {
            // draw concentric circles starting at the center of the screen and quickly growing and going out of screen
            for (int i = 0; i < 10; i++) {
                ellipse(0, 0, i * amp * 100, i * amp * 100);
            }
        }
    }
}