class Dots {
    float d;
    
    Dots(float d) {
        this.d = d;
    }   
        
    void travelHorizontal(int posVert, color c) {
        pushMatrix();
        
        noStroke();
        fill(c);

        for (int i = 0; i < 360; i+=d) {
            float x = i/(d/6)+tan(radians(dist(i/(d/6), i/(d/2), 0, 0)+posVert*50+frameCount))*d;
            ellipse(x, posVert*10, 5, 5); 
        }
        popMatrix();
    }

    void travelVertical(int posHoriz, color c) {
        pushMatrix();
        
        noStroke();
        fill(c);

        for (int i = 0; i < 360; i+=d) {
            float y = i/(d/6)+tan(radians(dist(i/(d/2), i/(d/2), 0, 0)+posHoriz*50+frameCount))*d;
            ellipse(posHoriz*10, y, 5, 5); 
        }
        popMatrix();
    }

}