// circle drawing pressing key 'a'
// import processing.opengl.*;

float x, y, lastX, lastY;
int elli;

void setup() {
//  size(1024,768, OPENGL);
  size(1024,768);
  frameRate(12);
  background(255);
  smooth();
  noFill();
  stroke(0);
  strokeWeight(1);
  float x = height/2;
  float y = width/2;
  float lastX = x;
  float lastY = y;
}

void draw() {
      if (keyPressed) {
        if (key == 'a') {
          stroke(0, 30);
          strokeWeight(5);
          x = random(width);
          y = random(height);
          ellipse(x ,y ,50,50);
        }
      }
      stroke(random(255), random(255), random(255), 90);
      strokeWeight(1);
      beginShape();
      curveVertex(x, y);
      curveVertex(x, y);
      curveVertex(lastX, lastY);      
      curveVertex(lastX, lastY);      
      endShape(); 
      lastX = x;
      lastY = y;
      x += sin(radians(random(360)))*20;
      y += cos(radians(random(360)))*20;
      if (x<0) { x = 0; }
      if (x>width) { x = width; }
      if (y<0) { y = 0; }
      if (y>height) { y = height; }
}

void mousePressed() {
 background(255); 
 x = mouseX;
 y = mouseY;
 lastX = x;      
 lastY = y;
}
