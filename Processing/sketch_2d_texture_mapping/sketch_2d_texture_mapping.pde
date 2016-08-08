// 2D texture mapping Example
PImage img;

void setup(){
  size(800, 600, P2D);
  img = loadImage("earth.jpg");
  int pts = 36;
  float theta = 0, r = 200;
  translate(width/2, height/2);
  beginShape();
  texture(img);
  textureWrap(REPEAT); 
  textureMode(NORMAL);
  for(int i=0; i<pts; i++){
    float x = cos(theta);
    float y = sin(theta);
    vertex(x*r, y*r, (x+1)/2, (y+1)/2);
    theta += TWO_PI/pts;
  }
  endShape(CLOSE);
}