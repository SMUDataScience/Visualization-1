PVector leader;
PVector leadSpd;
PVector follower;
PVector followerSpd;
float springing = .01;
float springDamping = .99;

void setup() {
  size(600, 600);
  noFill();
  smooth();
  leader = new PVector();
  leadSpd = new PVector(random(-1.5, 1.5), random(-1.5, 1.5));
  follower = new PVector();
  followerSpd = new PVector();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  lead();
  follow();
  render();
  constrainBounds();
}

void lead() {
  leadSpd.add(new PVector(random(-.2, .2), random(-.2, .2)));
  leader.add(leadSpd);
}
void follow() {
  //move center point
  float deltaX = leader.x-follower.x;
  float deltaY = leader.y-follower.y;


  // create springing effect
  deltaX *= springing;
  deltaY *= springing;
  followerSpd.x += deltaX;
  followerSpd.y += deltaY;

  // move predator's center
  follower.x +=  followerSpd.x;
  follower.y +=  followerSpd.y;

  // slow down springing
  followerSpd.x *= springDamping;
  followerSpd.y *= springDamping;
}

void render() {
  stroke(100, 255);
  line(leader.x, leader.y, follower.x, follower.y);

  stroke(50, 200, 200, 255);
  ellipse(leader.x, leader.y, 5, 5);
  //fill(15, 170, 255);
  stroke(200, 20, 20, 255);
  ellipse(follower.x, follower.y, 13, 13);
}

void constrainBounds() {
  if (leader.x > 200) {
    leader.x = 200;
    leadSpd.x*=-1;
  } 
  else if (leader.x < -200) {
    leader.x = -200;
    leadSpd.x*=-1;
  }

  if (leader.y > 200) {
    leader.y = 200;
    leadSpd.y*=-1;
  } 
  else if (leader.y < -200) {
    leader.y = -200;
    leadSpd.y*=-1;
  }
}

