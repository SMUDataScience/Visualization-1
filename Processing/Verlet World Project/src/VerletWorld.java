import processing.core.*;

import java.util.ArrayList;

public class VerletWorld extends PApplet {

	int bgCol = 0xffddddff;
	Menu menu;
	Cage cage;

	int blockCount = 155;
	VerletBlock[] blockies = new VerletBlock[blockCount];

	int wormCount = 40;
	VerletWorm[] worms = new VerletWorm[wormCount];

	int rayCount = 35;
	VerletRay[] rays = new VerletRay[rayCount];

	int spiderCount = 15;
	VerletSpider[] spiders = new VerletSpider[spiderCount];

	public void setup() {
	 
	  cage = new Cage(new PVector(width*1.075f, height*1.07f, 700));

	  String[] labels = {
	    "worms", "rays", "blockies", "spiders", "soup"
	  };
	  int[] states = {
	    //offState, onState, overState, pressState
	    0xffeebfbb, bgCol, 0xffeeffef, 0xffffaa66
	  };
	  menu = new Menu(Layout.TOP, new Dimension(width, 23), labels, states, ButtonType.RECT);
	  //menu = new Menu(Layout.LEFT, new Dimension(65, height/4), labels, states, ButtonType.ROUNDED_RECT);
	  //menu = new Menu(Layout.BOTTOM, new Dimension(width, 23), labels, states, ButtonType.RECT);
	  //menu = new Menu(Layout.RIGHT, new Dimension(65, height), labels, states, ButtonType.RECT);
	  // How to change corner radius through explicit casting
	  //RoundedRectButton rb = (RoundedRectButton)(menu.buttons[0]);
	  //rb.cornerRadius = 12;

	  // blockies
	  for (int i=0; i<blockies.length; i++) {
	    //VerletBlock(PVector sz, float stiffness)
	    float sz = random(20, 55);
	    blockies[i] = new VerletBlock(new PVector(sz, sz, sz), random(.003f, .1f));
	    blockies[i].push(new PVector (random(-10.01f, 10.01f), random(-10.01f, 10.01f), random(-10.01f, 10.01f)));
	  }

	  //worms
	  for (int i=0; i<worms.length; i++) {
	    //VerletWorm(float len, int joints, float stiffness, float thickness)
	    worms[i] = new VerletWorm(random(250, 450), PApplet.parseInt(random(35, 65)), .7f, 2.0f);
	    worms[i].push(new PVector (random(-30.01f, 30.01f), random(-30.01f, 30.01f), random(-30.01f, 30.01f)));
	  }

	  // rays
	  for (int i=0; i<rays.length; i++) {
	    //VerletRay(int joints, float radius, float stiffness)
	    rays[i] = new VerletRay(38, random(15, 65), random(.03f, .3f));
	    rays[i].push(new PVector (random(-30.01f, 30.01f), random(-30.01f, 30.01f), random(-30.01f, 30.01f)));
	  }

	  // spiders
	  for (int i=0; i<spiders.length; i++) {
	    //VerletSpider(int legs, int joints, float radius, float stiffness)
	    spiders[i] = new VerletSpider(PApplet.parseInt(random(6, 16)), PApplet.parseInt(random(6, 16)), random(75, 125), random(.03f, .3f));
	    spiders[i].push(new PVector (random(-100.01f, 100.01f), random(-100.01f, 100.01f), random(-100.01f, 100.01f)));
	  }
	}

	public void draw() {
	  background(bgCol);

	  menu.display();

	  translate(width/2, height/2, -250);
	  //rotateY(frameCount*PI/680);
	  //rotateX(frameCount*PI/280);
	  //rotateZ(frameCount*PI/580);
	  cage.display();


	  if (menu.getSelected() == "blockies") {
	    for (VerletBlock b : blockies) {
	      b.verlet();
	      b.display();
	    }
	  } else if (menu.getSelected() == "worms") {
	    for (VerletWorm s : worms) {
	      s.verlet();
	      s.display();
	    }
	  } else if (menu.getSelected() == "rays") {
	    for (VerletRay r : rays) {
	      r.verlet();
	      r.display();
	    }
	  } else if (menu.getSelected() == "spiders") {
	    for (int i=0; i< spiders.length; i++) {
	      spiders[i].verlet();
	      spiders[i].display();
	    }
	  } else if (menu.getSelected() == "soup") {
	    for (int i=0; i<worms.length*.5f; i++) {
	      worms[i].verlet();
	      worms[i].display();
	    }
	    for (int i=0; i<rays.length*.5f; i++) {
	      rays[i].verlet();
	      rays[i].display();
	    }
	    for (int i=0; i<blockies.length*.5f; i++) {
	      blockies[i].verlet();
	      blockies[i].display();
	    }
	    for (int i=0; i<spiders.length*.5f; i++) {
	      spiders[i].verlet();
	      spiders[i].display();
	    }
	  }
	}
	class Cage {

