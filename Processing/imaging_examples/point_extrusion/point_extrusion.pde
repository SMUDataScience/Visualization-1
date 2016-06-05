// Point Extrusion

float detail; 

PImage src;
PVector[][] vecs;
int imgW, imgH;
void setup() {
  src = loadImage("portrait.jpg");
  size(src.width*2, src.height, P3D);

  imgW = src.width;
  imgH = src.height;

  vecs = new PVector[imgH][imgW];

  for (int i=0; i<imgH; i++) {
    for (int j=0; j<imgW; j++) {
      vecs[i][j] = new PVector(j, i, 0);
    }
  }
}

void draw() {
  background(0);
  image(src, 0, 0);

  lights();

  if (mouseX < width/2) {
    detail = mouseX*.005;
  }

  translate(width-imgW/2, height/2, -255/2);
  rotateY(frameCount*PI/720);

  for (int i=0; i<imgH; i++) {
    for (int j=0; j<imgW; j++) {
      stroke(src.pixels[i*imgW+j]);
      float z = -255/2+brightness(src.pixels[i*imgW + j]);
      point(-imgW/2 +vecs[i][j].x, -imgH/2+vecs[i][j].y, z*detail);
    }
  }
}

