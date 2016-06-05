class TimeBomb {

  PVector loc = new PVector();
  Dimension3D dim = new Dimension3D(2, 2, 2);
  float mass = 1;

  PVector launchVec;
  float launchSpd;

  PVector spd;
  PVector accel;
  float gravity;
  float damping;

  boolean isWindy;
  PVector wind = new PVector(0, 0, random(1.5, 3.2));

  TimeBomb() {
    init();
  }

  TimeBomb(PVector loc, Dimension3D dim) {
    this.loc = loc;
    this.dim = dim;
    init();
  }

  TimeBomb(PVector loc, Dimension3D dim, float mass) {
    this.loc = loc;
    this.dim = dim;
    this.mass = mass;
    init();
  }

  void init() {
    sphereDetail(12);
    spd = new PVector();
    accel = new PVector();
    gravity = .04;
    damping = .55;
  }

  void setPhysics(PVector spd, float gravity, float damping) {
    this.spd = spd;
    this.gravity = gravity;
    this.damping = damping;
  }

  void launch() {
    fill(220, 30, 30);
    //spd.x += wind.x;
    accel.y += gravity;
    spd.add(accel);
    loc.add(spd);
    if (isWindy) {
      loc.add(wind);
    }
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    sphere(dim.w);
    popMatrix();
  }

  void setCollision(Dimension3D surf) {
    if (loc.y > surf.h-14) {
      loc.y = surf.h-14;
      spd.y*=-1;
    }
  }
}