	  PVector span;

	  Cage() {
	  }

	  Cage(PVector span) {
	    this.span = span;
	  }

	  public void display() {
	    noFill();
	    strokeWeight(1.5f);
	    stroke(255, 245, 245);
	    box(span.x, span.y, span.z);
	  }
	}
	abstract class Component {
	  PVector position;
	  Dimension dimension;
	  String label;
	  int labelCol, labelTextCol;
	  int offState, onState, overState, pressState;
	  int[] states = {
	    offState, onState, overState, pressState
	  };
	  boolean hasBorder = false;
	  boolean isSelected = false;
	  int mouseClickCount=0;

	  Component() {
	  }

	  Component(PVector position, Dimension dimension, 
	  String label, int[] states) {
	    this.position = position;
	    this.dimension = dimension;
	    this.label = label;
	    labelCol = states[0];
	    labelTextCol = 0xffffffff;
	    offState = states[0];
	    onState = states[1];
	    overState = states[2];
	    pressState = states[3];
	    this.states = states;
	  }
	  
	  //concrete method
	  public void setHasBorder(boolean hasBorder){
	    this.hasBorder = hasBorder;
	  }

	  // implement in subclasses
	  public abstract boolean isHit();
	  public abstract void display();
	}
	class Dimension {
	  float w, h;
	  
	  Dimension(){
	  }
	  
	  Dimension(float w, float h){
	    this.w = w;
	    this.h = h;
	  }
	  
	}
	class Menu {

	  Layout menuPosition;
	  ButtonType buttonType;
	  String[] labels;
	  int[] states;
	  Dimension dimension;
	  Component[] buttons;

	  Menu() {
	  }

	  Menu(Layout menuPosition, Dimension dimension, String[] labels, int[] states) {
	    this.menuPosition = menuPosition;
	    this.dimension = dimension;
	    this.labels = labels;
	    this.states = states;
	    buttons = new Component[labels.length];

	    generate();
	  }

	  Menu(Layout menuPosition, Dimension dimension, String[] labels, int[] states, ButtonType buttonType) {
	    this.menuPosition = menuPosition;
	    this.dimension = dimension;
	    this.labels = labels;
	    this.states = states;
	    this.buttonType = buttonType;
	    buttons = new Component[labels.length];

	    generate();
	  }


	  public void generate() {

	    float btnW, btnH;
	    if (menuPosition == Layout.TOP || menuPosition == Layout.BOTTOM) {
	      btnW = dimension.w/buttons.length;
	      btnH = dimension.h;
	    } else {

	      // left or right position
	      btnW = dimension.w;
	      btnH = dimension.h/buttons.length;
	    }

	    for (int i=0; i<buttons.length; i++) {
	      PVector pos;
	      Dimension dim;
	      switch (menuPosition) {
	      case TOP:
	        pos = new PVector(btnW * i, 0);
	        dim = new Dimension(btnW, btnH);
	        break; 
	      case BOTTOM:
	        pos = new PVector(btnW * i, height-btnH);
	        dim = new Dimension(btnW, btnH); 
	        break;
	      case LEFT:
	        pos = new PVector(0, btnH * i);
	        dim = new Dimension(btnW, btnH); 
	        break;
	      case RIGHT:
	        pos = new PVector(width-btnW, btnH * i);
	        dim = new Dimension(btnW, btnH); 
	        break;
	      default: // top
	        pos = new PVector(btnW * i, 0);
	        dim = new Dimension(btnW, btnH);
	      }

	      switch (buttonType) {
	      case RECT:
	        buttons[i] = new RectButton(pos, dim, labels[i], states);
	        break;
	      case ROUNDED_RECT:
	        buttons[i] = new RoundedRectButton(pos, dim, labels[i], states, 6);
	        break;
	      default:
	        buttons[i] = new RectButton(pos, dim, labels[i], states);
	      }
	    }
	  }


