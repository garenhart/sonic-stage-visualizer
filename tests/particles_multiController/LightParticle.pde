class LightParticle {
    float x, y, cx, cy, size, step, dist, angle;
    float counter; 
    
    LightParticle(float cx, float cy, float size, float step, float dist, float angle) {
        this.cx = cx;
        this.cy = cy;
        this.size = size;
        this.dist = dist;
        this.step = step;
        this.angle = angle;
    }
    
    // renders particle pattern depending on argument value 
    void render(String pattern) {
        switch(pattern) {
            case "cross" : renderCross();
                break;
            default : renderCross();
            break;
    }
    }
    
    void renderCross() {
        counter += step;
        if (counter > TWO_PI) {
            counter = 0;
        }
        if (counter < 0) {
            counter = TWO_PI;
        }
        
        float halfX = sin(counter) * (size / 2);
        float halfY = cos(counter) * (size / 2);
        
        float x1 = x - halfX;
        float x2 = x + halfX;
        float y1 = y - halfY;
        float y2 = y + halfY;
        
        line(x1,y1,x2,y2);
        
        halfX = sin(counter + PI / 2) * (size / 2);
        halfY = cos(counter + PI / 2) * (size / 2);
        
        x1 = x - halfX;
        x2 = x + halfX;
        y1 = y - halfY;
        y2 = y + halfY;
        
        line(x1, y1, x2, y2);
    }
}
