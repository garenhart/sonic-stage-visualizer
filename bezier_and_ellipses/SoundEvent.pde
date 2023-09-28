class SoundEvent {
    String instrument;
    int note;
    float amp;
    int minDeg;
    int maxDeg;
    color c;

    SoundEvent() {
        reset();
    }
    
    void reset() {
        instrument = "";
        note = 0;
        amp = 0;
        minDeg = 0;
        maxDeg = 360;
        c = color(0, 150, 255, 100);
    }

    void set(String instrument, int note, float amp) {
        this.instrument = instrument;
        this.note = note;
        this.amp = amp;

        switch(se.instrument) {
            case "kick":
                minDeg = 0;
                maxDeg = 120;
                c = color(255, 0, 0, 100);
                break;
            case "snare":
                minDeg = 120;
                maxDeg = 240;
                c = color(0, 255, 0, 100);
                break;
            case "cymbal":
                minDeg = 240;
                maxDeg = 360;
                c = color(0, 0, 255, 100);
                break;
            default:
                break;
        }

        // minDeg = 0;
        // maxDeg = 360;
        // //println(instrument + " " + note + " " + amp);
    }
}