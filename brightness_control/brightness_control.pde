
//Writing to another PImage object's pixels

// Declaring a variable of type PImage source and destination
PImage source;	
PImage destination;
float threshold = 100;
int startT = millis();
int deltaT = 500;
int summ = -5;
float seed = random(5); 
  
void setup() {
  size(640, 360);
  frameRate(25);
  // Make a new instance of a PImage by loading an image file
  //source = loadImage("/Users/dan/Pictures/calaveras/calaveritas_coloradas.jpeg");
  source = loadImage("/Users/dan/Pictures/Dirk-Pictures/from \'The Wood\'.jpg");
  //source = loadImage("/Users/dan/Pictures/Dirk-Pictures/Bos8B.jpg");
  source.resize(640, 360);
  // The destination image is created as a blank image the same size as the source.
  destination = createImage(source.width, source.height, RGB);
  source.loadPixels();
  destination.loadPixels();
  brightControl();
}  

void draw() {  
  
  int now = millis();

  if (now >= startT + deltaT) {

    threshold += (noise(seed) * 10) + summ;
    println(threshold);
    if (threshold<=10 && summ == -5) summ = 5;
    if (threshold>=200 && summ == 5) summ = -5;    
    
    brightControl();
  
    startT = millis();
    seed += 0.1;
  }

}

void keyReleased() {
  if (key == 'n') threshold += 5;
  if (key == 'd') threshold -= 5;
  if (key == 't') deltaT += 50;
  if (key == 'y') deltaT -= 50;
} 

void brightControl() {
  
    // We are going to look at both image's pixels
  source.loadPixels();
  destination.loadPixels();
  
  for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) < threshold) {
        destination.pixels[loc]  = color(255);  // White
      }  else {
        destination.pixels[loc]  = color(0);    // Black
      }
    }
  }

  // We changed the pixels in destination
  destination.updatePixels();
  // Display the destination
  image(destination,0,0);
  
}
