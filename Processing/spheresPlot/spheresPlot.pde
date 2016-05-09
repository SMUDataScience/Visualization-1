int orbCount = 20;
DataOrb[] orbs = new DataOrb[orbCount];

void setup() {
  size(1000, 900, P3D);
  //sphereDetail(2);
  for (int i=0; i<orbs.length; i++) {
    orbs[i] = new DataOrb(this, random(5, 30), "orb"+i);
  }

  noStroke();
  // no perspectival distortion
  ortho();
}

void draw() {
  background(45);
  translate(width/2, height/2);
  // 3D lighting
  ambientLight(65, 65, 65);
  emissive(10, 0, 0);
  lightSpecular(105, 105, 105);
  directionalLight(255, 255, 255, 0, 0, -1);
  specular(255, 255, 255);
  shininess(35);
  for (DataOrb orb : orbs) {
    if (!orb.isTouched()) {
      checkCollisions(orb);
    }
   // orb.move();
    orb.display();
  }
}

// orb-orb collision
void checkCollisions(DataOrb orb) {

  for (int i=0; i<orbs.length; i++) {
    if (orb != orbs[i]) {
      float span =  orb.getRadius() + orbs[i].getRadius();
      float d = dist(orb.getLoc().x, orb.getLoc().y, orbs[i].getLoc().x, orbs[i].getLoc().y);

      if (d < span) {
        PVector delta = new PVector();
        if (d == 0) {
          //nodes perfectly overlap so use random vector to shift them apart
          PVector tmp = new PVector(random(-1, 1), random(-1, 1));
          delta.set(tmp.normalize());
        } else {
          delta.set(orb.getLoc());
          delta.sub(orbs[i].getLoc()); // get collision vector between orbs
          delta.normalize(); // normalize collision vector
        }
        delta.mult(orb.getRadius()+orbs[i].getRadius());

        //  PVector delta = new PVector(.7, .65);
        delta.normalize();


        PVector p1 = orb.getLoc();
        PVector p2 = orbs[i].getLoc();

        float xs = delta.x*orbs[i].getRadius();
        float ys = delta.y*orbs[i].getRadius();
        PVector temp = new PVector();
        temp.set(p1);
        p1.x = p2.x + xs;
        p1.y = p2.y + ys;

        xs = -delta.x*orb.getRadius();
        ys = -delta.y*orb.getRadius();
        p2.x = temp.x + xs;
        p2.y = temp.y + ys;
        //p1.add(new PVector(delta.x/2, delta.y/2));
        //p2.sub(new PVector(delta.x/2, delta.y/2));

        //PVector temp = new PVector();
        //temp.set(p1);
        //p1.x = p2.x + delta.x*orb.getRadius();
        //p2.x = temp.x - delta.x*orbs[i].getRadius();
        // p1.y = p2.y + delta.y*orbs[i].getRadius();

        // p2.x = temp.x - delta.x*orb.getRadius();
        //p2.y = temp.y - delta.y*orb.getRadius();
        //p1.x = p2.x + orb.getRadius()+orbs[i].getRadius();
        //p1.y = p2.y + orb.getRadius()+orbs[i].getRadius();
      }
    }
  }
}