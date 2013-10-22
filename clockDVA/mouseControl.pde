int mouseControl() {
 int out = step;
 if ( mousePressed == true ) {      
     if (mouseY < 100 && mouseX > 40 && mouseX < width-40) {
      out = int(float(mouseX-40) * (2000.0 /float(width-40)));
      mouseControlGuiDraw();
      mouseControlGuiValue(out);
   }
 }
 return out;
}
void mouseControlGuiInit(){
  fill(30);
  noStroke();
  rect(30, 0, width-60, 100);
  fill(255);
  rect((width/2)-4, 10, 8, 80);
  fill(0);
  String out = twoDigit(str(step), 4)+"ms";
  rect(30, 101, textWidth(out), 48);
  fill(255);
  int size = 32;  // tweak
  textSize(size);
  text(out, 30, 148); 
}
void mouseControlGuiDraw() {
  fill(30);
  noStroke();
  rect(30, 0, width-60, 100);
  fill(255);
  rect(mouseX-4, 10, 8, 80);
}
void mouseControlGuiValue(int value) {
  fill(0);
  noStroke();
  String out = twoDigit(str(value), 4)+"ms";
  rect(30, 101, textWidth(out), 48);
  fill(255);
  int size = 32;  // tweak
  textSize(size);
  text(out, 30, 148); 
}
