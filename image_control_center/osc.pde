// incoming messages
void oscEvent(OscMessage incomingOscMessage) {
  print("### OSC Message Received ###");
  // receive the delay time in milliseconds from supercollider
  if (incomingOscMessage.checkAddrPattern("/delay")==true) {
    int lagTime = incomingOscMessage.get(0).intValue();
    println("Next notes series in: "+lagTime+" milliseconds!");
    return;
  }
  if (incomingOscMessage.checkAddrPattern("/column")==true) {
    float inputVal = incomingOscMessage.get(0).floatValue();
    println("Column input: "+inputVal+" testing!");
    return;
  }  
}

// outgoing messages
void sendNoteCluster(OscMessage outgoingMessage) {
  oscP5.send(outgoingMessage, supercollider);
}

// osc message creation
//  create a message with an arrai of elements
void redListMessage(float[] inList) {
  float[] outList = new float[outImg.height]; 
  OscMessage floatList = new OscMessage("/red");
  arrayCopy(inList, outList, outImg.height);
  floatList.add(outList);
  oscP5.send(floatList, supercollider);  
}

void greenListMessage(float[] inList) {
  float[] outList = new float[outImg.height]; 
  OscMessage floatList = new OscMessage("/green");
  arrayCopy(inList, outList, outImg.height);
  floatList.add(outList);
  oscP5.send(floatList, supercollider);  
}

void blueListMessage(float[] inList) {
  float[] outList = new float[outImg.height];
  OscMessage floatList = new OscMessage("/blue");
  arrayCopy(inList, outList, outImg.height);
  floatList.add(outList);
  oscP5.send(floatList, supercollider);  
}
