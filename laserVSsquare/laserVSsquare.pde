  // global variable
    int incr;
    int x, y;
    boolean killed = true;
    
  void setup() {
    size(640, 360);
    background(0);
    frameRate(50);
    noSmooth();
    
  }
  
  void draw() {
    if (killed) {
      target();
    }
  
    if (mousePressed) {
      println("curretn laser: "+mouseX+" - "+mouseY);
      laser();
      if ((mouseX >= x) && (mouseX <= x+20)) {
        if ((mouseY >= y) && (mouseY <= y+20)) {
          killed = true;
        }
      }
    }
    
  }
  
  void target() {
    background(0, 0, 0, 0);
    x = int(random(width));
    y = int(random(height));
    fill(255);
    stroke(0,0,0);
    rect(x, y, 20, 20);
    killed = false;
    println("curretn rect: "+x+" - "+y);
  }
  void laser() {
  //  background(0, 0, 0, 0);
    float g = random(255);
    strokeWeight(1);
    stroke(0,255,0);
    line(width/2,0,mouseX,mouseY);
  }
