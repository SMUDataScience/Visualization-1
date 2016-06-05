// Lincoln Transform
PImage src, dest;
float halfW, halfH;
int f = 5;
void setup() {
  src = loadImage("portrait.jpg");
  size(src.width*2, src.height);
  
  dest = createImage(src.width, src.height, RGB);
  halfW = src.width/2.0;
  halfH = src.height/2.0;
}

void draw() {
  // draw original image
  image(src, 0, 0);
  for (int i=0;i<src.height;i++) {
    for (int j=0;j<src.width;j++) {
      float r = floor(dist(j, i, mouseX, mouseY));
      float theta = atan2(i-mouseY, j-mouseX);
      float d = degrees(theta);
      int x = mouseX+int(cos(radians(int(d/f)*f))*int(r/f)*f);
      int y = mouseY+int(sin(radians(int(d/f)*f))*int(r/f)*f);
      dest.pixels[src.width*i + j] = src.pixels[constrain(y*src.width+x, 0, src.pixels.length-1)];
    }
  }
  translate(width/2, 0);
  dest.updatePixels();
  
   // draw transformed image
  image(dest, 0, 0);
}

