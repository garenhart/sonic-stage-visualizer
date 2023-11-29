class TravelingDots {
  float interval;
  int count;

  TravelingDots(float interval, int count) {
    this.interval = interval;
    this.count = count;

  }

  void draw() {
    pushMatrix();
    fill(0, 255, 150);
    translate(width/2, height/2);
    for (int i = 0; i < 360; i+=interval) {
      for(int q = -count/2; q < count/2; q++){
        float x = i/(interval/6)+tan(radians(dist(i/(interval/2), i/(interval/2), 0, 0)+q*50+frameCount))*interval;
        ellipse(x, q*10, 5, 5); 
      }
    }
    popMatrix();
  }
}

