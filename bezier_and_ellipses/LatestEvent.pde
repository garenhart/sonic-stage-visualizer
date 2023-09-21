class LatestEvent {
    String instrument = "";
    int note = 0;
    float amp = 0;

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
}