	  public void display() {
	    for (int i=0; i<buttons.length; i++) {
	      buttons[i].display();
	    }

	    createMenuEvents();
	  }

	  public void createMenuEvents() {
	    for (int i=0; i<buttons.length; i++) {
	      // pressed
	      if (buttons[i].isHit() && mousePressed) {
	        select(i);
	        buttons[i].labelCol = states[3];
	        // mouse over
	      } else if (buttons[i].isHit() && !buttons[i].isSelected) {
	        buttons[i].labelCol = states[2];
	         buttons[i].labelTextCol = 0xff766676;
	        // selected
	      } else if (buttons[i].isSelected) {
	        buttons[i].labelCol = states[1];
	        buttons[i].labelTextCol = 0xff766676;
	        // default
	      } else {
	        buttons[i].labelCol = states[0];
	        buttons[i].labelTextCol = 0xffffffff;
	      }
	    }
	  }
	  public void select(int isSelectedID) {
	    for (int i=0; i<buttons.length; i++) {
	      if (i==isSelectedID) {
	        buttons[i].isSelected = true;
	      } else {
	        buttons[i].isSelected = false;
	      }
	    }
	  }

	  public String getSelected() {
	    String btn;
	    for (int i=0; i<buttons.length; i++) {
	      if (buttons[i].isSelected) {
	        return buttons[i].label;
	      }
	    }
	    return "";
	  }
	}
	class RectButton extends Component {
	  PFont font;

	  RectButton(){
	  }
	  
	  RectButton(PVector position, Dimension dimension, 
	  String label, int[] states) {
	    super(position, dimension, label, states);
	    font = loadFont("ArialMT-22.vlw");
	    textFont(font, 15);
	  }

	  public boolean isHit() {
	    if (mouseX >= position.x && mouseX <= position.x + dimension.w &&
	      mouseY >= position.y && mouseY <= position.y + dimension.h) {
	      return true;
	    }
	    return false;
	  }

	  public void display() {
	    if (hasBorder) {
	      stroke(100);
	    } else {
	      noStroke();
	    }
	    fill(labelCol);
	    rect(position.x, position.y, dimension.w, dimension.h);

	    fill(labelTextCol);
	    float tw = textWidth(label);
	    textAlign(LEFT, CENTER);
	    text(label, position.x +(dimension.w-tw)/2.0f, position.y + dimension.h/2);
	  }
	}
	class RoundedRectButton extends RectButton {
	  float cornerRadius = 6;
	  
	  RoundedRectButton(){
	  }
	  
	  RoundedRectButton(PVector position, Dimension dimension, 
	  String label, int[] states, float cornerRadius) {
	    super(position, dimension, label, states);
	    this.cornerRadius = cornerRadius;
	  }
	  
	  public void display() {
	    if (hasBorder) {
	      stroke(100);
	    } else {
	      noStroke();
	    }
	    fill(labelCol);
	    rect(position.x, position.y, dimension.w, dimension.h, cornerRadius);

	    fill(labelTextCol);
	    float tw = textWidth(label);
	    textAlign(LEFT, CENTER);
	    text(label, position.x +(dimension.w-tw)/2.0f, position.y + dimension.h/2);
	  }
	}
	class VerletBall {

	  PVector pos, posOld;

	  VerletBall() {
	  }

	   VerletBall(PVector pos) {
	    this.pos = pos;
	    this.posOld  = new PVector(pos.x, pos.y, pos.z);
	  }

	  public void verlet() {
	    PVector posTemp = new PVector(pos.x, pos.y, pos.z);
	    pos.x += (pos.x-posOld.x);
	    pos.y += (pos.y-posOld.y);
	    pos.z += (pos.z-posOld.z);
	    posOld.set(posTemp);
	    
	  }
	  
	}
	class VerletBlock extends VerletObj {

