class SoundEvent {
    String instrument;
    int note;
    float amp;
    color c;
    
    SoundEvent() {
        reset();
    }
    
    void reset() {
        instrument = "";
        note = 0;
        amp = 0;
        c = color(0, 150, 255, 100);
    }
    
    void set(String instrument, int note, float amp) {
        this.instrument = instrument;
        this.note = note;
        this.amp = amp;
                
        switch(se.instrument) {
            case "kick":
                c = color(#CC813F);
                break;
            case "snare":
                c = color(#FFC66D);
                break;
            case "cymbal":
                c = color(#6A8759);
                break;
            default:
                break;
        }    
    }        
}