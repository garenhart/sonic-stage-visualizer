class KeyEvent extends SoundEvent {
    KeyEvent(color c1, color c2) {
        super(c1, c2);
    }

    void render() {
        draw();
    }
    
    void draw() {
    }

    color lintColor() {
        return lerpColor(c1, c2, amp);
    }

}