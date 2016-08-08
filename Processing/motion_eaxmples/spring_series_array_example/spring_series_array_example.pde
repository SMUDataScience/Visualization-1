PVector leader;
PVector leadSpd;
int followerCount = 41;
PVector[] followers = new PVector[followerCount];
PVector[] followerSpds = new PVector[followerCount];
float springing = .004;
float damping = .92;

void setup() {
  size(600,600);
  strokeWeight(1);
  leader = new PVector();
  leadSpd = new PVector(random(-1.5, 1.5), random(-1.5, 1.5));
  //follower = new PVector();
  //followerSpd = new PVector();

  for (int i=0; i<followerCount; i++) {
    followers[i] = new PVector();
    followerSpds[i] = new PVector();
  }
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
  float deltaX = 0.0;
  float deltaY = 0.0;
  for (int i=0; i<followerCount; i++) {
    if (i==0) {
      deltaX = leader.x-followers[i].x;
      deltaY = leader.y-followers[i].y;
    } 
    else {
      deltaX = followers[i-1].x-followers[i].x;
      deltaY = followers[i-1].y-followers[i].y;
    }

    // create springing effect
    if (i!=0) {
      deltaX *= springing;
      deltaY *= springing;
      followerSpds[i].x += deltaX;
      followerSpds[i].y += deltaY;
    } 
    else {
      deltaX *= springing*(1 + .2*i);
      deltaY *= springing*(1 + .2*i);
      followerSpds[i].x += deltaX;
      followerSpds[i].y += deltaY;
    }

    // move predator's center
    followers[i].x +=  followerSpds[i].x;
    followers[i].y +=  followerSpds[i].y;

    // slow down springing
    followerSpds[i].x *= damping;
    followerSpds[i].y *= damping;
  }
}

void render() {

  stroke(150);
  for (int i=0; i<followerCount; i++) {
    if (i>0) {
      line(followers[i-1].x, followers[i-1].y, followers[i].x, followers[i].y);
    }
  }

  noStroke();

  for (int i=0; i<followerCount; i++) {
    fill(150, 40, 190);
    ellipse(followers[i].x, followers[i].y, 5, 5);
  }
}

