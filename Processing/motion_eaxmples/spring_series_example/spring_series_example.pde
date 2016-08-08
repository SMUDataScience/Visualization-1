PVector leader;
PVector leadSpd;
PVector follower, follower2;
PVector followerSpd, followerSpd2;
float springing = .004;
float damping = .89;

void setup() {
  size(600,600);
  strokeWeight(3);
  leader = new PVector();
  leadSpd = new PVector(random(-1.5, 1.5), random(-1.5, 1.5));
  follower = new PVector();
  followerSpd = new PVector();
  
  follower2 = new PVector();
  followerSpd2 = new PVector();
}



void draw() {
  background(255);
  translate(width/2, height/2);
  lead();
  follow();
  render();
}

void lead() {
  leadSpd.add(new PVector(random(-.2, .2), random(-.2, .2)));
  leader.add(leadSpd);

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
  followerSpd.x *= damping;
  followerSpd.y *= damping;
  
  
  deltaX = follower.x-follower2.x;
  deltaY = follower.y-follower2.y;

  // create springing effect
  deltaX *= springing*1.2;
  deltaY *= springing*1.2;
  followerSpd2.x += deltaX;
  followerSpd2.y += deltaY;

  // move predator's center
  follower2.x +=  followerSpd2.x;
  follower2.y +=  followerSpd2.y;

  // slow down springing
  followerSpd2.x *= damping;
  followerSpd2.y *= damping;
}

void render() {
  stroke(150);
  line(leader.x, leader.y, follower.x, follower.y);
  noStroke();
  fill(200, 100, 0);
  ellipse(leader.x, leader.y, 5, 5);
  fill(15, 170, 255);
  ellipse(follower.x, follower.y, 13, 13);
  
  stroke(150);
  line(follower.x, follower.y, follower2.x, follower2.y);
  noStroke();
  
  fill(150, 40, 190);
  ellipse(follower2.x, follower2.y, 13, 13);
 
}

