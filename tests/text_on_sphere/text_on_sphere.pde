PFont f;
float radius = 160;
String[] fontList = PFont.list();
int currentFont = 0;

void setup() {
  size(1200, 1200, P3D);
  background(30, 30, 50);
  f = createFont(fontList[currentFont], 24, true);
  //textFont(f);
  smooth();
}

void draw() {
   background(30, 30, 50);
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
   textFont(f);
   fill(200);
   noLights();
   text(fontList[currentFont], 0, 0, radius+20); // last parameter brings the text to the front
}

void keyPressed() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        currentFont++;
        if (currentFont >= fontList.length) {
          currentFont = 0;
        }
      } else if (keyCode == LEFT) {
        currentFont--;
        if (currentFont < 0) {
          currentFont = fontList.length-1;
        }
      } else {
        currentFont =  0;
      }
    }
    else { // if not coded
      if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')){
      // if a letter key is pressed, set current Font to the index of the first font starting with that letter
        for (int i = 0; i < fontList.length; i++) {
          println(fontList[i].charAt(0));
          if (fontList[i].charAt(0) == Character.toUpperCase(key)) {
            currentFont = i;
            println(key, fontList[currentFont]);
            break;
          }
        }
      }
    }
    
    f = createFont(fontList[currentFont], 24, true);
    println(fontList[currentFont]);
}
