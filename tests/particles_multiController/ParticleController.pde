class ParticleController {
    ArrayList <LightParticle > ar = new ArrayList <LightParticle>();
    int counter;
    
    void createParticles(float x , float y , int number) {
        for (int i = 0; i < number; i++) {
            LightParticle lObj = new LightParticle(x, y, random(10, 30), random( -0.5, 0.5), random(1, 5), random(0, 360));
            ar.add(lObj);
        }
    }
    void update(PImage pimg) {
        ArrayList <LightParticle > remove = new ArrayList <LightParticle>();
        for (LightParticle tmp : ar) {
            tmp.x = tmp.cx + sin(radians(tmp.angle)) * (tmp.dist * counter);
            tmp.y = tmp.cy - cos(radians(tmp.angle)) * (tmp.dist * counter);
            
            // Add those particles that moved out of the screen to "remove" list
            if (tmp.x < 0 || tmp.x > pimg.width) {
                remove.add(tmp);
            }
            if (tmp.y < 0 || tmp.y > pimg.height) {
                remove.add(tmp);
            }
        }
        
        // Remove particles beyond the screen boundaries from the particle list
        for (LightParticle tmp : remove) {
            ar.remove(tmp);
        }
    }
    
    void render(PImage pimg) {
        counter += 1;
        for (LightParticle tmp : ar) {
            strokeWeight(tmp.size / 5);
            if (tmp.x > 0 && tmp.x < pimg.width) {
                if (tmp.y > 0 && tmp.y < pimg.height) {
                    int loc = (int)tmp.x + (int)tmp.y * pimg.width;
                    float r = red(pimg.pixels[loc]);
                    float g = green(pimg.pixels[loc]);
                    float b = blue(pimg.pixels[loc]);
                    stroke(r,g,b);
                }
            }
            tmp.render("");
        }
     }
}