	  PVector sz;

	  VerletBlock() {
	  }

	  VerletBlock(PVector sz, float stiffness) {
	    super(stiffness);
	    balls = new VerletBall[8];
	    sphereDetail(3);
	    this.sz = sz;

	    // top balls
	    balls[0] = new VerletBall(new PVector(-sz.x/2, -sz.y/2, sz.z/2)); //LF
	    balls[1] = new VerletBall(new PVector(sz.x/2, -sz.y/2, sz.z/2)); //RF
	    balls[2] = new VerletBall(new PVector(sz.x/2, -sz.y/2, -sz.z/2)); //RB
	    balls[3] = new VerletBall(new PVector(-sz.x/2, -sz.y/2, -sz.z/2)); //LB

	    // bottom balls
	    balls[4] = new VerletBall(new PVector(-sz.x/2, sz.y/2, sz.z/2)); //LF
	    balls[5] = new VerletBall(new PVector(sz.x/2, sz.y/2, sz.z/2)); //RF
	    balls[6] = new VerletBall(new PVector(sz.x/2, sz.y/2, -sz.z/2)); //RB
	    balls[7] = new VerletBall(new PVector(-sz.x/2, sz.y/2, -sz.z/2)); //LB

	    // sticks
	    // top
	    sticks.add(new VerletStick(balls[0], balls[1], stiffness, true));
	    sticks.add(new VerletStick(balls[1], balls[2], stiffness, true));
	    sticks.add(new VerletStick(balls[2], balls[3], stiffness, true));
	    sticks.add(new VerletStick(balls[3], balls[0], stiffness, true));
	    //crosses
	    sticks.add(new VerletStick(balls[0], balls[2], stiffness, false));

	    //bottom
	    sticks.add(new VerletStick(balls[4], balls[5], stiffness, true));
	    sticks.add(new VerletStick(balls[5], balls[6], stiffness, true));
	    sticks.add(new VerletStick(balls[6], balls[7], stiffness, true));
	    sticks.add(new VerletStick(balls[7], balls[4], stiffness, true));
	    //crosses
	    sticks.add(new VerletStick(balls[4], balls[6], stiffness, false));

	    // vertical rails
	    sticks.add(new VerletStick(balls[0], balls[4], stiffness, true));
	    sticks.add(new VerletStick(balls[1], balls[5], stiffness, true));
	    sticks.add(new VerletStick(balls[2], balls[6], stiffness, true));
	    sticks.add(new VerletStick(balls[3], balls[7], stiffness, true));

	    // diagnols
	    sticks.add(new VerletStick(balls[0], balls[6], stiffness, false));
	    sticks.add(new VerletStick(balls[1], balls[7], stiffness, false));
	    sticks.add(new VerletStick(balls[2], balls[4], stiffness, false));
	    sticks.add(new VerletStick(balls[5], balls[3], stiffness, false));

	    // side crosses
	    sticks.add(new VerletStick(balls[3], balls[4], stiffness, false));
	    sticks.add(new VerletStick(balls[1], balls[6], stiffness, false));
	  }

	  public void display() {

	    noFill();
	    beginShape();
	    for (VerletBall b : balls) {
	      pushMatrix();
	      translate(b.pos.x, b.pos.y, b.pos.z);
	      stroke(255, 75);
	      box(5);
	      popMatrix();
	    }


	    
	    strokeWeight(.75f);
	    stroke(185, 135, 130);
	    for (VerletStick s : sticks) {
	      s.display();
	    }
	  }
	}
	abstract class VerletObj {

	  VerletBall[] balls;
	  ArrayList<VerletStick> sticks = new ArrayList<VerletStick>();
	  float stiffness;

	  VerletObj() {
	  }

	  VerletObj(float stiffness) {
	    this.stiffness = stiffness;
	  }



	  public void push(PVector push) {
	    balls[0].pos.add(push);
	  }


	  public void verlet() {
	    for (VerletBall b : balls) {
	      b.verlet();
	    }

	    for (VerletStick s : sticks) {
	      s.constrainLen();
	    }

	    collide();
	  }

