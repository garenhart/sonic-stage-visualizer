class DrumEvent extends SoundEvent {
    DrumEvent(color c1, color c2) {
        super(c1, c2);
    }

    float size() {
        return beat? map(amp, 0, 1, 5, 40) : 0;
    }
}