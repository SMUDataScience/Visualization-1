IJGSphere s;

void setup(){
  size(800, 800, P3D);
   s = new IJGSphere(this, new RGBA(120, 120, 120, 255), "stone.jpg", 240, 12,12);
   noStroke();
  //stroke(255);
}


void draw() {
  background(0);
  ambientLight(85, 85, 85);
  emissive(30, 0, 0);
  lightSpecular(255, 255, 255);
  pointLight(255, 255, 255, -100, -100, 800);
  pointLight(150, 150, 150, -100, 100, 800);
  specular(255, 255, 255);
  shininess(20);

  pushMatrix();
  translate(width/2, height/2, -1000);
  rotateX(PI/3);
  rotateZ(frameCount*PI/1360);
  scale(20.2, 20.2);
 // p.display();
  popMatrix();

  pushMatrix();
  translate(width/2, height/2.75, 0);
 // rotateY(frameCount*PI/520);
  rotateX(-PI/2);
  s.display();
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      s.setSmooth(true);
    } else if (keyCode == DOWN) {
      s.setSmooth(false);
    }
  }
}