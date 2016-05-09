/*
Sphere Plot - 3D Procedural plot
 planets JSON data
 interactive Feedback
 */

JSONArray planetsData;

PVector[] orbs;
float[]radii;
color[]cols, origCols;
int[] ids;
String[] comp;

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
  orbs = new PVector[dataSize];
  radii = new float[dataSize];
  cols = new color[dataSize]; 
  origCols = new color[dataSize]; 
  ids = new int[dataSize];
  comp = new String[dataSize];

  color planetColor = #ff4433;
  for (int i=0; i<dataSize; i++) {
    // start all orbs in the middle
    orbs[i] = new PVector(width/2, height/2-25);

    JSONObject planet = planetsData.getJSONObject(i); 

    //radius based on mass
    radii[i] = planet.getFloat("mass"); 

    ids[i] = planet.getInt("id");

    // color based on planet composition type
    String planetType = comp[i] = planet.getString("composition");

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
    cols[i] = planetColor;
    origCols[i] = planetColor;
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
    for (int j=1+1; j<orbs.length; j++) {
      if (i!=j) {
        float r2 =  radii[i] + radii[j];
        float d = dist(orbs[i].x, orbs[i].y, orbs[j].x, orbs[j].y);
        if (d < r2) {
          if (d==0) { // avoid dist of 0
            orbs[i].add(new PVector(random(-.1, .1), random(-.1, .1)));
          }
          PVector axis = PVector.sub(orbs[i], orbs[j]);
          axis.normalize();
          PVector temp = new PVector();
          temp.set(orbs[i]);
          orbs[i].x = orbs[j].x + axis.x*r2;
          orbs[i].y = orbs[j].y + axis.y*r2;
          orbs[j].x = temp.x - axis.x*r2;
          orbs[j].y = temp.y - axis.y*r2;
        }
      }
    }
  }


  for (int i=0; i<orbs.length; i++) {
    fill(cols[i]);
    pushMatrix();
    translate(orbs[i].x, orbs[i].y, orbs[i].z);
    sphere(radii[i]);
    popMatrix();

    // boundary collison
    if (orbs[i].x > width-radii[i]) {
      orbs[i].x = width-radii[i];
    } else if (orbs[i].x < radii[i]) {
      orbs[i].x = radii[i];
    } 

    if (orbs[i].y > height-radii[i]) {
      orbs[i].y = height-radii[i];
    } else if (orbs[i].y < radii[i]) {
      orbs[i].y = radii[i];
    }

    // mouse detection
    if (dist(mouseX, mouseY, orbs[i].x, orbs[i].y) < radii[i]) {
      cols[i] = #ffff00;

      //   pushMatrix();
      fill(85);
      textFont(font, 23);
      String s = "  Planet ID:  " + ids[i] + "       Composition:  " + comp[i] +"       Mass: " + radii[i];
      float w = textWidth(s);
      text(s, (width-w)/2, height-7);
      // popMatrix();
    } else {
      noStroke();
      cols[i] = origCols[i];
    }
  }
}