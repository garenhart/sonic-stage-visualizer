class Particle {
    float x, y;       // current position (image space)
    float vx, vy;     // velocity, advanced by the controller's physics
    float size;       // base size in pixels
    float spin;       // current rotation of the shape
    float step;       // rotation speed per frame
    String shape;     // "circle" | "star" | "spark" | "cross"

    Particle(float x, float y, float vx, float vy, float size, float step, String shape) {
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy;
        this.size = size;
        this.step = step;
        this.spin = random(TWO_PI);
        this.shape = shape;
    }

    // renders the particle at a (possibly shrunk) display size.
    // fill and stroke colour/alpha are set by the controller before this call.
    void render(float displaySize) {
        spin += step;
        switch (shape) {
            case "circle": renderCircle(displaySize); break;
            case "star":   renderStar(displaySize);   break;
            case "spark":  renderSpark(displaySize);  break;
            default:       renderCross(displaySize);  break;
        }
    }

    // kick: soft filled orb
    void renderCircle(float s) {
        noStroke();
        ellipse(x, y, s, s);
    }

    // snare: spinning 5-point star
    void renderStar(float s) {
        float outer = s / 2;
        float inner = s / 4;
        beginShape();
        for (int i = 0; i < 10; i++) {
            float r = (i % 2 == 0) ? outer : inner;
            float a = spin + i * PI / 5;
            vertex(x + cos(a) * r, y + sin(a) * r);
        }
        endShape(CLOSE);
    }

    // cymbal: thin twinkling sparkle of radial lines
    void renderSpark(float s) {
        noFill();
        for (int i = 0; i < 4; i++) {
            float a = spin + i * HALF_PI;
            line(x, y, x + cos(a) * (s / 2), y + sin(a) * (s / 2));
        }
    }

    // default / mouse: spinning cross (the original look)
    void renderCross(float s) {
        noFill();
        float halfX = sin(spin) * (s / 2);
        float halfY = cos(spin) * (s / 2);
        line(x - halfX, y - halfY, x + halfX, y + halfY);

        halfX = sin(spin + HALF_PI) * (s / 2);
        halfY = cos(spin + HALF_PI) * (s / 2);
        line(x - halfX, y - halfY, x + halfX, y + halfY);
    }
}
