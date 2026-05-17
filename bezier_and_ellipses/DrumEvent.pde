class DrumEvent extends SoundEvent {
    int beatFramesRemaining = 0;
    int beatFlashFrames = 8;

    DrumEvent(color c1, color c2) {
        super(c1, c2);
    }

    void render() {
        if (beat) {
            beatFramesRemaining = beatFlashFrames;
        }

        beat = beatFramesRemaining > 0;
        super.render();

        if (beatFramesRemaining > 0) {
            beatFramesRemaining--;
        }

        beat = false;
    }

    float size() {
        return beat? map(amp, 0, 1, 5, 40) : 0;
    }
}