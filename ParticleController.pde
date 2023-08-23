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
            Particle lObj = new Particle(x, y, random(5, 15), random( -0.5, 0.5), random(1, 5), random(0, 360));
            ar.add(lObj);
        }
    }

    // Update the position of the particles
    // Remove those particles that meet the remove criterion
    // -1 - remove particles that moved out of the screen
    // >=0 - remove particles that moved farther than the travelDistance from the center
    void update(PImage pimg) {
        List <Particle > remove = new CopyOnWriteArrayList <Particle>();
        for (Particle tmp : ar) {
            tmp.x = tmp.cx + sin(radians(tmp.angle)) * (tmp.dist * counter);
            tmp.y = tmp.cy - cos(radians(tmp.angle)) * (tmp.dist * counter);
            
            if (travelDistance > -1) {
                // Add those particles that moved farther than the travelDistance from the center to "remove" list
                if (dist(tmp.x, tmp.y, tmp.cx, tmp.cy) > travelDistance) {
                    remove.add(tmp);
                }
            }
            else {
                // Add those particles that moved out of the screen to "remove" list
                if (tmp.x < 0 || tmp.x > pimg.width) {
                    remove.add(tmp);
                }
                if (tmp.y < 0 || tmp.y > pimg.height) {
                    remove.add(tmp);
                }
            }
        }
        
        // Remove particles beyobd the screen boundaries from the particle list
        for (Particle tmp : remove) {
            ar.remove(tmp);
        }
    }
    
    void render(PImage pimg) {
        counter += 1;

        for (Particle tmp : ar) {
            strokeWeight(tmp.size / 5);
            if (tmp.x > 0 && tmp.x < pimg.width) {
                if (tmp.y > 0 && tmp.y < pimg.height) {
                    int loc = (int)tmp.x + (int)tmp.y * pimg.width;
                    int pix = pimg.pixels[loc];

                    // if pixel is transparent, use the background color
                    if (alpha(pimg.pixels[loc]) == 0) {
                        stroke(bkColor + colorAdjust);
                    }
                    else {
                        float r = adjustColor(red(pimg.pixels[loc]));
                        float g = adjustColor(green(pimg.pixels[loc]));
                        float b = adjustColor(blue(pimg.pixels[loc]));

                        stroke(r,g,b);
                    }
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
