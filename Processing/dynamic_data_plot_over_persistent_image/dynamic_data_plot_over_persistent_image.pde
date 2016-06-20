/************************
* Plot dynamic data on 
* top of redrawn image
* using an ArrayList
* Ira Greenberg, 2016
************************/


ArrayList<PVector> locs = new ArrayList<PVector>();
PImage bg;
void setup() {
  size(800, 600);
  bg = loadImage("tokyo.jpg");
  bg.resize(width, height);
  noStroke();
  fill(255, 128, 0);
}

void draw() {
  image(bg, 0, 0);
  for (PVector p : locs) {
    pushMatrix();
    translate(p.x, p.y);
    ellipse(0, 0, 15, 15);
    popMatrix();
  }
}
void mousePressed() {
  locs.add(new PVector(mouseX, mouseY));
}