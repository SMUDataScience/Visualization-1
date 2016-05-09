PImage heightMap, colorMap;
float planeWidth;
float planeHeight;
PVector[][]vecs;

void setup() {
  size(1600, 1000, P3D);

  noStroke();
  fill(255);
  heightMap = loadImage("mountainMap.jpg");
  colorMap = loadImage("mountainColorMap.jpg");
  planeWidth = heightMap.width;
  planeHeight = heightMap.height;

  vecs = new PVector[int(planeHeight)][int(planeWidth)];

  heightMap.loadPixels();
  for (int i=0; i<planeHeight; i++) {
    for (int j=0; j<planeWidth; j++) {
      vecs[i][j] = new PVector(-planeWidth/2+j, -brightness(heightMap.pixels[i * int(planeWidth) + j])*.25, -planeHeight/2+i);
    }
  }
}

void draw() {
  background(0);
  translate(width/2, height/2, 600);
  rotateX(-45*PI/180);
  rotateY(frameCount*.3*PI/180);
 
  ambientLight(85, 85, 85);
  emissive(20, 0, 0);
  lightSpecular(255, 255, 255);
  pointLight(255, 255, 255, 100, -100, 400);
  specular(255, 255, 255);
  shininess(100);


  textureMode(IMAGE);
  beginShape(QUADS);
  texture(colorMap);
  for (int i=0; i<planeHeight-1; i++) {
    for (int j=0; j<planeWidth-1; j++) {
      vertex(vecs[i][j].x, vecs[i][j].y, vecs[i][j].z, i, j);
      vertex(vecs[i+1][j].x, vecs[i+1][j].y, vecs[i+1][j].z, i+1, j);
      vertex(vecs[i+1][j+1].x, vecs[i+1][j+1].y, vecs[i+1][j+1].z, i+1, j+1);
      vertex(vecs[i][j+1].x, vecs[i][j+1].y, vecs[i][j+1].z, i, j+1);
    }
  }
  endShape();
}