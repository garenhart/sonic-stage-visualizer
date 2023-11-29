ArrayList <ParticleController > pcs = new ArrayList <ParticleController >();
PImage pimg;
PImage pimg1; // uncomment to load image in background

void setup() {
    size(1800, 900);
    smooth();
    background(50);
    pimg = loadImage("comic-jazz-drum-800.png");
    pimg1 = loadImage("comic-jazz-drum-800.png");  // uncomment to load image in background
    pimg.loadPixels();
}

void draw() {
    background(0);
    
    //pimg1.filter(GRAY); // uncomment to apply gray scale filter to rhe background image
    image(pimg1, 0, 0); // uncomment to load image in background
    
    for (ParticleController current : pcs) {
        current.update(pimg);
        current.render(pimg);
    }
}

void mouseClicked() {
    ParticleController pCont = new ParticleController();
    pCont.createParticles(mouseX , mouseY , 50);
    // Add new controller to the array
    pcs.add(pCont);
}


void keyPressed() {
    if (key == 'q') {
        for (ParticleController current : pcs) {
            int numbers = current.ar.size();
            println(numbers);
        }
    }
}
