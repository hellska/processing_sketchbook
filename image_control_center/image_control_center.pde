import oscP5.*;
import netP5.*;

PImage inImg, outImg;
OscP5 oscP5;
NetAddress supercollider, myself, sc2;

float whratio,hwratio,rescaleX,rescaleY;

// set screen resolution values to correct the image size
// according to the screen size.
// function using those variables: rescale()
int maxX = 200;
int maxY = 200;

// create 3 array to store pixel RGB values
// float[] img_red;
// float[] img_green;
// float[] img_blue;

float[] img_red = new float[maxX * maxY];
float[] img_green = new float[maxX * maxY];
float[] img_blue = new float[maxX * maxY];


void setup() {
  inImg = loadImage("LeftBrainRightBrain.jpg");
  rescale();
  outImg = inImg;
  size(inImg.width,inImg.height);
  // initialize RGB color array dimension
//  float[] img_red = new float[inImg.width * inImg.height];
  // Deafault variables
  frameRate(25);
  
  oscP5 = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1",57120);
  sc2 = new NetAddress("192.168.1.6",57120);
  myself = new NetAddress("127.0.0.1",12000);
  
  readColumn();

}

void draw() {
  image(outImg,0,0);
  outImg.loadPixels();

  
}

// read pixels data and stores RGB values into array
void readColumn() {
//  float[] img_red = new float[inImg.width * inImg.height];
  outImg.loadPixels();
  println("#### Current pixels array: "+outImg.pixels.length);
  // this randomly select an imagecolumn
  int col = int(random(outImg.height));
  // debug purpose print
  println("Selected Column: "+col+" - parsed line number: "+(outImg.height-1));
  println("image width: "+outImg.width+" - image heigth: "+outImg.height);
  for (int r = 0;r < int(outImg.height-1);r++) {
    img_red[r] = red(outImg.pixels[col * r + 1]);
    img_green[r] = green(outImg.pixels[col * r + 1]);
    img_blue[r] = blue(outImg.pixels[col * r + 1]);
  }
  redListMessage(img_red);
  greenListMessage(img_green);
  blueListMessage(img_blue);
}
// image manipulation functions
void rescale() {
 
  whratio = (float) inImg.width / (float) inImg.height;
  hwratio = (float) inImg.height / (float) inImg.width;

  if (whratio>1) {
     if (inImg.width > maxX){
       rescaleX = maxX;
       rescaleY = maxY * hwratio; 
     } else {
       rescaleX = inImg.width;
       rescaleY = inImg.height; 
     }
  } else {
    if (inImg.height > maxY) {
      rescaleY = maxY;
      rescaleX = maxX * whratio; 
    } else {
      rescaleX = inImg.width;
      rescaleY = inImg.height; 
    }
  }
  inImg.resize((int) rescaleX,(int) rescaleY);
  
}
