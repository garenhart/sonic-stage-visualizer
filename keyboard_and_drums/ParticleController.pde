class ParticleController {
    List <Particle > ar = new CopyOnWriteArrayList <Particle>();
    int counter;        // age in frames; all particles in a controller share a spawn frame
    int bkColor;
    int colorAdjust;
    int lifespan;       // frames before the burst has fully faded out
    float drag;         // per-frame velocity multiplier (<1 slows the burst)
    float gravity;      // per-frame downward acceleration
    String shape;       // shape spawned by this burst

    // Constructor
    ParticleController(int bkColor, float amp, String shape) {
        counter = 0;
        colorAdjust = 50;
        this.bkColor = bkColor;
        this.shape = shape;
        // louder hits linger a little longer; mouse clicks (amp < 0) get a default
        this.lifespan = amp < 0 ? 45 : (int)(30 + amp * 40);
        this.drag = 0.92;
        this.gravity = 0.25;
    }

    void createParticles(float x , float y , int number) {
        for (int i = 0; i < number; i++) {
            // explode outward in every direction at a random speed
            float angle = random(TWO_PI);
            float speed = random(4, 14);
            float vx = cos(angle) * speed;
            float vy = sin(angle) * speed;
            ar.add(new Particle(x, y, vx, vy, random(6, 16), random(-0.4, 0.4), shape));
        }
    }

    // Advance the physics: drag eases the burst out, gravity makes it arc and fall.
    void update(PImage pimg) {
        for (Particle p : ar) {
            p.vx *= drag;
            p.vy *= drag;
            p.vy += gravity;
            p.x += p.vx;
            p.y += p.vy;
        }
        // the whole burst shares an age, so it expires together once it has faded out
        ar.removeIf(p -> counter >= lifespan);
    }

    // returns true once this burst has fully faded
    boolean isDone() {
        return counter >= lifespan && ar.isEmpty();
    }

    void render(PImage pimg) {
        counter += 1;
        // 1.0 when fresh, easing to 0.0 at end of life -> drives fade + shrink
        float life = constrain(1.0 - (float)counter / lifespan, 0, 1);

        // additive blending makes overlapping particles bloom into bright hotspots
        blendMode(ADD);
        for (Particle p : ar) {
            // sample the drum pixel underneath; fall back to a soft glow off-image
            float r = bkColor + colorAdjust;
            float g = bkColor + colorAdjust;
            float b = bkColor + colorAdjust;
            if (p.x > 0 && p.x < pimg.width && p.y > 0 && p.y < pimg.height) {
                int pix = pimg.pixels[(int)p.x + (int)p.y * pimg.width];
                if (alpha(pix) != 0) {
                    r = adjustColor(red(pix));
                    g = adjustColor(green(pix));
                    b = adjustColor(blue(pix));
                }
            }

            float a = 255 * life;
            stroke(r, g, b, a);
            fill(r, g, b, a);
            strokeWeight(p.size / 5 * life + 0.5);

            // shrink as the particle ages (never fully to zero before it fades)
            p.render(p.size * (0.4 + 0.6 * life));
        }
        blendMode(BLEND);
     }

     // Adjust the color of the particles to make them more visible
     float adjustColor(float c) {
        return c + colorAdjust > 255 ? 255 : c + colorAdjust;
     }
}
