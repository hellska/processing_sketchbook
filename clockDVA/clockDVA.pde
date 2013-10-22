// clock D V A 
PFont font;
int ore, minuti, secondi;
int startTime, stepTime;
boolean reset;
int step;

void setup() {
  font = loadFont("OCRAStd-48.vlw");
  textFont(font, 48);
  size(800, 600);
  background(0);
  reset = true;
  stepTime= 1000;
  step = 1000;
  mouseControlGuiInit();
  fill(250, 2, 2);
  textSize(12);
  text("premi il mouse e trascina la barra bianca per settare la velocità del clock", 30, 193); 
  text("premi il tasto r per sincronizzare il clock e resettare la velocità", 30, 180);

}

void draw() {
  clock();
}

void clock() {
   if (reset == true){
    ore = hour();
    minuti = minute();
    secondi = second();
    startTime = millis();
    reset = false;
   }
   int now = millis();
//   int step = 1000; // tweak
   step = mouseControl();

   if (now > startTime + step) {
    secondi += 1;
    startTime = now;
    if (secondi == 60){
     minuti += 1; 
     secondi = 0;
    }
    
    if (minuti == 60){
     ore += 1;
     minuti = 0;
     secondi = 0; 
    }
    if (ore == 24){
     ore = 0;
     minuti = 0;
     secondi = 0;      
    }
    clockView(ore, minuti, secondi); 
   }
}

void clockView(int h, int m, int s) {
  String second, minute, houors;
  // change string in two digit
  second = twoDigit(str(s), 2);
  minute = twoDigit(str(m), 2);
  houors =  twoDigit(str(h), 2);
  // format clock view
  int size = 56;  // tweak
  textSize(size);
  String info = houors+":"+minute+":"+second;
  // draw back rectangle
  float rectWidth1 = textWidth(info) + 2;
  fill(0);
  noStroke();
  rect(1, height-size-4, rectWidth1+4, height);
  // draw text
  translate(10, height-2);
  rotate(0);
  fill(3, 9, 252, 255);
  
  text(info , 0, 0);
}

String twoDigit(String in, int digit){
  String out, tmp;
  tmp = "";
  int secw = in.length();
  int digit1 = digit - secw;
  
  for (int i=0; i < digit1; i++) {
    tmp = "0"+tmp;
  }
  
  if (secw < digit) {
    out = tmp + in;
  } else {
    out = in;
  }
  return out; 
}

void keyReleased() {
 if (key == 'r'){
   println("Reset utente");
   step = 1000;
   reset = true;
   mouseControlGuiInit();
 } 
}
