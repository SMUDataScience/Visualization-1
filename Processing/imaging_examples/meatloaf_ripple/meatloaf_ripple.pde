/** 
 * Verlet Sheet Example
 * Prototype for "Ripple in Time" App
 * By: Ira Greenberg 
 * December 2010
 */

import processing.opengl.*;

VerletSurface surf;
VerletEngine eng;
int sphereCount = 30;
IGSphere[] spheres = new IGSphere[sphereCount];


void setup() {
  size(600, 600, P3D);
  //background(255);
  //background(loadImage("sky_600.jpg"));
  noFill();
  noStroke();
  boolean[] edgeFlags = {
    true, true, true, true
  };
  surf = new VerletSurfaceRect(new PVector(), new Dimension3D(600, 0, 500), 16, 16, edgeFlags, .45);
  for (int i=0; i<sphereCount; i++) {
    spheres[i] = new IGSphere(new PVector(random(-80, 80), -500+random(0, 15), -100+random(-80, 80)), random(3, 13), 8, .75 );
  }
  eng = new VerletEngine(surf, spheres);

  VerletBall[] vBalls = surf.getVBalls();
  for (int i=0; i<vBalls.length; i++) {
    // println(vBalls[i].pos);
  }
} 

void draw() {
  background(loadImage("sky_600.jpg"));
  lights();

  lightSpecular(204, 204, 204); 
  directionalLight(102, 102, 102, 0, 0, -1); 
  specular(255, 255, 255); 
  shininess(5.0); 
  translate(width/2, 270, -180);
  rotateX(-55*PI/180);
  eng.run();


  /* PVector[]  vNorms = surf.getVNorms();
   for(int i=0; i<vNorms.length; i++) {
   println(vNorms[i]);
   }
   */
  if (mousePressed) {
    surf.applyForce(mouseX, mouseY, 50, 20);
  }
}

