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

    float size() {
        return beat? map(amp, 0, 1, 0, 20) : 0;
    }

    // Let's call this method lintColor, where lint means linear interpolation,
    // and call the original lerpColor, where lerp means linear interpolation :)
    color lintColor() {
        return beat ? lerpColor(c1, c2, amp) : c1;
    }       
}