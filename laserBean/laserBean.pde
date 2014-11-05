// global variable
  int incr;

void setup() {
  size(640, 360);
  background(0);
  frameRate(50);
  noSmooth();
}

void draw() {
  background(0, 0, 0, 0);
//  for (int i = 0; i < width; i+=3) {
//    float r = random(255);
//    float g = random(255);
//    float b = random(255);
//    float w = random(width);
//    float h = random(height);
//
//    stroke(0,g,0);
//    strokeWeight(1);
//    
//    if (mouseX<=width/2) {
//      incr = int((width/2)-mouseX*(float) i/width);
//    } else {
//      incr = int(mouseX*(float) i/width);
//    }
//    println(incr);
//    point(width/2+incr,i);
//  }
  float g = random(255);
  strokeWeight(1);
  stroke(0,g,0);
  line(width/2,0,mouseX,height);
}
