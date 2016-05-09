class Planet {
  PVector loc;
  float radius;
  color col, origCol; 
  int id;
  String composition;

  Planet() {
  }

  Planet(PVector loc, float radius, color col, int id, String composition) {
    this.loc = loc;
    this.radius = radius;
    origCol = this.col = col;
    this.id = id;
    this.composition = composition;
  }

  void display() {
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    sphere(radius);
    popMatrix();
  }

  boolean isHit() {
    if (dist(mouseX, mouseY, loc.x, loc.y) < radius) {
      return true;
    } 
    return false;
  }
  
  void resetCol(){
    col = origCol;
  }
}