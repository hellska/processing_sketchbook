int gridX = 10;
int gridY = 10;
int imagesNo = gridX * gridY;
boolean rrimage = false;

PImage[] imageCaleid = new PImage[imagesNo];

void caleidos() {
  int pointX = 0;
  int pointY = 0;
  int deltaX = floor(inputImg.width / gridX);
  int deltaY = floor(inputImg.height / gridY);
  for (int i=1;i<=gridX;i++) {
  // control with mouse
    if (rrimage) {
      pointX = int(random(mouseX-deltaX/2)) + pointX;
      pointY = int(random(mouseY-deltaY/2)) + pointY;
    } else {
      pointX = int(random(deltaX)+mouseX)-deltaX/2;
      pointY = int(random(deltaY)+mouseY)-deltaY/2;
      //println("noooooooooo");r
    }
    // get the interested image part
    imageCaleid[0] = inputImg.get(pointX, pointY, deltaX, deltaY); 
    image(imageCaleid[0], int(random(width)), int(random(height)));
  }
}

void mouseReleased() {
//  caleidos();
  image(inputImg, 0, 0);
}
void keyReleased() {
  if (key == 'r') rrimage = true;
  if (key == 'm') rrimage = false;
}
