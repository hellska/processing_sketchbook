import oscP5.*;
import netP5.*;

/* 
* osc bundle with 3 array
* array derived from image pixel inspection
* RGB value is read and sent to supercollider 
*/

PImage inputImg;
OscP5 oscP5;
NetAddress supercollider;

float whratio,hwratio,rescaleX,rescaleY;

void setup() {
  // test images
  // inputImg = loadImage("brain-990x622.png"); // x > y
  // inputImg = loadImage("1671_the_brain_cube_inuse.jpg"); // x = y
  inputImg = loadImage("hjerne2.JPG.jpg"); // x < y
  size(inputImg.width,inputImg.height);
  
  // rescale
  whratio = (float) inputImg.width / (float) inputImg.height;
  hwratio = (float) inputImg.height / (float) inputImg.width;
  println(inputImg.width);
  println(whratio);
  // fuji resolution 1366/768
  
  int maxX = 200;
  int maxY = 200;
  if (whratio>1) {
     if (inputImg.width > maxX){
       rescaleX = maxX;
       rescaleY = maxY * hwratio; 
     } else {
       rescaleX = inputImg.width;
       rescaleY = inputImg.height; 
     }
  } else {
    println("nu cazz");
    if (inputImg.height > maxY) {
      rescaleY = maxY;
      rescaleX = maxX * whratio; 
    } else {
      rescaleX = inputImg.width;
      rescaleY = inputImg.height; 
    }
  }
  inputImg.resize((int) rescaleX,(int) rescaleY);
  
  // use image size after resize ;)
  size(inputImg.width,inputImg.height);
}

void draw() { 
  image(inputImg, 0, 0);
}
