class SoundEvent {
    String instrument;
    int note;
    float amp;
    boolean beat;
    color c1, c2;
    
    SoundEvent(color c1, color c2) {
        this.c1 = c1;
        this.c2 = c2;
        reset();
    }
    
    void reset() {
        instrument = "";
        note = 0;
        amp = 0;
        beat = false;
    }
    
    void set(String instrument, int note, float amp, int beat) {
        this.instrument = instrument;
        this.note = note;
        this.amp = amp;
        this.beat = (beat != 0);            
    }

    // Let's call this method lintColor, where lint means linear interpolation,
    // and call the original lerpColor, where lerp means linear interpolation :)
    color lintColor() {
        return beat ? lerpColor(c1, c2, amp) : c1;
    }

    void render(float step, float delta, float maxSize) {
        float x, y, x2, y2;

        for (int i = 0; i < 360; i += step) {
            x = sin(radians(i + delta)) * maxSize;
            y = cos(radians(i + delta)) * maxSize;
            x2 = sin(radians(i + step - delta)) * maxSize;
            y2 = cos(radians(i + step - delta)) * maxSize;
            
            draw(x, y, x2, y2);
        }  
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(lintColor());
        line(x, y, x2, y2);
    }
}