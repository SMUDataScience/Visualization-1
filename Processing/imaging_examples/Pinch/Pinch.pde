// Pinch
PImage src, dest;
float halfW, halfH;

void setup() {
  src = loadImage("portrait.jpg"); 
  size(src.width*2, src.height);
  noStroke();
  dest = createImage(src.width, src.height, RGB);
  halfW = src.width/2.0;
  halfH = src.height/2.0;
}

void draw() {
  // draw original image
  image(src, 0, 0);
  for (int i=0;i<src.height;i++) {
    for (int j=0;j<src.width;j++) {
      float r = dist(j, i, mouseX, mouseY);
      int k = src.width*i + j;
      float theta = atan2(i-mouseY, j-mouseX);
      int x = mouseX + int(cos(theta)*sqrt(r*150));
      int y = mouseY + int(sin(theta)*sqrt(r*150));
       if (mouseX<width/2){
         dest.pixels[k] = src.pixels[constrain(y*src.width+x, 0, src.pixels.length-1)];
       }
    }
  } 
  translate(width/2, 0);
  dest.updatePixels();

  // draw transformed image
  image(dest, 0, 0);
}