	  public void collide() {
	    float jolt = 3.0f;
	    for (VerletBall b : balls) {
	      if (b.pos.x > width/2) {
	        b.pos.x = width/2;
	        b.pos.x -= jolt;
	      } else if (b.pos.x < -width/2) {
	        b.pos.x = -width/2;
	        b.pos.x += jolt;
	      }

	      if (b.pos.y > height/2) {
	        b.pos.y = height/2;
	        b.pos.y -= jolt;
	      } else if (b.pos.y < -height/2) {
	        b.pos.y = -height/2;
	        b.pos.y += jolt;
	      }

	      if (b.pos.z > 250) {
	        b.pos.z = 250;
	        b.pos.z -= jolt;
	      } else if (b.pos.z < -250) {
	        b.pos.z = -250;
	        b.pos.z += jolt;
	      }
	    }
	  }
	}
	class VerletRay extends VerletObj {
	  int joints;
	  float radius;

	  VerletRay() {
	  }

	  VerletRay(int joints, float radius, float stiffness) {
	    super(stiffness);
	    this.joints = joints;
	    this.radius = radius;
	    balls = new VerletBall[joints];

	    float theta = 0.0f;
	    float randomDepth = random(-200, -50);
	    for (int i=0; i<joints; i++) {
	      balls[i] = new VerletBall(new PVector(cos(theta)*radius, sin(theta)*radius, randomDepth));
	      theta += TWO_PI/joints;
	    }

	    for (int i=0; i<joints; i++) {
	      if (i < joints-1) {
	        sticks.add(new VerletStick(balls[i], balls[i+1], stiffness, true));
	      } else {
	        sticks.add(new VerletStick(balls[i], balls[0], stiffness, true));
	      }
	      if (i < joints/2) {
	        sticks.add(new VerletStick(balls[i], balls[i+joints/2], stiffness, true));
	      }
	    }
	  }

	  public void display() {
//	    fill(105, 75, 105, 15);
//	    beginShape();
//	    for (VerletBall b : balls) {
//	      curveVertex(b.pos.x, b.pos.y, b.pos.z);
//	    }
//	    endShape(CLOSE);

	    strokeWeight(.75f);
	    stroke(195, 155, 195);
	    for (VerletStick s : sticks) {
	      s.display();
	    }
	  }
	}
	class VerletSpider extends VerletObj {
	  int legs;
	  int joints;
	  float radius;
	  float bodyRadius = 6;
	  float legGap = 0.0f;

	  VerletSpider() {
	  }

	  VerletSpider(int legs, int joints, float radius, float stiffness) {
	    super(stiffness);
	    this.legs = legs;
	    this.joints = joints;
	    this.radius = radius;
	    balls = new VerletBall[legs*(joints-1)+1];

	    float theta = 0.0f;
	    legGap = radius/joints;
	    // lead node
	    balls[0] = new VerletBall(new PVector(0, 0, 0));
	    for (int i=0, k=0; i<legs; i++) {
	      for (int j=1; j<joints; j++) {
	        k = i*(joints-1)+j;
	        //println(k);
	        balls[k] = new VerletBall(new PVector(bodyRadius+cos(theta)*legGap*j, bodyRadius+sin(theta)*legGap*j, 0));
	        if (j==1) {
	          sticks.add(new VerletStick(balls[0], balls[k], stiffness, true));
	        } else {
	          sticks.add(new VerletStick(balls[k-1], balls[k], stiffness, true));
	        }
	      }
	      theta += TWO_PI/legs;
	    }
	  }

	  public void display() {
	    strokeWeight(2.75f);
	    stroke(255, 195, 255);
	    for (VerletStick s : sticks) {
	      s.display();
	    }

	    //body
	    strokeWeight(1.75f);
	    pushMatrix();
	    translate(balls[0].pos.x, balls[0].pos.y, balls[0].pos.z);
	    stroke(175, 195, 175);
	    fill(0xffaabbcc);
	    sphere(legGap);
	    popMatrix();

	    strokeWeight(1.75f);
	    for (int i=0; i<balls.length; i++) {
	      pushMatrix();
	      translate(balls[i].pos.x, balls[i].pos.y, balls[i].pos.z);
	      fill(125, 135, 190, 25);
	      ellipse(0, 0, 7, 7);
	      popMatrix();
	    }
	  }
	}
	class Vec2 {
	  float x, y;

