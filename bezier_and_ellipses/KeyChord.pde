class KeyChord extends KeyEvent {
    KeyChord(color c1, color c2, float velX, float velY, float velZ) {
        super(c1, c2, velX, velY, velZ);
    }

    void render() {
        draw();
    }
    
    // void draw() {
    //     if (note > 0) {
    //         pos.add(vel);

    //         // strokeWeight(1);
    //         // stroke(lintColor());
    //         // fill(lintColor());
	//         // line(0, 0, pos.x, pos.y);
    //         // ellipse(pos.x, pos.y, 100, 100);
    //         // fill(0);
    //         // textAlign(CENTER, CENTER);
    //         // text(noteName(note), pos.x, pos.y);
    //     }
    // }
}