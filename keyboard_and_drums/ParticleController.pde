class ParticleController {
    List <Particle > ar = new CopyOnWriteArrayList <Particle>();
    int counter;
    int bkColor;
    int colorAdjust;
    int travelDistance;
    
    // Constructor
    ParticleController(int bkColor, float amp) {
        counter = 0;
        colorAdjust = 50;
        this.bkColor = bkColor;
        this.travelDistance = (int)(amp*100);
    }

    void createParticles(float x , float y , int number) {
        for (int i = 0; i < number; i++) {
            Particle lObj = new Particle(x, y, random(5, 15), random( -0.5, 0.5), random(5, 25), random(0, 360));
            ar.add(lObj);
        }
    }

    // Update the position of the particles
    // Remove those particles that meet the remove criterion
    // -1 - remove particles that moved out of the screen
    // >=0 - remove particles that moved farther than the travelDistance from the center
    void update(PImage pimg) {
        for (Particle tmp : ar) {
            tmp.x = tmp.cx + sin(radians(tmp.angle)) * (tmp.dist * counter);
            tmp.y = tmp.cy - cos(radians(tmp.angle)) * (tmp.dist * counter);
        }

        // removeIf prunes dead particles in a single backing-array copy. The old
        // code built a temp list and called ar.remove() per element, copying the
        // whole CopyOnWriteArrayList once for every particle removed.
        ar.removeIf(tmp -> isExpired(tmp, pimg));
    }

    // A particle is expired once it travels past travelDistance from its origin,
    // or (when travelDistance is -1) once it leaves the image bounds.
    boolean isExpired(Particle tmp, PImage pimg) {
        if (travelDistance > -1) {
            return dist(tmp.x, tmp.y, tmp.cx, tmp.cy) > travelDistance;
        }
        return tmp.x < 0 || tmp.x > pimg.width || tmp.y < 0 || tmp.y > pimg.height;
    }
    
    void render(PImage pimg) {
        counter += 1;

        for (Particle tmp : ar) {
            strokeWeight(tmp.size / 5);
            if (tmp.x > 0 && tmp.x < pimg.width && tmp.y > 0 && tmp.y < pimg.height) {
                int loc = (int)tmp.x + (int)tmp.y * pimg.width;
                int pix = pimg.pixels[loc]; // sample the source pixel once

                // if pixel is transparent, use the background color
                if (alpha(pix) == 0) {
                    stroke(bkColor + colorAdjust);
                }
                else {
                    stroke(adjustColor(red(pix)), adjustColor(green(pix)), adjustColor(blue(pix)));
                }
            }
            tmp.render("");
        }
     }

     // Adjust the color of the particles to make them more visible
     float adjustColor(float c) {
        return c + colorAdjust > 255 ? 255 : c + colorAdjust;
     }
}
