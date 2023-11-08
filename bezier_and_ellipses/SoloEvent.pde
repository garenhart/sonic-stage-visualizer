class SoloEvent extends KeyEvent {
    SoloEvent(color c1, color c2) {
        super(c1, c2);
    }

    void render() {
        draw();
    }
    
    void draw() {
        if (note > 0) {
            //stroke(cStroke);
            fill(lintColor());
            textSize(64);
            textAlign(CENTER, CENTER);
            text(noteName(note), 0, 0); 
        }
    }
}