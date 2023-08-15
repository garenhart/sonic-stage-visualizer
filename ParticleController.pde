class ParticleController {
    ArrayList <Particle > ar = new ArrayList <Particle>();
    int counter;
    
    void createParticles(float x , float y , int number) {
        for (int i = 0; i < number; i++) {
            Particle lObj = new Particle(x, y, random(5, 15), random( -0.5, 0.5), random(1, 5), random(0, 360));
            ar.add(lObj);
        }
    }

    // Update the position of the particles
    // Remove those particles that meet the remove criterion
    // 0 - remove particles that moved out of the screen
    // >0 - remove particles that moved farther than the removeCriterion from the center
    void update(PImage pimg, int removeCriterion) {
        ArrayList <Particle > remove = new ArrayList <Particle>();
        for (Particle tmp : ar) {
            tmp.x = tmp.cx + sin(radians(tmp.angle)) * (tmp.dist * counter);
            tmp.y = tmp.cy - cos(radians(tmp.angle)) * (tmp.dist * counter);
            
            if (removeCriterion > 0) {
                // Add those particles that moved farther than the removeCriterion from the center to "remove" list
                if (dist(tmp.x, tmp.y, tmp.cx, tmp.cy) > removeCriterion) {
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

                    float r = adjustColor(red(pimg.pixels[loc]));
                    float g = adjustColor(green(pimg.pixels[loc]));
                    float b = adjustColor(blue(pimg.pixels[loc]));

                    stroke(r,g,b);
                }
            }
            tmp.render("");
        }
     }

     // Adjust the color of the particles to make them more visible
     float adjustColor(float c) {
        float adjust = 50;
        
        return c + adjust > 255 ? 255 : c + adjust;
     }
}
