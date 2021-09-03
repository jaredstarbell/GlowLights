// Glow Lights
//   Jared S Tarbell
//   April 23, 2016
//   Elfego residence
//   Albuquerque, New Mexico

GlowLight[] glows;
int num = 0;
int max = 1000;

float tv = 0;

void setup() {
  fullScreen();
  //size(1000,1000);
  //smooth(8);
  background(0);
  
  makeGlows();
}

void draw() {
  background(0);
  for (int i=0;i<num;i++) {
    glows[i].drift();
    glows[i].render();
  }
  
  tv+=.01;
  if (tv>1) tv = 0;
  
  //saveFrame("#####.tga");
}


void makeGlows() {
  int g = 20;
  glows = new GlowLight[max];
  float spcx = width/g;
  float spcy = height/g;
  for (int xx=0;xx<g;xx++) {
    for (int yy=0;yy<g;yy++) {
      float sz = 4 + pow(random(1.1,3),3);
      glows[num] = new GlowLight(spcx/2+spcx*xx,spcy/2+spcy*yy,sz);
      num++;
    }
  }

}