	  Vec2() {
	  }
	  Vec2(float x, float y) {
	    this.x = x;
	    this.y = y;
	  }
	}

	class VerletStick {

	  VerletBall b1, b2;
	  float stiffness;

	  PVector vecOrig;
	  float len;
	  Vec2 bias;
	  boolean isVisible;

	  VerletStick() {
	  }

	  VerletStick(VerletBall b1, VerletBall b2, float stiffness, boolean isVisible) {
	    this.b1 = b1;
	    this.b2 = b2;
	    this.stiffness = stiffness;
	    bias = new Vec2(.5f, .5f);
	    this.isVisible = isVisible;
	    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
	    len = dist(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
	  }

	  VerletStick(VerletBall b1, VerletBall b2, float stiffness, Vec2 bias, boolean isVisible) {
	    this.b1 = b1;
	    this.b2 = b2;
	    this.stiffness = stiffness;
	    this.bias = bias;
	    this.isVisible = isVisible;
	    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
	    len = dist(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
	  }


	  // constrainVal needs to be changed for anchors
	  public void constrainLen() {
	    for (int i=0; i<2; i++) {
	      PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
	      float deltaLength = delta.mag();
	      float difference = ((deltaLength - len) / deltaLength);
	      b1.pos.x += delta.x * (bias.x * stiffness * difference);
	      b1.pos.y += delta.y * (bias.x * stiffness * difference);
	      b1.pos.z += delta.z * (bias.x * stiffness * difference);
	      b2.pos.x -= delta.x * (bias.y * stiffness * difference);
	      b2.pos.y -= delta.y * (bias.y * stiffness * difference);
	      b2.pos.z -= delta.z * (bias.y * stiffness * difference);
	    }
	  }



	  public void display() {
	    if (isVisible) {
//	      beginShape();
//	      vertex(b1.pos.x, b1.pos.y, b1.pos.z);
//	      //curveVertex(b1.pos.x, b1.pos.y, b1.pos.z);
//	      //curveVertex(b2.pos.x, b2.pos.y, b2.pos.z);
//	      vertex(b2.pos.x, b2.pos.y, b2.pos.z);
//	      endShape();
	      line(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
	    }
	  }
	}
	class VerletWorm extends VerletObj {

	  float len = 175.0f;
	  int joints = 12;
	  float thickness;
	  float[] body;

	  VerletWorm() {
	  }

	  VerletWorm(float len, int joints, float stiffness, float thickness) {
	    super(stiffness);
	    this.len = len;
	    this.joints = joints;
	    this.thickness = thickness;
	    balls = new VerletBall[joints];
	    PVector randomBirthPos = new PVector(random(-len/2, len/2), random(-height/2.5f, height/2.5f), random(-150, 150));
	    float randomBodyVector = random(TWO_PI);
	    body = new float[joints];
	    float bodyGap = PI/joints;
	    for (int i=0; i<joints; i++) {
	      balls[i] = new VerletBall(new PVector(randomBirthPos.x+cos(randomBodyVector)*i*(len/(joints-1)), 
	      randomBirthPos.y+sin(randomBodyVector)*i*(len/(joints-1)), 
	      randomBirthPos.z));

	      if (i>0) {
	        sticks.add(new VerletStick(balls[i-1], balls[i], stiffness, true));
	      }
	      body[i] = abs(sin(bodyGap*i)*16);
	    }
	  }

	  public void display() {
	    // spine
	    stroke(65, 75, 155);
	    strokeWeight(thickness);
	    for (VerletStick s : sticks) {
	      s.display();
	    }
	    //body
	    stroke(125, 135, 190);
	    strokeWeight(.75f);
	    for (int i=0; i<joints; i++) {
	      pushMatrix();
	      translate(balls[i].pos.x, balls[i].pos.y, balls[i].pos.z);
	      fill(125, 135, 190, 25);
	      //noFill();
	      ellipse(0, 0, body[i], body[i]);
	      popMatrix();
	    }
	  }
	}
	  public void settings() {  
		  size(1024, 768, P3D); 
	  }
	  
	  public static void main(String[] passedArgs) {
	      PApplet.main(new String[] { "VerletWorld" });
	  }

}
