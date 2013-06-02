// synthetic grass simulator ~ made by hellska
// Click in the screen to change draw
// one click and be patient...

int xFrameShift, yFrameShift;
int edgeStep;
int thirdEdge;

    void setup() {
      size(600, 600);
      //Try changing edgeStep - did you notice any differendes?
      edgeStep = 800;
      thirdEdge = 20;
      noiseView(edgeStep, thirdEdge);
      xFrameShift = 0;
      yFrameShift = 0;
    }

    public void init() {
      frame.removeNotify();
//      frame.setUndecorated(true);
      frame.addNotify();
      super.init();
    }

    void draw() {
      if(frameCount == 1) frame.setLocation(xFrameShift, yFrameShift); //This does
    }
    
    void mouseReleased() {
//      xFrameShift = mouseX+xFrameShift;
//      yFrameShift = mouseY+yFrameShift;
//      frame.setLocation(xFrameShift, yFrameShift); //This does
      noiseView(mouseX, mouseY);       
      println(mouseX+" - "+mouseY);
    }
    
    void noiseView(int factor, int thirdEdge) {
      smooth();
      background(255);
      float xstart = random(10);
      float xnoise = xstart;
      float ynoise = random(10);
      for (int y = 0; y <= height+factor; y+=5) {	
      	ynoise += 0.1;
      	xnoise = xstart;     			
      for (int x = 0; x <= width; x+=5) {	
        		xnoise += 0.1;
                      drawPoint(x,y, noise(xnoise,ynoise), factor, thirdEdge);
      		int alph = int(noise(xnoise, ynoise) * 255);	
         		stroke(0, alph);
          		line(x,y, x+1, y+1);
      	}
      }
    }
    
    void drawPoint(float x,float y, float noiseFactor, int factor, int thirdEdge) { 
      pushMatrix();
      translate(x,y);
      rotate(noiseFactor * radians(540));
      float edgeSize = noiseFactor * factor;
      float grey = 150 + (noiseFactor * 120);
      float alph = 150 + (noiseFactor * 120);
      fill(46, grey, 87 ,alph);
      triangle(0,0,edgeSize, edgeSize/2, thirdEdge,thirdEdge);
//      triangle(0,0,edgeSize, edgeSize/2, 56,56);

      popMatrix();
    }
