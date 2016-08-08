class VerletForm {

  PVector loc;
  Dimension dim;
  int particles;
  float stiffness;
  float chaos;
  PVector push;

  VerletBall[] balls;
  VerletStick[] sticks;
  PVector[] anchor;
  VerletBall[][] hairBalls; 
  VerletStick[][] hairSticks;

  PVector[] anchors2;
  VerletBall[][] hairBalls2; 
  VerletStick[][] hairSticks2;
  int steps = 6;

  VerletForm(PVector loc, Dimension dim, int particles, int hairLength, float stiffness, float chaos) {
    this.loc = loc;
    this.dim = dim;
    this.particles = particles;
    this.stiffness = stiffness;
    this.chaos = chaos;
    balls = new VerletBall[particles];
    sticks = new VerletStick[particles + particles/2];

    // hair
    anchor = new PVector[balls.length];
    hairBalls = new VerletBall[balls.length][hairLength]; 
    hairSticks = new VerletStick[balls.length][hairLength-1];

    anchors2 = new PVector[balls.length*(steps)];
    hairBalls2 = new VerletBall[anchors2.length][hairLength];
    hairSticks2 = new VerletStick[anchors2.length][hairLength-1];


    init();
  }


  void init() {
    float theta = PI/4.0;

    // balls
    for (int i=0; i<particles; i++) {
      push = new PVector(random(1, 3.5), random(1, 3.5));
      PVector p = new PVector(loc.x+cos(theta)*dim.w, loc.y+sin(theta)*dim.h);
      balls[i] = new VerletBall(p, chaos, push, 2);
      theta += TWO_PI/particles;
    }

    // create hair balls
    //hair
    for (int i=0; i<hairBalls.length; i++) {
      anchor[i] = new PVector(balls[i].pos.x, balls[i].pos.y);
      for (int j=0; j<hairBalls[i].length; j++) {
        PVector hairNormalizedVector = new PVector();
        hairNormalizedVector.set(loc);
        hairNormalizedVector = PVector.sub(balls[i].pos, hairNormalizedVector);
        hairNormalizedVector.normalize();
        //*(1.0+.3*j)
        anchor[i] = new PVector(balls[i].pos.x+hairNormalizedVector.x, balls[i].pos.y+hairNormalizedVector.y);
         push = new PVector(random(1, 3.5), random(1, 3.5));
        hairBalls[i][j] = new VerletBall(anchor[i], chaos, push, 2);
      }
      for (int j=0; j<hairSticks[i].length; j++) {
        hairSticks[i][j] =  new VerletStick(hairBalls[i][j], hairBalls[i][j+1], stiffness);
      }
    }


    for (int i=0; i<balls.length; i++) {
      if (i<particles-1) {
        sticks[i] = new VerletStick(balls[i], balls[i+1], stiffness);
      } 
      else if (i==particles-1) {
        sticks[i] = new VerletStick(balls[i], balls[0], stiffness);
      }
    }
    for (int i=balls.length; i<sticks.length; i++) {
      sticks[i] = new VerletStick(balls[i-balls.length], balls[i-balls.length/2], stiffness);
    }
  }


  void render() {
    for (int i=0; i<balls.length; i++) {
      anchor[i].x = balls[i].pos.x;
      anchor[i].y = balls[i].pos.y;
    }

    for (int i=0; i<particles; i++) {
      balls[i].verlet();
      //balls[i].render();
    }
    for (int i=0; i<sticks.length; i++) {
      sticks[i].render();
      sticks[i].constrainLen();
    }

    // hairballs 1
    for (int i=0; i<balls.length; i+=3) {
      for (int j=0; j<hairBalls[i].length; j++) {
        hairBalls[i][j].verlet();
        /// hairBalls[i][j].render();
        //println(hairBalls[i][j].pos.x);
        //balls[i].boundsCollision();
      }
      for (int j=0; j<hairSticks[i].length; j++) {
        //stroke(50, 25);
        //stroke(200, 255);
        hairSticks[i][j].render();
        hairSticks[i][j].constrainLen();
      }
    }


    noStroke();
    int bonds = sticks.length/2;
    beginShape();
    curveVertex(balls[particles-1].pos.x, balls[particles-1].pos.y);
    for (int i=0; i<particles; i++) {
      curveVertex(balls[i].pos.x, balls[i].pos.y);
    }
    curveVertex(balls[0].pos.x, balls[0].pos.y);
    curveVertex(balls[1].pos.x, balls[1].pos.y);
    endShape(CLOSE);
  }

  PVector[] createHairBalls2() {
    float t = 0;
    float x = 0;
    float y = 0;
    int counter =0;
    PVector[] anchors = new PVector[balls.length*(steps)];
    for (int i = 0; i<balls.length; i+=3) {
      for (int j = 0; j<steps; j++) {
        t = j / float(steps);
        if (i==balls.length-3) {
          x = curvePoint(balls[i].pos.x, balls[i+1].pos.x, balls[i+2].pos.x, balls[0].pos.x, t);
          y = curvePoint(balls[i].pos.y, balls[i+1].pos.y, balls[i+2].pos.y, balls[0].pos.y, t);
        } 
        else if (i==balls.length-2) {
          x = curvePoint(balls[i].pos.x, balls[i+1].pos.x, balls[0].pos.x, balls[1].pos.x, t);
          y = curvePoint(balls[i].pos.y, balls[i+1].pos.y, balls[0].pos.y, balls[1].pos.y, t);
        } 
        else if (i==balls.length-1) {
          x = curvePoint(balls[i].pos.x, balls[0].pos.x, balls[1].pos.x, balls[2].pos.x, t);
          y = curvePoint(balls[i].pos.y, balls[0].pos.y, balls[1].pos.y, balls[2].pos.y, t);
        } 
        else {
          x = curvePoint(balls[i].pos.x, balls[i+1].pos.x, balls[i+2].pos.x, balls[i+3].pos.x, t);
          y = curvePoint(balls[i].pos.y, balls[i+1].pos.y, balls[i+2].pos.y, balls[i+3].pos.y, t);
        }
        anchors[(steps)*i + j] = new PVector(x, y);
      }
    }
    return anchors;
  }
}