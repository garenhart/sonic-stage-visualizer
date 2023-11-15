class KeyChord extends KeyEvent {
    KeyChord(color c1, color c2) {
        super(c1, c2);
    }

    void render() {
        draw();
    }
    
    void draw() {
        if (note > 0) {
            textSize(64);
            textAlign(CENTER, CENTER);
            fill(lintColor());
            text(noteName(note), 0, 0); 
        }
    }
}