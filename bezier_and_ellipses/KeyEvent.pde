class KeyEvent extends SoundEvent {
    PVector pos;
    PVector vel;
    PFont f;
    float radius = 50;
    boolean offscreen = false;

    KeyEvent(color c1, color c2, float velX, float velY, float velZ) {
        super(c1, c2);

        pos = new PVector(0, 0, 0);
        vel = new PVector(velX, velY, velZ);

        f = createFont("Gill Sans MT Bold", 36, true);
        textFont(f);

    }

    void initPos() {
        pos.set(0, 0, 0);
    }

    void render() {
        draw();
    }
    
    void draw() {
        if (note > 0) {
            pos.add(vel);

            if (pos.x < -width/2 || pos.x > width/2 || pos.y < -height/2 || pos.y > height/2 || pos.z < -width/2 || pos.z > width/2) {
                offscreen = true;
                return;
            }

            pushMatrix();
                noStroke();
                sphereDetail(170);
                ambient(250, 100, 100);
                ambientLight(40, 20, 40);
                lightSpecular(128, 100, 100);
                directionalLight(185, 195, 255, -1, 1.25, -1);
                shininess(255);
                translate(pos.x, pos.y, pos.z);
                fill(c2); //fill(lintColor());
                sphere(radius);
                noLights();
                fill(128);
                textAlign(CENTER, CENTER);
                text(noteName(note), 0, 0, radius+1); // +1 to avoid z-fighting
            popMatrix();
        }
    }

    color lintColor() {
        return lerpColor(c1, c2, amp);
    }

}