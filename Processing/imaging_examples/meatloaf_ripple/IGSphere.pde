class IGSphere {
  PVector loc;
  PVector initLoc;
  float radius = 4;
  PVector spd;
  int detail = 12;
  float material;
  color fillCol;

  IGSphere() {
    loc = new PVector();
    initLoc = new PVector();
    material = random(.9, .99);
  }

  IGSphere(PVector loc, float radius) {
    this.loc = loc;
    this.radius = radius;
    material = random(.4, .75);
    init();
  }

  IGSphere(PVector loc, float radius, int detail) {
    this.loc = loc;
    this.radius = radius;
    this.detail = detail;
    material = random(.2, .65);
    init();
  }

  IGSphere(PVector loc, float radius, int detail, float material) {
    this.loc = loc;
    this.radius = radius;
    this.detail = detail;
    this.material = material;
    init();
  }

  void init() {
    sphereDetail(detail);
    initLoc = new PVector();
    initLoc.set(loc);
    spd = new PVector(0/*random(-5, 5)*/, 0, 0);
    fillCol = color(65, 65, 85);
  }


  void move() {
    loc.add(spd);
  }

  void render() {
    fill(fillCol);
    sphere(radius);
  }
  
  void setfill(color fillCol){
    this.fillCol = fillCol;
  }
}

