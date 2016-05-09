Orb[] orbs = new Orb[2];

void setup() {
  size(800, 600);
  noFill();
  for (int i=0; i<orbs.length; i++) {
    orbs[i] = new Orb(width/2, height/2, random(10, 40));
  }
}



void draw() {
  background(255);
  for (int i=0; i<orbs.length; i++) {
    orbs[i].display();
    collide(orbs[i]);
  }
}

void collide(Orb o) {
  PVector randVec = new PVector();
 
  for (int i=0; i<orbs.length; i++) {
     float r2 = o.r + orbs[i].r;
    if (o != orbs[i]) {
      float d = dist(orbs[i].x, orbs[i].y, o.x, o.y);
      if (d < orbs[i].r+o.r) {
        if (d==0) { // if pure overalp, create random vector
          float theta = random(TWO_PI);
          randVec.x = cos(theta);
          randVec.y = sin(theta);
        } else { // get collision vector
          randVec.x = o.x = orbs[i].x;
          randVec.y = o.y = orbs[i].y;
        }
        randVec.normalize();
        
        // move orbs apart along collision vector
        randVec.mult(r2); // collision vector with 2*r length
        o.x += randVec.x/2;
        o.y += randVec.y/2;
        orbs[i].x -= randVec.x/2;
        orbs[i].y -= randVec.y/2;
      }
    }
  }
}