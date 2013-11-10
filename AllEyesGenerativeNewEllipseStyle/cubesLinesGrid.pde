int widthStep;
int heightStep;
int gridX, gridY;
boolean start;
int blockX, blockY;
int blockStep;

void noisYblock() {
  fill(255);
  noStroke();
  float freq = random(gridX)*widthStep;
  rect(int(freq), random(gridY)*heightStep, widthStep, heightStep);
  // send OSC message to SC every frame
  cubesOSCMsgSnd(freq);
}

void fallingBlock() { 
  if (start==true) {

  fill(0, 0, 0, 5);
  rect(0, 0, width, height); 
  
    stroke(0);
    noStroke();
    fill(255, 0, 0, 200);
    rect(blockX, blockY-blockStep, widthStep, heightStep);
    blockStep -= 2;
    // end of falling block
    if ((blockY-blockStep)>height) {
      start = false;
      blockStep=0;
//    color fade ...
//    fill(0, 0, 0, 5);
//    rect(0, 0, width, height);      
    }
  } else {
    blockX = int(random(gridX))*widthStep;
    blockY = int(random(gridY))*heightStep;
    start = true;
  }
}

void cubesOSCMsgSnd(float freq) {
  freq = map(freq, 0, width, 130, 241);
  paramChange("fm12", "freq", freq);
  paramChange("fm22", "freq", freq+5);
  paramChange("bass1", "freqL", freq/2);
  paramChange("bass1", "freqR", freq/2);
}

