class PianoKeyboard {
    int top;
    int width, height;
    int firstOctave,  octaves;
    int whiteKeyWidth;
    int whiteKeyHeight;
    int blackKeyWidth;
    int blackKeyHeight;
    int strokeColor = 0;
    color fillColorWhite = 255;
    color fillColorWhitePressed = 200;
    color fillColorBlack = 0;
    color fillColorBlackPressed = 100;
    int strokeWeight = 1;
    PianoKey[] keys;

    // Constructor
    // position: "top", "bottom", "center"
    // height_percent: 0-100
    // firstOctave: 1-7 (C-C) (C1 = 24)
    // octaves: 1-7
    PianoKeyboard(String position, int windowWidth, int windowHeight, int height_percent, int firstOctave, int octaves) {
        this.width = windowWidth;
        this.height = windowHeight * height_percent / 100;
        this.firstOctave = firstOctave < 1 ? 1 : firstOctave > 7 ? 7 : firstOctave;
        this.octaves = octaves < 1 ? 1 : octaves > 7 ? 7 : octaves;
        whiteKeyWidth = width / (octaves * 7);
        whiteKeyHeight = height;
        blackKeyWidth = whiteKeyWidth / 2;
        blackKeyHeight = height / 2;

        initKeys();

        switch (position) {
            case "top":
                top = 0;
                break;
            case "bottom":
                top = windowHeight - height;
                break;
            case "center":
                top = (windowHeight - height) / 2;
                break;
            default:
                top = 0;
                break;
        }
    }

    void render() {
        int keyboardWidth = octaves * 7 * whiteKeyWidth;
        int xOffset = (width - keyboardWidth) / 2;
    
        renderWhiteKeys(xOffset);
        renderBlackKeys(xOffset);
        //resetKeys();
    }

    void renderWhiteKeys(int xOffset) {
        int key = -1;
        for (int octave = 0; octave < octaves; octave++) {
            for (int i = 0; i < 7; i++) {
                int x = xOffset + octave * 7 * whiteKeyWidth + i * whiteKeyWidth;
                int y = top;
                key = nextWhiteKeyIndex(key);
                fill(keys[key].isPressed ? fillColorWhitePressed : fillColorWhite);
                stroke(strokeColor);
                strokeWeight(strokeWeight);
                rect(x, y, whiteKeyWidth, whiteKeyHeight);
            }
        }
    }

    void renderBlackKeys(int xOffset) {
        int key = -1;
        for (int octave = 0; octave < octaves; octave++) {
            for (int i = 0; i < 7; i++) {
                if (i != 0 && i != 3) {
                     int x = xOffset + octave * 7 * whiteKeyWidth + i * whiteKeyWidth - blackKeyWidth / 2;
                    int y = top;
                    key = nextBlackKeyIndex(key);
                    fill(keys[key].isPressed ? fillColorBlackPressed : fillColorBlack);
                    stroke(strokeColor);
                    strokeWeight(strokeWeight);
                    rect(x, y, blackKeyWidth, blackKeyHeight);
                }
            }
        }
    }

    // Returns the index of the key for a given note (24-127)
    int keyIndex(int note) {
        return note - (firstOctave+1) * 12;
    }

    // Rwturns next white key index
    int nextWhiteKeyIndex(int index) {
        int i = index + 1;
        while (i < keys.length && !keys[i].isWhite) {
            i++;
        }
        return i;
    }

    // Returns next black key index
    int nextBlackKeyIndex(int index) {
        int i = index + 1;
        while (i < keys.length && keys[i].isWhite) {
            i++;
        }
        return i;
    }

    // Initialize the keys and set isWhite=true for white keys
    // and isWhite=false for black keys
    // Set the note number for each key to MIDI note number
    // Set isPressed=false for all keys
    void initKeys() {
        keys = new PianoKey[octaves * 12];
        for (int i = 0; i < keys.length; i++) {
            int note = i + (firstOctave+1) * 12;
            boolean isWhite = i % 12 == 0 || i % 12 == 2 || i % 12 == 4 || i % 12 == 5 || i % 12 == 7 || i % 12 == 9 || i % 12 == 11;
            keys[i] = new PianoKey(note, isWhite, false);
            //println(keys[i].note, keys[i].isWhite);
        }
    }

    // set key pressed for a given note
    void setKeyPressed(String inst, int note, float velocity) {
        int index = keyIndex(note);
        if (index >= 0 && index < keys.length) {
            keys[index].isPressed = true;
            setPressedKeyColor(inst, (int)(velocity*255));
        }
    }

    void setPressedKeyColor(String inst, int velocity) {
        switch (inst) {
            case "bass":
                fillColorWhitePressed = color(127, 200, 80, velocity);
                fillColorBlackPressed = color(64, 100, 40,  velocity);
                break;
            case "chord":
                fillColorWhitePressed = color(200, 200, 200,  velocity);
                fillColorBlackPressed = color(100, 100, 100,  velocity);
                break;
            case "solo":
                fillColorWhitePressed = color(255, 98, 0,  velocity);
                fillColorBlackPressed = color(100, 64, 40,  velocity);
                break;
            default:
                fillColorWhitePressed = 255 - velocity;
                fillColorBlackPressed = 100 + velocity;
                break;
        }
    }

    void resetKeys() {
        for (int i = 0; i < keys.length; i++) {
            keys[i].isPressed = false;
        }
    }

}
