class GlowLight {
  
  float x;
  float y;
  float r;
  float t;
  
  float vx;
  float vy;
  float vt;
  
  int podnum;    // number of pods
  float podw;    // diameter of pod
  float podr;    // radius of pod from center of glowlight
  float podt;    // spacing angle between pods
  
  float podra;
  float podrb;
  float podrc;
  
  int fillstyle;
  
  int id;
  
  float timev;
  float timed;
  
  GlowLight(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
    t = random(TWO_PI);
    
    vx = 0;
    vy = 0;
    vt = 0;
    
    id = floor(random(32000));
    
    timev = 0;
    timed = random(15,75);
    
    // choose fill style
    fillstyle = floor(random(4));
    
    // choose size of perimeter pods
    podw = 1 + random(r*.3);
    
    // choose number of pods
    float omega = atan(podw/r);
    int maxnum = floor(TWO_PI/(4*omega));
    podnum = floor(random(maxnum));
    if (podnum>0) {
      
      podr = r/2 + podw*2;
      if (random(100)<50) {
        // space pods equally around circumference
        podt = TWO_PI/podnum;
      } else {
        // space pods linearly
        podt = atan(3*podw/r);
      }
    }
    
    // pod destination radii
    podra = podr;
    podrb = random(podr,podr*2);
    podrc = podrb-podra;
    
  }

  void drift() {
    x+=vx;
    y+=vy;
    
    vx+=random(-.10,.10);
    vy+=random(-.10,.10);
    
    vx*=.99;
    vy*=.99;
    
    t+=vt;
    vt+=random(-.01,.01);
    vt*=.99;
    
    // bound check
    if (x+r*2<0) x = width+r*2;
    if (x-r*2>width) x = -r*2;
    if (y+r*2<0) y = height+r*2;
    if (y-r*2>height) y = -r*2;
  }
  

  void render() {
    noStroke();
    if (fillstyle==0) {
      fill(255);
      ellipse(x,y,r,r);
    } else {
      for (int i=0;i<fillstyle;i++) {
        float weight = r*.1;
        stroke(255);
        strokeWeight(weight);
        noFill();
        ellipse(x,y,r-(i*weight*4)-weight*2,r-(i*weight*4)-weight*2);
      }
      
    }
    
    // render pods
    for (int k=0;k<podnum;k++) {
      float rr = easeInOutQuint(timev,podra,podrc,timed);
      float px = x + rr*cos(podt*k + t);
      float py = y + rr*sin(podt*k + t);
      noStroke();
      fill(255);
      ellipse(px, py, podw, podw);
      
    }
    
    timev+=1;
    if (timev>=timed) {
      float temp = podra;
      podra = podrb;
      podrb = temp;
      podrc = podrb-podra;
      
      timev = 0;
    }
      
    
  }
  
  float easeInOutQuint(float t, float b, float c, float d) {
    t /= d/2;
    if (t < 1) return c/2*t*t*t*t*t + b;
    t -= 2;
    return c/2*(t*t*t*t*t + 2) + b;
  }
  
}
