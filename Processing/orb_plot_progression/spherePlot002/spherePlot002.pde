/*
Sphere Plot 002 - 3D Procedural plot
No data
*/

int orbCount = 700;
PVector[] orbs = new PVector[orbCount];
float[]radii = new float[orbCount];
color[]cols = new color[orbCount]; 

void setup() {
  size(700, 700, P3D);
  noStroke();
  ortho();

  for (int i=0; i<orbs.length; i++) {
    // start all orbsin the middle
    orbs[i] = new PVector(width/2, height/2);
    radii[i] = random(4, 15);
    // color based on radius size
    cols[i] = color(225-radii[i]*radii[i], abs(sin(i*PI/180)*radii[i]*radii[i]), abs(cos(i*PI/180)*radii[i]+175), 255);
  }
}

void draw() {
  background(25);
  shininess(45);
  lightSpecular(255, 255, 255);
  directionalLight(254, 254, 254, 1, 1, -1);
  specular(225, 225, 225);
  ambientLight(150, 150, 150);
  ambient(90, 90, 90);

  // orb-orb collision
  for (int i=0; i<orbs.length; i++) {
    for (int j=1+1; j<orbs.length; j++) {
      float r2 =  radii[i] + radii[j];
      float d = dist(orbs[i].x, orbs[i].y, orbs[j].x, orbs[j].y);
      if (d < r2) {
        if (d==0) { // avoid dist of 0
          orbs[i].add(new PVector(random(-.1, .1), random(-.1, .1)));
        }
        PVector axis = PVector.sub(orbs[i], orbs[j]);
        float m = axis.mag();
        float m2 =  radii[i] + radii[j] - m;
        axis.normalize();
        PVector temp = new PVector();
        temp.set(orbs[i]);
        orbs[i].x = orbs[j].x + axis.x*r2;
        orbs[i].y = orbs[j].y + axis.y*r2;
        orbs[j].x = temp.x - axis.x*r2;
        orbs[j].y = temp.y - axis.y*r2;
      }
    }
  }

  for (int i=0; i<orbs.length; i++) {
    fill(cols[i]);
    pushMatrix();
    translate(orbs[i].x, orbs[i].y);
    sphere(radii[i]);
    popMatrix();

    // boundary collison
    if (orbs[i].x > width-radii[i]) {
      orbs[i].x = width-radii[i];
    } else if (orbs[i].x < radii[i]) {
      orbs[i].x = radii[i];
    } 

    if (orbs[i].y > height-radii[i]) {
      orbs[i].y = height-radii[i];
    } else if (orbs[i].y < radii[i]) {
      orbs[i].y = radii[i];
    }
  }
}