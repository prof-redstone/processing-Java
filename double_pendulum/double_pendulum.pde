float r1 = 200;
float r2 = 200;
float m1 = 20;
float m2 = 20;
float a1 = PI/4;
float a2 = PI/8;

void setup(){
  size(600, 600);
}

void draw(){
  background(250);
  stroke(0);
  strokeWeight(2);
  
  translate(300, 50);
  
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);
  
  
  line(0,0,x1,y1);
  fill(0);
  ellipse(x1,y1,m1,m1);
  
  line(x1,y1,x2,y2);
  fill(0);
  ellipse(x2,y2,m2,m2);
  
  a1 += 0.1;
  a2 -= 0.2;
  
}
