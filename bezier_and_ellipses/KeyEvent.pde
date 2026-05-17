class KeyEvent extends SoundEvent {
    PVector pos;
    PVector renderPos;
    PVector vel;
    PFont f;
    boolean offscreen = false;

    KeyEvent(color c1, color c2, float velX, float velY, float velZ) {
        super(c1, c2);

        pos = new PVector(0, 0, 0);
        renderPos = new PVector(0, 0, 0);
        vel = new PVector(velX, velY, velZ);

        f = createFont("Gill Sans MT Bold", 36, true);
        textFont(f);

    }

    void initPos() {
        pos.set(0, 0, 0);
        renderPos.set(0, 0, 0);
    }

    void render() {
        draw();
    }
    
    void draw() {
        if (note > 0) {
            pos.add(vel);
            renderPos.lerp(pos, 0.18);
            float radius = map(amp, 0, 1, 25, 75);

            if (renderPos.x < -width/4 || renderPos.x > width/4 || renderPos.y < -height/4 || renderPos.y > height/4 || renderPos.z < -width/4 || renderPos.z > width/4) {
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
                translate(renderPos.x, renderPos.y, renderPos.z);
                fill(c2); //fill(lintColor());
                sphere(radius);
                noLights();
                textSize(max(24, radius * 0.45));
                stroke(0);
                strokeWeight(3);
                fill(255);
                textAlign(CENTER, CENTER);
                text(noteName(note), 0, 0, radius + 2); // +2 to avoid z-fighting
            popMatrix();
        }
    }

    color lintColor() {
        return lerpColor(c1, c2, amp);
    }

}