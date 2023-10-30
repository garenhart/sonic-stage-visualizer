class SoundEvent {
    String instrument;
    int note;
    float amp;
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
    }
    
    void set(String instrument, int note, float amp) {
        this.instrument = instrument;
        this.note = note;
        this.amp = amp;             
    }

    float size() {
        return map(amp, 0, 1, 0, 20);
    }

    // Let's call this method lintColor, where lint means linear interpolation,
    // and call the original lerpColor, where lerp means linear interpolation :)
    color lintColor() {
        return lerpColor(c1, c2, amp);
    }       
}