// ellipse fundamental variables
// diametri dell'ellisse
float majAxis, minAxis, startMajAxis, startMinAxis;
// raggi dell'ellisse
int a, b;
// coordinate del centro dell'ellisse
int Xc, Yc;
// coordinate di ciascun punto dell'ellisse (calcolate)
int Xt, Yt;
// incremento dell'angolo per il calcolo delle coordinate dei punti dell'ellisse
int t;
// Inclinazione dell'ellisse (angolo tra asse x e diametro majDiam)
float phi, startPhi;
// variabili per incremento parametri
float majAxisStep, minAxisStep, phiStep;
int angleStep;
// larghezza riga 
float weight, dustWeight;

// temporary variable
int lastX;
int lastY;
int count;
int generatevalue;

boolean noDraw, singleRound, ellipseLine, ellipseDust, ellipseNumbered;

void drawEllipse() {
   phi = phi + 0.04;
   majAxis += majAxisStep;
   minAxis += minAxisStep;
   ellipseParam(majAxis, minAxis);
   invertChangeDimension(majAxis, minAxis);
// set angle equal to zero when reach 2pi
   if ( t >= 360+angleStep) {
     t = 0;
     singleRound = false; 
//     println(millis()-starTime);
  }
// verify if draw is enabled - on ellipse caracteristic change
  if ( noDraw==false) {
    Xt = floor(Xc + (a*cos(radians(t))*cos(radians(phi))) - (b*sin(radians(t))*sin(radians(phi))));
    Yt = floor(Yc + (a*cos(radians(t))*sin(radians(phi))) - (b*sin(radians(t))*cos(radians(phi))));
    ellipseDrawSettings();
    singleRoundStrokeWeight(t);
// prevent from drawing line from the last point of ellipse to new ellipse
    if (lastX == 0.0) {
      lastX = Xt;
      lastY = Yt;
    }
// drawing functions
if (ellipseLine == true) {
    line(lastX, lastY, Xt, Yt);
}
// create dust around current line
if (ellipseDust == true) {
    dust();
}
if (ellipseNumbered == true) {
ellipseNumbers(Xt, Yt);
}

// save last drawn ellipse point 
    lastX = Xt;
    lastY = Yt;
// increase angle to calculate next poin
    t = t+angleStep;
  }
}

// dripping effect based on calculated ellipse points (no way to recreate identical effect)
void dust() {
  strokeWeight(3);
  int pixelX = Xt - lastX;
  int pixelY = Yt -lastY;
// random calculate dust density
  float cicli = random(dustWeight)+1;
  for (int i=0; i<cicli; i++) {

// calculate random color each cycle to obtain more natural effect
     r = random(95)+160;      // use those for red dust
     stroke(r,14,18, 50);    // 
     
// others stroke color style
//     stroke(r,g,cb, 50);     // colored dust
//     stroke(r,33,54, 50);    // red and blue dust (interesting effect)

     point(Xt+random(pixelX), Yt+random(pixelY));
     point(Xt+random(pixelX), Yt-random(pixelY));
     point(Xt-random(pixelX), Yt+random(pixelY));
     point(Xt-random(pixelX), Yt-random(pixelY));
     point(lastX+random(pixelX), lastY+random(pixelY));     
     point(lastX+random(pixelX), lastY-random(pixelY));     
     point(lastX-random(pixelX), lastY+random(pixelY));     
     point(lastX-random(pixelX), lastY-random(pixelY));     
  }
}

// re-set drawing settings after each single singleRoundStrokeWeight() function
void ellipseDrawSettings() {
    int colore = 255;
    int alph = 255;
    stroke(colore, alph);
    strokeWeight(3);
}

// draw a single step of the ellipse with different color and stroke and send an OSC message to SC
void singleRoundStrokeWeight(int curAngle) {
  if (singleRound==false) {
    if (curAngle >= generatevalue) {
      strokeWeight(4);
      weight = 1;
      singleRound = true;
//      println("single round stroke weight");
      r = random(255);
      g = random(255);
      cb = random(255);
//      stroke(r,33,54, 100);    
// blue stroke
      cb = random(135)+120;
      stroke(8, 10, cb, 120);
      generatevalue = int(random(50)+70);
      float freq = random(5.0);
      
      if ( send == true) {
      // put a control var here
      singleStrokeOSCMsgSnd(freq);
      }
    }
  }
}

// re-set ellipse radius each increase/decrease of diameter
void ellipseParam(float aDiam, float bDiam) {
  majAxis = aDiam;
  minAxis = bDiam;
  a = floor(majAxis/2);
  b = floor(minAxis/2);
}

// change scsynth frequency each complete ellipse
void singleStrokeOSCMsgSnd(float freq) {
  float freqL, freqR;
  if (freq >= 1) {
    freqL = freq;
    freqR = freq / 10.0;
  } else {
    freqL = freqR = freq; 
  }
  paramChange("treL", "freq", freqL);
  paramChange("treR", "freq", freqR);
}

// Inverte tra increase/decrease of diameter
void invertChangeDimension(float majAxis, float minAxis) {
 if (majAxis<0) { majAxisStep *= -1; }
 if (minAxis<0) { minAxisStep *= -1; }
 if (majAxis>width+width/4) { majAxisStep *= -1; }
 if (minAxis>height+height/4) { minAxisStep *= -1; } 
}
