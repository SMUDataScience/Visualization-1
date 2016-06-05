class VerletEngine {
  VerletSurface surf;
  IGSphere[] spheres;

  int sphereCount, triCount; 
  Triangle3D[] tris;

  float gravity = .3;
  PVector wind;
  float friction = .45;

  VerletEngine() {
  }

  VerletEngine(VerletSurface surf, IGSphere[] spheres) {
    this.surf = surf;
    this.spheres = spheres;
    tris = surf.getTris();
  }

  /* 
   * check spehere-sphere collision
   */
  void ballCollide() {
    for (int i=0; i<spheres.length; i++) {
      for (int j=i+1; j<spheres.length; j++) {
        float d = PVector.dist(spheres[i].loc, spheres[j].loc);
        float r2 = spheres[i].radius+spheres[j].radius;
        // spheres overlapping
        if (d<=r2) {
          // get ball motion vectors at collision
          PVector s1Vec = new PVector();
          PVector s2Vec = new PVector();
          s1Vec.set(spheres[i].spd);
          s2Vec.set(spheres[j].spd);
          s1Vec.normalize();
          s2Vec.normalize();
          PVector n = PVector.sub(spheres[i].loc, spheres[j].loc);
          n.normalize();
          PVector nudger = new PVector();
          nudger.set(n);
          nudger.mult(r2);

          // initially correct ball overlap
          PVector temp = new PVector();
          temp.set(spheres[i].loc);
          spheres[j].loc.x = temp.x-nudger.x;
          spheres[j].loc.y = temp.y-nudger.y;
          spheres[j].loc.z = temp.z-nudger.z;

          // calc relfectio based on velocity/momentum
          float a1 = PVector.dot(spheres[i].spd, n);
          float a2 = PVector.dot(spheres[j].spd, n);
          // radius is used as mass
          float p = (2.0 * (a1-a2))/(spheres[i].radius+spheres[j].radius);

          PVector vec1 = new PVector();
          vec1.set(n);
          vec1.mult(spheres[j].radius);
          vec1.mult(p);
          PVector newVec1 = PVector.sub(spheres[i].spd, vec1);

          PVector vec2 = new PVector();
          vec2.set(n);
          vec2.mult(spheres[i].radius);
          vec2.mult(p);
          PVector newVec2 = PVector.add(spheres[j].spd, vec2);

          spheres[i].spd.set(newVec1);
          spheres[j].spd.set(newVec2);
        }
      }
    }
  }

  /* 
   * check sphere-surface collision
   */
  void surfaceCollide() {
    for (int i=0; i<spheres.length; i++) {
      for (int j=0; j<tris.length; j++) {
        PVector p = new PVector();
        PVector q = new PVector();
        PVector N = tris[j].getNormal();
        p.set(spheres[i].loc);
        q.set(tris[j].v0);
        p.sub(q);
        float d = -p.dot(N);
        if(d<spheres[i].radius && barycentricCheck(spheres[i].loc, tris[j]) && d>-spheres[i].radius*4) {
          // move ground
            deformSurface(spheres[i], tris[j]);
            PVector ground = findsurface(spheres[i], tris[j], d);
         
            spheres[i].loc.y = ground.y;
            PVector reflectVec = getReflectVec(spheres[i].spd, tris[j].getNormal());
            spheres[i].spd.set(reflectVec);
            // if(spheres[i].spd.y > 0){
               deformSurface(spheres[i], tris[j]);
            // }
            spheres[i].spd.y *= spheres[i].material;
            //spheres[i].spd.mult(spheres[i].material);
            //spheres[i].spd.x *= .85;
            //spheres[i].spd.z *= .55;
            

            
        }
      }
    }
  }

  /* 
   * returns surface position
   */
  PVector findsurface(IGSphere s, Triangle3D t, float d) {
    PVector p = new PVector();
    PVector q = new PVector();
    PVector N = t.getNormal();

    PVector temp = new PVector();
    temp.set(s.loc);
    q.set(t.v1);
    while (d<s.radius) {
      temp.sub(N);
      p.set(temp);
      p.sub(q);
      d = -p.dot(N);
    }
    return temp;
  }


  /* Barycentric Technique:
   * www.blackpawn.com/texts/pointinpoly/default.html
   */
  boolean barycentricCheck(PVector p,Triangle3D tri) {	
    // Compute vectors        
    PVector v0 = PVector.sub(tri.v2, tri.v0);
    PVector v1 = PVector.sub(tri.v1, tri.v0);
    PVector v2 = PVector.sub(p, tri.v0);

    // Compute dot products
    float dot00 = PVector.dot(v0, v0);
    float dot01 = PVector.dot(v0, v1);
    float dot02 = PVector.dot(v0, v2);
    float dot11 = PVector.dot(v1, v1);
    float dot12 = PVector.dot(v1, v2);

    // Compute barycentric coordinates
    float invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01);
    float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
    float v = (dot00 * dot12 - dot01 * dot02) * invDenom;

    // Check if point is in triangle
    if ((u > 0) && (v > 0) && (u + v < 1)) {
      return true;
    }
    return false;
  }

  /* Law of Reflection
   * R = 2N(N.L)-L
   * 
   * N = Surface Normal
   * R = Reflection vector
   * L = Incidence Vector
   */
  PVector getReflectVec(PVector direction, PVector N) {
    PVector l = new PVector();
    float vecMag = direction.mag();
    l.set(direction);
    l.normalize();
    PVector r = PVector.mult(N, 2);
    float dotN = PVector.dot(N,l);
    r.mult(dotN);
    r.sub(l);
    r.mult(-1);
    r.mult(vecMag);

    return r;
  }

  /* 
   * deform surface based on ball collision
   */
  void deformSurface(IGSphere s, Triangle3D t) {
    t.v0.y += (abs(s.spd.y) * s.radius)*.05;
    t.v1.y +=  (abs(s.spd.y) * s.radius)*.05;
    t.v2.y += (abs(s.spd.y) * s.radius)*.05;
  }


  void run() {
    for (int i=0; i<spheres.length; i++) {   
      //spheres[i].spd.x=random(wind);
      //spheres[i].spd.z+=.075;
      spheres[i].spd.y+=gravity;
      spheres[i].move();
    }
    surf.start();
    ballCollide();
    surfaceCollide();
    render();
  }

  void render() {
    surf.render(false, false, true);
    for (int i=0; i<spheres.length; i++) {  
      pushMatrix();
      translate(spheres[i].loc.x, spheres[i].loc.y, spheres[i].loc.z);
      spheres[i].render();
      popMatrix();
    }

    for (int i=0; i<tris.length; i++) { 
      // tris[i].render();
      //tris[i].renderNorm(30.0);
    }
  }
}

