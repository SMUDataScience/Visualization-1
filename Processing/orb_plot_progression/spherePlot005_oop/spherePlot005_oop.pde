/*
Sphere Plot - 3D OOP
 planets JSON data
 interactive Feedback
 */

JSONArray planetsData;

Planet[] orbs;
PFont font;

void setup() {
  size(700, 725, P3D);
  noStroke();
  ortho();

  font = loadFont("ArialMT-148.vlw");
  // load JSON data
  planetsData =loadJSONArray("planets.json");
  // size arrays
  int dataSize = planetsData.size();
  orbs = new Planet[dataSize];

  color planetColor = #ff4433;

  for (int i=0; i<dataSize; i++) {
    JSONObject planet = planetsData.getJSONObject(i); 
    String planetType = planet.getString("composition");
    if (planetType.equals("fire")) {
      planetColor = #ff4433;
    } else if (planetType.equals("stone")) {
      planetColor = #334422;
    } else if (planetType.equals("ice")) {
      planetColor = #eeeeff;
    } else if (planetType.equals("water")) {
      planetColor = #3399bb;
    } else if (planetType.equals("lava")) {
      planetColor = #ff9922;
    } else if (planetType.equals("gas")) {
      planetColor = #aa55cc;
    } else if (planetType.equals("metal")) {
      planetColor = #999999;
    } else if (planetType.equals("salt")) {
      planetColor = #ffffff;
    }

    orbs[i] = new Planet(new PVector(width/2, height/2-25), planet.getFloat("mass"), planetColor, i, planetType);
  }
}

void draw() {
  background(25);
  shininess(45);
  lightSpecular(255, 255, 255);
  directionalLight(254, 254, 254, 1, 1, -1);
  specular(225, 225, 225);
  ambientLight(150, 150, 150);
  ambient(90, 90, 90);

  // orb-orb collision
  for (int i=0; i<orbs.length; i++) {
    for (int j=i; j<orbs.length; j++) {
      if (i!=j) {
        float r2 = orbs[i].radius + orbs[j].radius;
        float d = dist(orbs[i].loc.x, orbs[i].loc.y, orbs[j].loc.x, orbs[j].loc.y);
        if (d < r2) {
          if (d==0) { // avoid dist of 0
            orbs[i].loc.add(new PVector(random(-.1, .1), random(-.1, .1)));
          }
          PVector axis = PVector.sub(orbs[i].loc, orbs[j].loc);
          axis.normalize();
          PVector temp = new PVector();
          temp.set(orbs[i].loc);
          orbs[i].loc.x = orbs[j].loc.x + axis.x*r2;
          orbs[i].loc.y = orbs[j].loc.y + axis.y*r2;
          orbs[j].loc.x = temp.x - axis.x*r2;
          orbs[j].loc.y = temp.y - axis.y*r2;
        }
      }
    }
  }


  for (int i=0; i<orbs.length; i++) {
    fill(orbs[i].col);
    pushMatrix();
    translate(orbs[i].loc.x, orbs[i].loc.y, orbs[i].loc.z);
    sphere(orbs[i].radius);
    popMatrix();

    // boundary collison
    if (orbs[i].loc.x > width-orbs[i].radius) {
      orbs[i].loc.x = width-orbs[i].radius;
    } else if (orbs[i].loc.x < orbs[i].radius) {
      orbs[i].loc.x = orbs[i].radius;
    } 

    if (orbs[i].loc.y > height-orbs[i].radius) {
      orbs[i].loc.y = height-orbs[i].radius;
    } else if (orbs[i].loc.y < orbs[i].radius) {
      orbs[i].loc.y = orbs[i].radius;
    }

    // mouse detection
    if (orbs[i].isHit()) {
      orbs[i].col = #ffff00;

      // pushMatrix();
      fill(85);
      textFont(font, 23);
      String s = "  Planet ID:  " + orbs[i].id + "       Composition:  " + orbs[i].composition +"       Mass: " + orbs[i].radius;
      float w = textWidth(s);
      text(s, (width-w)/2, height-25);
      // popMatrix();
    } else {
      noStroke();
      orbs[i].resetCol();
    }
  }
}