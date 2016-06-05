//Polygonal Extrusion

int sampleFactor; 
float detail; 

PImage src;
PVector[][] vecs;
color[][] cols;
int imgW, imgH;

void setup() {
  src = loadImage("portrait.jpg");
  size(src.width*2, src.height, P3D);
  noStroke();
  imgW = src.width;
  imgH = src.height;
}

void draw() {
  background(0);
  image(src, 0, 0);
  
  lights();

  if (mouseX < width/2) {
    sampleFactor = int(max(1, mouseX*.1));
    detail = max(.2, mouseY*.005);
  }

  vecs = new PVector[round(imgH/sampleFactor)][round(imgW/sampleFactor)];
  cols = new color[round(imgH/sampleFactor)][round(imgW/sampleFactor)];

  for (int i=0, ii=0; i<imgH; i+=sampleFactor, ii++) {
    for (int j=0, jj = 0; j<imgW; j+=sampleFactor, jj++) {
      float b = brightness(src.pixels[i*imgW + j])*detail;
      if (ii<imgH/sampleFactor && jj<imgW/sampleFactor) {
        vecs[ii][jj] = new PVector(j, i, b);
        cols[ii][jj] = src.pixels[i*imgW + j];
      }
    }
  }


  translate(width-imgW/2, height/2, -255/2);
  rotateY(frameCount*PI/720);

  for (int i=0; i<vecs.length-1; i++) {
    for (int j=0; j<vecs[i].length-1; j++) {
      fill(cols[i][j]);
      beginShape();
      vertex(-imgW/2 +vecs[i][j].x, -imgH/2+vecs[i][j].y, -255/2+vecs[i][j].z);
      vertex(-imgW/2 +vecs[i][j+1].x, -imgH/2+vecs[i][j+1].y, -255/2+vecs[i][j+1].z);
      vertex(-imgW/2 +vecs[i+1][j+1].x, -imgH/2+vecs[i+1][j+1].y, -255/2+vecs[i+1][j+1].z);
      vertex(-imgW/2 +vecs[i+1][j].x, -imgH/2+vecs[i+1][j].y, -255/2+vecs[i+1][j].z);
      endShape(CLOSE);
    }
  }
}

