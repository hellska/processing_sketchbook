// incoming messages
void oscEvent(OscMessage incomingOscMessage) {
//  print("### OSC Message Received ###");
  if (incomingOscMessage.checkAddrPattern("/column")==true) {
    float inputVal = incomingOscMessage.get(0).floatValue();
    println("Column input: "+inputVal+" testing!");
    return;
  }
  // Manage input red delay from Supercollider
  if (incomingOscMessage.checkAddrPattern("/deltaTred")==true) {
    deltaTred = incomingOscMessage.get(0).intValue();
    println("Next Red notes series sent in: "+deltaTred+" milliseconds!");
    return;
  }
  // Manage input blue delay from Supercollider
  if (incomingOscMessage.checkAddrPattern("/deltaTblue")==true) {
    deltaTblue = incomingOscMessage.get(0).intValue();
    println("Next Blue notes list sent in: "+deltaTblue+" milliseconds!");
    return;
  } 
}

// outgoing messages
void sendNoteCluster(OscMessage outgoingMessage) {
  oscP5.send(outgoingMessage, supercollider);
}

// osc message creation
//  create a message with an array of elements
void redListMessage(float[] inList) {
  float[] outList = new float[outImg.height]; 
  OscMessage floatList = new OscMessage("/red");
  arrayCopy(inList, outList, outImg.height);
  floatList.add(outList);
  oscP5.send(floatList, supercollider);
  println("Red Values List Sent!");
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
