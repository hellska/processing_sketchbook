void setup() {
  size(1024,100);
  background(255);
  smooth();
  noFill();
  stroke(0);
  float x = height/2;
  float y = width/2;
  float lastX = x;
  float lastY = y;
  for (int i=0;i<10000;i++) {
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
      if (y<0) { x = 0; }
      if (y>height) { y = height; }
      
  }
}
