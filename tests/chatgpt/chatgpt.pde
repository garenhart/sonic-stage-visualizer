// Import the oscP5 library
import oscP5.*;
import netP5.*;

// Declare the oscP5 and NetAddress objects
OscP5 oscP5;
NetAddress myRemoteLocation;

// Declare some variables for the celestial bodies
int numStars = 100; // Number of stars
float[] starX = new float[numStars]; // X coordinates of stars
float[] starY = new float[numStars]; // Y coordinates of stars
float[] starSize = new float[numStars]; // Sizes of stars
float sunX, sunY; // X and Y coordinates of the sun
float sunSize; // Size of the sun
float moonX, moonY; // X and Y coordinates of the moon
float moonSize; // Size of the moon

void setup() {
  // Set the size of the sketch window
  size(800, 600);
  
  // Initialize the oscP5 object and listen on port 12000
  oscP5 = new OscP5(this, 12000);
  
  // Initialize the NetAddress object with the IP address and port of the OSC sender
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  
  // Initialize the celestial bodies with random values
  for (int i = 0; i < numStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
    starSize[i] = random(2, 10);
  }
  sunX = width/2;
  sunY = height/2;
  sunSize = 100;
  moonX = width/4;
  moonY = height/4;
  moonSize = 50;
}

void draw() {
  // Set the background color to black
  background(0);
  
  // Draw the stars as white circles
  fill(255);
  noStroke();
  for (int i = 0; i < numStars; i++) {
    ellipse(starX[i], starY[i], starSize[i], starSize[i]);
  }
  
  // Draw the sun as a yellow circle
  fill(255, 255, 0);
  ellipse(sunX, sunY, sunSize, sunSize);
  
  // Draw the moon as a gray circle
  fill(150);
  ellipse(moonX, moonY, moonSize, moonSize);
}

// This method is called when an OSC message is received
void oscEvent(OscMessage theOscMessage) {
  
  // Check the address pattern of the message
  if (theOscMessage.checkAddrPattern("/sun")) {
    // If the message is for the sun, get the first float value and map it to the size of the sun
    float value = theOscMessage.get(0).floatValue();
    sunSize = map(value, -1, 1, 50, 150);
    
    // Print a message to the console
    println("Received OSC message for sun: " + value);
    
    // Send a confirmation message back to the sender
    OscMessage myMessage = new OscMessage("/sun");
    myMessage.add("OK");
    oscP5.send(myMessage, myRemoteLocation);
    
    return;
    
   } else if (theOscMessage.checkAddrPattern("/moon")) {
     // If the message is for the moon, get the first and second float values and map them to the position of the moon
     float xValue = theOscMessage.get(0).floatValue();
     float yValue = theOscMessage.get(1).floatValue();
     moonX = map(xValue, -1, 1, 0, width);
     moonY = map(yValue, -1, 1, height, 0);
     
     // Print a message to the console
     println("Received OSC message for moon: " + xValue + ", " + yValue);
     
     // Send a confirmation message back to the sender
     OscMessage myMessage = new OscMessage("/moon");
     myMessage.add("OK");
     oscP5.send(myMessage, myRemoteLocation);
     
     return;
     
   } else {
     // If the message is not recognized, print a warning to the console
     println("Unknown OSC message: " + theOscMessage.addrPattern());
   }
}
