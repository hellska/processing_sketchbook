// fade to black in 75 steps - to calculate time (steps / framerate)
void fadeToBlack(int count) {
 if (count < 75) {
  noStroke();
  fill (0, 0, 0, 8);
  rect(0, 0, width, height);
 } else {
  noStroke();
  fill (0, 0, 0, 255);
  rect(0, 0, width, height);   
  fadeToBlack = false;
  isEllipse = true; 
  fadeCount = 0;
  println("fine fade!");
 }
}
// ellipse point became numbers :)
void ellipseNumbers(int Xt, int Yt) {
 int number = int(random(9));
 String point = str(number);
 translate(Xt, Yt);
 rotate(t);
 fill(255);
 text(point, 0, 0);
}

