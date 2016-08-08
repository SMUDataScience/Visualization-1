class VerletBall {

  PVector pos, posOld;
  PVector accel;
  float accelFactor;
  PVector push;
  float bounce;
  float radius;

  VerletBall(){
  }

  VerletBall(PVector pos, float accelFactor, PVector push, float radius){
    this.pos = pos;
    posOld = new PVector(pos.x, pos.y);
    accel = new PVector();
    this.accelFactor = accelFactor;
    this.push = push;
    this.radius = radius;
    pos.add(push);
  }

  void verlet(){
    PVector posTemp = new PVector(pos.x, pos.y);
    accel.x = random(-accelFactor, accelFactor);
    accel.y = random(-accelFactor, accelFactor);

    pos.x += (pos.x-posOld.x) + accel.x;
    pos.y += (pos.y-posOld.y) + accel.y;
    posOld.set(posTemp);
  }

  void render(){
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }

  void boundsCollision(){
    if (pos.x>width-radius){
      pos.x = width-radius;
      posOld.x = pos.x;
      pos.x -= push.x;
    } 
    else if(pos.x<radius){
      pos.x = radius;
      posOld.x = pos.x;
      pos.x += push.x;
    }

    if (pos.y<radius){
      pos.y = radius;
      posOld.y = pos.y;
      pos.y += push.y;
    } 
    
    if (pos.y>height-radius){
      pos.y = height-radius;
      posOld.y = pos.y;
      pos.y -= push.y;
    } 
  }



}
