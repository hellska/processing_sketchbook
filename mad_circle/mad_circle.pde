int circle_size, centx, centy, diamx, diamy;
int lastx, lasty, step;

void setup() {
  size(500,500);
  stroke(0);
  smooth();
   circle_size = 50;
   centx = width/2;
   centy = height/2;
   diamx = circle_size;
   // set equal for circle
   diamy = diamx;
   step = -1;
}

void draw() {
  ellipse(centx, centy, diamx, diamy);
  pulse();
  movex();
  movey();
  
  if (centx < circle_size/2 || centx > width-(circle_size/2)) {
    centx = width/2;
  }
  if (centy < circle_size/2 || centy > height-(circle_size/2)) {
    centy = width/2;
  }
}

void pulse() {
   if (diamx == 0) {
    step *= -1;  
  }
  diamx += step;
  diamy += step;
//  println(diamx+" - "+step);
  if (diamx == 50) {
    step *= -1;  
  } 
}

void movex() {
    float test = sin(random(centx))*22;
    centx += floor(test);
}

void movey() {
   float test =  sin(random(centy))*22;
   centy += floor(test);
}
