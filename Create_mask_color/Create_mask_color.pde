import oscP5.*;
import netP5.*;

NetAddress supercollider;
OscP5 oscP5;

// This program for every pixel of an image determine the predominant color based 
// on fixed threshold

// Declaring a variable of type PImage
PImage source;	
// Declaring a variable of type PImage destination for the three colors
PImage dest_red;
PImage dest_green;
PImage dest_blue;
// colonne 5 > x,y,R,G,B numero di elementi variabile --> max heigth*width
int max_rows = 1024*768;
float[][] pixelArray = new float[max_rows][5];
int index = 0;
int max_elem = 5;
int elem = 0;

void setup() {
  size(1024,768);
  noLoop();
    /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  supercollider = new NetAddress("127.0.0.1",12000);
  
 // Make a new instance of a PImage by loading an image file
 // source = loadImage("/Users/dan/Pictures/Dirk-Pictures/Type8b.jpg");
  source = loadImage("/Users/dan/Pictures/calaveras/calaveritas_coloradas.jpeg");
  source.loadPixels(); 
  source.resize(1024,768);
  // Display the source image first time
  image(source,0,0);
  // The work image is created as a blank image the same size as the source.
  dest_red = createImage(source.width, source.height, RGB);
  dest_red.loadPixels();
  dest_red.resize(1024,768);
  dest_green = createImage(source.width, source.height, RGB);
  dest_green.loadPixels();
  dest_green.resize(1024,768);
  dest_blue = createImage(source.width, source.height, RGB);
  dest_blue.loadPixels();
  dest_blue.resize(1024,768);
 }  


void draw() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++ ) {
      // Calculate pixel's location 
      int loc = x + y*source.width;
      // The functions red(), green(), and blue() pull out the 3 color components
      // from a pixel.
      float source_r = red  (source.pixels[loc]);
      float source_g = green(source.pixels[loc]);
      float source_b = blue (source.pixels[loc]);
      // RED Predominant
      if ((source_r >= source_g) && (source_r >= source_b)) {
              // Make a red color and set pixel in the window
              dest_red.pixels[loc] =  color(255,0,0);
              pixelArray[index][0] = x;
              pixelArray[index][1] = y;
              pixelArray[index][2] = source_r;
              pixelArray[index][3] = source_g;
              pixelArray[index][4] = source_b;
              //println("Carico myMessage red"+ pixelArray[index][0]);
              elem =+1;
              println("elem"+ elem);
              if (elem < max_elem) {
                 myMessage.add(pixelArray[index][0]); /* add the row pixelArray to the osc message */
                 myMessage.add(pixelArray[index][1]); /* add the row pixelArray to the osc message */
                 myMessage.add(pixelArray[index][2]); /* add the row pixelArray to the osc message */
                 myMessage.add(pixelArray[index][3]); /* add the row pixelArray to the osc message */
                 myMessage.add(pixelArray[index][4]); /* add the row pixelArray to the osc message */
                 
               } //else  {
                 //x = source.width;
                 //y = source.height;
                // }
              index =+1;
           } else if ((source_g >= source_r) && (source_g >= source_b)) {
              // Make a green color and set pixel in the window
              dest_green.pixels[loc] =  color(0,255,0);
              pixelArray[index][0] = x;
              pixelArray[index][1] = y;
              pixelArray[index][2] = source_r;
              pixelArray[index][3] = source_g;
              pixelArray[index][4] = source_b;
              index =+1;
               } else if ((source_b >= source_r) && (source_b >= source_g)) {
                 // Make a blue color and set pixel in the window
                dest_blue.pixels[loc] =  color(0,0,255);
                pixelArray[index][0] = x;
                pixelArray[index][1] = y;
                pixelArray[index][2] = source_r;
                pixelArray[index][3] = source_g;
                pixelArray[index][4] = source_b;
                index =+1;
                }
          }
   }
   image(dest_red,0,0);
   saveFrame("./data/dest_red.jpg");
   
   delay(10000);
   image(dest_green,0,0);
   saveFrame("./data/dest_green.jpg");
   
   delay(1000);
   image(dest_blue,0,0);
   saveFrame("./data/dest_blue.jpg");
   
   //sendOscMessage(pixelArray);
   //oscP5.send(pixelArray[][], supercollider);
   
   /* send the message */
   oscP5.send(myMessage, supercollider); 
  
   println("This is the END");
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  theOscMessage.print();
  println(" typetag: "+theOscMessage.typetag());
}

