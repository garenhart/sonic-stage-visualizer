class KeyBass extends KeyEvent {
    KeyBass(color c1, color c2, float velX, float velY, float velZ) {
        super(c1, c2, velX, velY, velZ);
    }

    void render() {
        draw();
    }
    
}