class VerletBall {

  PVector pos, posOld;
  PVector push;
  float radius;

  VerletBall(){
  }

  VerletBall(PVector pos,  PVector push, float radius){
    this.pos = pos;
    this.push = push;
    this.radius = radius;
    this.posOld  = new PVector(pos.x, pos.y);
    
    // start motion
    pos.add(push);
  }

  void verlet(){
    PVector posTemp = new PVector(pos.x, pos.y);
    pos.x += (pos.x-posOld.x);
    pos.y += (pos.y-posOld.y);
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



