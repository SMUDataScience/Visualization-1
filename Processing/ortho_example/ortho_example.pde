void setup() {
  size(600, 600, P3D);
}

void draw() {
  background(255);
  lights();
  if(mousePressed){
    ortho();
  } else {
    perspective();
  };
  translate(100, 100);
  rotateY(frameCount*PI/1420);
  box(100);
}