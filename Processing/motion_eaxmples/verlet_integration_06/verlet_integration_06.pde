/**
 * Verlet Integration - Creatures
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 */


int formCount = 3;
VerletForm[] v = new VerletForm[formCount];



void setup() {
  size(1200, 700);
  smooth();
  noFill();
  strokeWeight(19);
  for (int i=0; i<formCount; i++) {
    v[i] = new VerletForm(new PVector(random(width), random(height)), new Dimension(50, 60), 24, 50, .2, .45);
  }
}

void draw() {
  fill(0, 30);
  rect(-1, -1,  width+1, height+1);

  for (int i=0; i<v.length; i++) {
    stroke(120, 155, 155, 105);
    fill(120, 155, 155, 105);
    v[i].render();
  }


  // collision code
  for (int i=0; i<v.length; i++) {
    for (int j=0; j<v[i].balls.length; j++) {
      checkCollision(v[i], v[i].balls[j], i);
    }
  }
}



void  checkCollision(VerletForm vf, VerletBall ball, int id) {
  PVector segVec = new PVector();
  float repulsionForce = 13;
  for (int i=0; i<v.length; i++) {
    for (int j=0; j<v[i].balls.length-1; j++) {
      if (i !=id) {
        if (j<v[i].balls.length-2) {
          segVec.x = v[i].balls[j+1].pos.x-v[i].balls[j].pos.x;
          segVec.y = v[i].balls[j+1].pos.y-v[i].balls[j].pos.y;
        } 
        else {
          segVec.x = v[i].balls[j].pos.x-v[i].balls[0].pos.x;
          segVec.y = v[i].balls[j].pos.y-v[i].balls[0].pos.y;
        }
        float segLen = segVec.mag();
        segVec.normalize();

        PVector distToSegPt0 = new PVector(ball.pos.x-v[i].balls[j].pos.x, ball.pos.y-v[i].balls[j].pos.y);
        float projectionLen = distToSegPt0.dot(segVec);

        PVector projectionVec = new PVector();
        projectionVec.set(segVec);
        projectionVec.mult(projectionLen);

        PVector collisionPt = new PVector();
        if (j<v[i].balls.length-2) {
          collisionPt.set(v[i].balls[j].pos);
        } 
        else {
          collisionPt.set(v[i].balls[0].pos);
        }
        collisionPt.add(projectionVec);

        PVector intersectVec = new PVector();
        intersectVec.set(ball.pos);
        intersectVec.sub(collisionPt);

        if (projectionLen < 0) {
          if (j<v[i].balls.length-2) {
            collisionPt.set(v[i].balls[j].pos);
          } 
          else {
            collisionPt.set(v[i].balls[0].pos);
          }
        } 
        else if (projectionLen > segLen) {
          collisionPt.set(v[i].balls[j+1].pos);
          // check for segemnt intersection
        } 
        else if (intersectVec.mag() < ball.radius) {
          PVector offset = new PVector();
          offset.set(intersectVec);
          offset.normalize();
          // fix overlap with offset
          offset.mult(ball.radius-intersectVec.mag());
          ball.pos.add(offset);

          // collision response
          PVector deltaVec = new PVector();
          deltaVec.set(v[i].loc);
          deltaVec.sub(vf.loc);
          deltaVec.normalize();

          ball.pos.x += deltaVec.x*repulsionForce;
          ball.pos.y += deltaVec.y*repulsionForce;
          v[i].balls[j].pos.x -= deltaVec.x*repulsionForce;
          v[i].balls[j].pos.y -= deltaVec.y*repulsionForce;
        }
      }
    }
  }
}



















