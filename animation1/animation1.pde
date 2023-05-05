import oscP5.*;

OscP5 oscP5;

// Full screen sketch
void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 8000);
}

void draw() {
  background(0);
  fill(255);
  // 

}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/kick_amp")==true) {
    println("### received an osc message.");
    println(" addrpattern: "+msg.addrPattern());
    println(" typetag: "+msg.typetag());
    println(" value: "+msg.get(0).floatValue());
  }
}