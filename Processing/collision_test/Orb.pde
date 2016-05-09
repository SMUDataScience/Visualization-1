class Orb {
  float x, y;
  float r = 50;
  
  Orb(){
  }
  
  Orb(float x, float y, float r){
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void display(){
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }
  
  void move(){
  }
}