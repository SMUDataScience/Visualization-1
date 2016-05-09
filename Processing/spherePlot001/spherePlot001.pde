int ballCount = 700;
PVector[] balls = new PVector[ballCount];
float[]radii = new float[ballCount];
color[]cols = new color[ballCount]; 

void setup() {
  size(700, 700, P3D);
  background(255, 127, 245);
  noStroke();
  ortho();

  for (int i=0; i<balls.length; i++) {
    // start all ballsin the middle
    balls[i] = new PVector(width/2, height/2);
    radii[i] = random(4, 15);
    // color based on radius size
    cols[i] = color(200-radii[i]*radii[i], abs(sin(i*PI/180)*radii[i]*radii[i]), radii[i]*radii[i], 255);
  }
}

void draw() {
  background(10);
  shininess(45);
  lightSpecular(255, 255, 255);
  directionalLight(254, 254, 254, 1, 1, -1);
  specular(225, 225, 225);
  ambientLight(90, 90, 90);
  ambient(90, 90, 90);

  // orb-orb collision
  for (int i=0; i<balls.length; i++) {
    for (int j=1+1; j<balls.length; j++) {
      float r2 =  radii[i] + radii[j];
      float d = dist(balls[i].x, balls[i].y, balls[j].x, balls[j].y);
      if (d < r2) {
        if (d==0) { // avoid dist of 0
          balls[i].add(new PVector(random(-.1, .1), random(-.1, .1)));
        }
        PVector axis = PVector.sub(balls[i], balls[j]);
        float m = axis.mag();
        float m2 =  radii[i] + radii[j] - m;
        axis.normalize();
        PVector temp = new PVector();
        temp.set(balls[i]);
        balls[i].x = balls[j].x + axis.x*r2;
        balls[i].y = balls[j].y + axis.y*r2;
        balls[j].x = temp.x - axis.x*r2;
        balls[j].y = temp.y - axis.y*r2;
      }
    }
  }

  for (int i=0; i<balls.length; i++) {
    fill(cols[i]);
    pushMatrix();
    translate(balls[i].x, balls[i].y);
    sphere(radii[i]);
    popMatrix();

    // boundary collison
    if (balls[i].x > width-radii[i]) {
      balls[i].x = width-radii[i];
    } else if (balls[i].x < radii[i]) {
      balls[i].x = radii[i];
    } 

    if (balls[i].y > height-radii[i]) {
      balls[i].y = height-radii[i];
    } else if (balls[i].y < radii[i]) {
      balls[i].y = radii[i];
    }
  }
}