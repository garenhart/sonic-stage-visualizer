ArrayList Drops = new ArrayList(); //a bucket to store the drops

Drop D;// the Drop in the second tap
boolean drawdrop = true;//set up the boolean of the drawdrop
PImage faucet; //stores image


void setup() {
  size(580,640);//set the size of the frame
  background(238,238,238);//set the colour of the background
  faucet = loadImage("faucet.jpg");//load the image in the data
}

void draw() {
  image(faucet,40,40,520,600); //drow the image

  for(int i=0;i<Drops.size();i++) { //iterate over our ArrayList
    Drop D = (Drop)Drops.get(i); //get one Drop out
    D.move(); //move the drop
    D.render(); //draw the drop
  }

  if (mousePressed == true) {
    drawdrop=false;//if the mouse is pressed, stop drawing the drop
  } 
  else {
    drawdrop= true;//otherwise, keep drawing the drops
  }


  if (frameCount%20 == 0 && drawdrop==true) {//set the drops keep moving
    Drop D = new Drop(new PVector(70,235),color(0,0,0),60);//set up the PVector of the new drop
    Drops.add(D);//add new drops 
  }
}

void keyPressed(){ //this runs when a key is pressed

save("wallpaper.jpg"); // save a file
}
