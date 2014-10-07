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
void floatListMessage(float[] inList) {
  println(inList[34]+" - "+inList.length); 
  OscMessage floatList = new OscMessage("/col");
//  for (int i = 0;i<150;i++) {
//    floatList.add(inList[i]);
//  }
  floatList.add(inList[34]);
//  floatList.add(111);  
//  oscP5.send(floatList, supercollider);
  oscP5.send(floatList, supercollider);
//  oscP5.send(floatList, sc2);
//  oscP5.send(floatList, myself);
  
}
