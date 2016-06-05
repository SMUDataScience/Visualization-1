// Head Pixelate
PImage p;
int rows, cols;
float cellW, cellH;
float imgW, imgH;
float mouseXScalingFactor;

void setup() {
  background(255);
  noStroke();
  size(800, 400);

  p = loadImage("portrait.jpg"); 
  imgW = p.width;
  imgH = p.height;
  mouseXScalingFactor = imgW/width;
  
  
}

void draw() {
  background(255);
  image(p, 0, 0);

  rows = (int)(mouseX*mouseXScalingFactor);
  cols = mouseY;
  
  cellH = imgH/rows;
  cellW = imgW/cols;

  translate(width/2, 0);
  for (int i=0; i<imgH; i+=cellH ) {
    for (int j=0; j<imgW; j+= cellW) {
      fill(p.pixels[int(imgW)*i + j]);
      rect(j, i, cellW, cellH);
    }
  }
}

