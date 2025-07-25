class SoundEvent {
    String instrument;
    int note;
    float amp;
    boolean beat;
    boolean on;
    color c1, c2;
    float delta;
    float alpha;
    
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

        delta = 0;
    }
    
    void set(String instrument, int note, float amp, int beat, int on) {
        this.instrument = instrument;
        this.note = note;
        this.amp = amp;
        alpha = 180; //map(amp, 0, 1, 255, 50);      //amp*255; // 0-255  use alpha (opacity) to represent amplitude
        this.beat = (beat != 0); 
        this.on = (on != 0);
    }

    // Let's call this method lintColor, where lint means linear interpolation,
    // and call the original lerpColor, where lerp means linear interpolation :)
    color lintColor() {
        return beat ? lerpColor(c1, c2, amp) : c1;
    }

    void render() {
        float x, y, x2, y2;
        float maxSize = min(width, height) * 0.25; // Scale based on screen size
        float step = map(amp, 0, 1, 60, 1);

        if (!on) return;
        for (int i = 0; i < 360; i += step) {
            x = sin(radians(i + delta)) * maxSize;
            y = cos(radians(i + delta)) * maxSize;
            x2 = sin(radians(i + step - delta)) * maxSize;
            y2 = cos(radians(i + step + delta)) * maxSize;
            
            draw(x, y, x2, y2);
        }

        delta += 0.5;
        if (delta > 360) delta = 0;
    }

    void draw(float x, float y, float x2, float y2) {
        stroke(lintColor());
        line(x, y, x2, y2);
    }
}