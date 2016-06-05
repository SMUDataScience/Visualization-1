// Head Psychedelic
PImage p;
PImage pNew;
int rows, cols;
float psychedelicFactorX, psychedelicFactorY;
// Beyond Photography
//new[x , y ] = y + (sin(x )∗Z )/2

void setup() {
  background(255);
  noStroke();
  size(800, 400);

  p = loadImage("portrait.jpg"); 
  pNew = createImage(p.width, p.height, RGB);

  rows = p.pixels.length/p.width;
  cols = p.pixels.length/p.height;
}

void draw() {
  background(255);
  image(p, 0, 0);

    psychedelicFactorX = mouseX*.005;
    psychedelicFactorY = mouseY*.005;

  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      int k = cols*i + j;
      float r = red(p.pixels[k]);
      float g = green(p.pixels[k]);
      float b = blue(p.pixels[k]);

      float newR = sin(j*k*.1*psychedelicFactorX*PI/180.0)*r+cos(i/(k+1)*psychedelicFactorY*PI/180.0)*r;
      float newG = cos(i*psychedelicFactorY*PI/180.0)*g-sin(j*psychedelicFactorX*PI/180.0)*g;
      float newB = cos((i*psychedelicFactorY+j*psychedelicFactorX)*PI/180.0)*b+sin((i*psychedelicFactorY-j*psychedelicFactorX)*PI/180.0)*b;

      color c = color(abs(newR), abs(newG), abs(newB));
      pNew.pixels[k] = c;
    }
  }
  
  translate(width/2, 0);
  pNew.updatePixels();
  image(pNew, 0, 0);
}

