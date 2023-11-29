PFont f;
float radius = 160;

void setup() {
  size(1200, 1200, P3D);
  background(30, 30, 50);
  f = createFont("Goudy Stout", 64, true);
  textFont(f);
  
}

void draw() {
   noStroke();
   sphereDetail(60);
   ambient(250, 100, 100);
   ambientLight(40, 20, 40);
   lightSpecular(40, 40, 40);
   directionalLight(185, 195, 255, -2, 5, -5);
   shininess(255);
   translate(width/2, height/2);
   fill(204, 102, 0);
   sphere(radius);
   textAlign(CENTER, CENTER);
   fill(200);
   noLights();
   text("C#", 0, 0, radius+20); // last parameter brings the text to the front
}