// Idea from https://openprocessing.org/sketch/172638
float a = 150;
int count = 3;

Dots dots = new Dots(50);

void setup() {
  size(640, 640);
  noStroke();
  fill(0, 255, 150);
}

void draw() {
  background(40);
  //translate(width/2, height/2);
  dots.travelHorizontal(20, color(0, 255, 150));
  dots.travelVertical(20, color(200, 200, 0));
}
