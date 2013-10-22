// import fullscreen.*; 
// FullScreen fs; 

// Connect to pan4sinekr.scd in Supercollider

int A=20;
int B=20;
float Afreq;
float Bfreq;
 
void setup() {
 background(255);
 size(800,600);
 smooth();
// fs = new FullScreen(this);
// noCursor();
 // setup variabili
 stroke(0); 
 osc= new OscP5(this, 12000);
 sc= new NetAddress("127.0.0.1", 57120);
 setLissajousVar();
 lissajous();
}

void draw() {
//   background(255);
//   lissajous();

}

void lissajous() {
background(255);
// Afreq=0.03;
// Bfreq=0.08;
// oscMessageSend(Afreq, Bfreq);
// int alpha = 1;
// noFill();
// beginShape(TRIANGLES);
 beginShape();
 for (int alpha = 1; alpha <= 36000; alpha = alpha+5) {
   
    //  float angle = map(alpha, 0, 360, 0, TWO_PI);
    //  float x = sin(angle*Afreq); // * cos(angle*1);
    //  float y = sin(angle*Bfreq); // * cos(angle*1);
      
      float x = (width/2) * sin(radians(alpha)*Afreq); // * cos(angle*1);
      float y = (height/2) * sin(radians(alpha)*Bfreq); // * cos(angle*1);
      // centrare l'immagine
      x = x + (width/2);
      y = y + (height/2);
      
  curveVertex(x, y);
//  vertex(x, y);
 }
 // curveVertex(firstx, firsty);
 endShape();
}
void setLissajousVar() {
  Afreq=0.03;
  Bfreq=0.08;
}

void keyReleased() {
  if (key == 'f') {
    saveFrame("ellipse_points_3-#####.png");
    println("file saved to disk");   
  } 
  if (key == 'l') {
    lissajous(); 
  }
  if (key == 's') {
    oscMessageSend(Afreq, Bfreq); 
    println(Afreq+" - "+Bfreq);
  }
  if (key == 'u'){
     Afreq += 0.01;
     lissajous();
  }
  if (key == 'j'){
     Afreq -= 0.01;
     lissajous();
  }
}
