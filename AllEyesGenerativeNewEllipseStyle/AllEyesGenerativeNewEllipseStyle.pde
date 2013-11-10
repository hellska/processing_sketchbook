// color management
float r, g, cb;
// control drawing values
boolean isEllipse, isCubes, fadeToBlack, send ;
float nextTransTime;
int starTime, fadeCount;
String info;

void setup() {
//  size(800,500);
  size(1920, 1080);
// to enable full screen
//  frame.setResizable(true);
//  size(displayWidth, displayHeight);
// frame size for 1080p video out
//  size(1920, 1080);

  background(0); 
  smooth();
  frameRate(25);

// OSC communication settings
  osc= new OscP5(this, 12000);
  sc= new NetAddress("127.0.0.1", 57120);
// variable setup
  generatevalue = int(random(50)+70);
  angleStep = 5;  
  count = 1;
  weight = 1;
  noDraw = false;
  singleRound = false;
// draw ellipse using line
  ellipseLine = false; 
// draw ellipse using dust
  ellipseDust = true;
// draw numbers in ellipse points
  ellipseNumbered = false;

  dustWeight = 4.0;
// ellipse diameter use even values
  majAxisStep = -0.10;
  minAxisStep = -0.10;

// doodling values
//  majAxisStep = -5;
//  minAxisStep = -5;

  majAxis = width;
  minAxis = height;
  a = floor(majAxis/2);
  b = floor(minAxis/2);
  Xc = width/2;
  Yc = height/2;
  phi = 0;
  startPhi = phi;
// ellipse base drawing
  stroke(180, 90);
  strokeWeight(6);
  noFill();

// general parametric form of first ellipse
  t = 0;
  int ics = int(random(width/2)+width/2);
  int ipsilon = int(random(height/2)+height/2);
  // store information for video print if requested
  startMajAxis=ics;
  startMinAxis=ipsilon;
  starTime=millis();
  // ###
  println("Initial values for ellipse- majAxis: "+ics+" - minAxis:"+ipsilon);
  ellipseParam(ics, ipsilon);

// cubesLinesGrid setup
  widthStep = 10;
  heightStep = 10;
  start = false;  
  gridX = width / widthStep;
  gridY = height / heightStep;
// END cubesLinesGrid setup

// set starting shapes appliing true
isEllipse = true;
isCubes = false;

// set the first transition time
//  nextTransTime = random(50000)+250000;
//  println("transition time in ms: "+nextTransTime+" - minutest: "+int(((nextTransTime/1000)/60))+" - sec: "+int((nextTransTime/1000)));
  println("NO transition set in this version!");

  info = hour()+":"+minute()+":"+second();
  
  // OSC block
  send = false;
  
}

void draw() {
// check if transition must occur
//  if (millis()>=nextTransTime) {
//    setTransition();
//  }
// draw ellipse
  if (isEllipse==true) {
// generative ellipse with dust
  drawEllipse();
  }
  if (isCubes==true) {
// draw cubesLinesGrid
   noisYblock();
   fallingBlock();
  }
  if (fadeToBlack==true) {
   fadeToBlack(fadeCount);
   fadeCount++; 
  }
// manage keybord shortcuts
  keyOperation();
//      frameWriter();  
}

void keyOperation() {
   if (keyPressed==true) {
      if (key == 'e') {
        noDraw = true;
      }
    } else {
      noDraw = false;  
    }
}

void keyReleased() {
        if (key == 's') {
         if (send == true){
          send = false;
         } else { 
          send = true;
         }
        }
        if (key == 'e') {
        int ics = int(random(width));
        int ipsilon = int(random(height));
        phi = int(random(360));
        startMajAxis=ics;
        startMinAxis=ipsilon;
        starTime=millis();
        println("Recalc ellipse- majAxis: "+ics+" - minAxis:"+ipsilon+" inclination angle: "+phi+" - start ms: "+starTime);
        lastX = 0;
        ellipseParam(ics, ipsilon);
      }
      if (key == 'f') {
        saveFrame("./frames/AllEyesGenerative-#####.png");
        println("file saved to disk");   
      }
      if (key == 'm') {
        println(millis());
      }
      if (key == 't') {
        if (isEllipse) {
          isEllipse = false;
        } else {
          background(0);
          isEllipse = true;
        }
        if (isCubes) { 
          isCubes = false;
        } else {
          isCubes = true;
        }
      }
      if (key == 'k'){
       int now = millis();
       int msec = now % 1000;
       int sec = (now / 1000) % 60;
       int min = (now / 1000) / 60;
       int hour =  ((now / 1000) / 60) / 60;
       println("Sketch Duration in millis ("+now+") - real time(h:m:s.ms): "+hour+":"+min+":"+sec+"."+msec);
       exit();
      }
      if (key == 'i'){
        info = "Ellipse x Axis: "+startMajAxis+" y Axis: "+startMinAxis+" rotate angle: "+startPhi+", start ms: "+starTime;
        float rectWidth = textWidth(info) + 2;
        
        translate(10, height-2);
        rotate(0);
        
        fill(0);
        noStroke();
        rect(1, height-14, rectWidth, 14);
        textSize(11);  
        fill(255);
        text(info , 0, 0); 
        println(info);
      }
      if (key == '1') {
        fadeToBlack = true;
        isEllipse = false;
      }
      if (key == '2') {
       if (ellipseDust == false){
         ellipseDust = true;
       } else {
         ellipseDust = false;
       }
      }
       if (key == '3') {
       if (ellipseLine == false){
         ellipseLine = true;
       } else {
         ellipseLine = false;
       }
      }
       if (key == '4') {
       if (ellipseNumbered == false){
         ellipseNumbered = true;
       } else {
         ellipseNumbered = false;
       }
      }
}
void setTransition() {
        if (isEllipse) {
          isEllipse = false;
        } else {
          background(0);
          isEllipse = true;
        }
        if (isCubes) { 
          isCubes = false;
        } else {
          isCubes = true;
        }
        nextTransTime += random(50000)+250000;  
        println("transition time in ms: "+nextTransTime+" - minutest: "+int(((nextTransTime/1000)/60))+" - sec: "+int((nextTransTime/1000)));
}

void frameWriter() {
  saveFrame("../frames/AllEyesGenerative/jpg/#####.jpg");
}
