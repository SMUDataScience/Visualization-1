// include required Processing classes
import processing.core.PApplet;
import processing.core.PVector;

public class DataOrb {

  private PApplet p;
  private float radius;
  private String label;
  private PVector loc = new PVector(); //default
  private double data;

  private PVector spd = new PVector(2.1f, 2.1f);

  private  boolean touched;

  public DataOrb() {
  }

  public DataOrb(PApplet p, float radius, String label) {
    this.p = p;
    this.radius = radius;
    this.label = label;
  }

  public void move() {

    // built-in attraction/detection
    if (!touched) {
      // origin attraction
      if (loc.x > 0) {
        loc.x -= spd.x;
      } else if (loc.x < 0) {
        loc.x += spd.x;
      }

      if (loc.y > 0) {
        loc.y -= spd.y;
      } else if (loc.y < 0) {
        loc.y += spd.y;
      }

      // boundary detection
      if (loc.x > p.width/2-radius) {
        loc.x = p.width/2-radius;
      } else if (loc.x < -p.width/2+radius) {
        loc.x = -p.width/2+radius;
      }

      if (loc.y > p.height/2-radius) {
        loc.y = p.height/2-radius;
      } else if (loc.y < -p.height/2+radius) {
        loc.y = -p.height/2+radius;
      }
    }
  }


  public void display() {
    p.fill(200-radius*4.5f, radius*3.5f, radius*5.5f);
    p.pushMatrix();
    p.translate(loc.x, loc.y);
    p.sphere(radius);
    //p.ellipse(0, 0, radius*2, radius*2);
    p.popMatrix();
  }


  // begin getters/setter
  public void setP(PApplet p) {
    this.p = p;
  }

  public void setRadius(float radius) {
    // ensure radius is at least default radius of 10
    this.radius = radius >= 5  ? radius : 5;
  }

  public float getRadius() {
    return radius;
  }

  public void setLabel(String label) {
    // ensure radius is at least default radius of 10
    this.label = label.length() > 0  ? label : "Untitled";
  }

  public String getLabel() {
    return label;
  }

  public void setLoc(PVector loc) {
    this.loc = loc;
  }

  public PVector getLoc() {
    return loc;
  }

  public boolean isTouched() {
    if (p.dist(p.mouseX-p.width/2, p.mouseY-p.height/2, loc.x, loc.y) < radius && p.mousePressed) {
      touched = true;
      loc.x = p.mouseX-p.width/2;
      loc.y = p.mouseY-p.height/2;
      return true;
    } 
    touched = false;
    return  false;
  }
}