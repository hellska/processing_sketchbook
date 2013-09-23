// communication beween processing and Supercollider
import netP5.*;
import oscP5.*;

NetAddress sc;
OscP5 osc;

void oscMessageSend(float xFreq, float yFreq) {
  paramChange("quadrofonia", "xRate", xFreq);
  paramChange("quadrofonia", "yRate", yFreq);
}

void paramChange(String synth, String params, float freq) {
  OscMessage msg= new OscMessage("/oo");
  msg.add(synth);
  msg.add("set");
  msg.add(params);
  msg.add(freq);
//  msg.add(map(freq, 0, width, 50, 800));  //freq
//  msg.add(map(mouseY, 0, height, 0.5, 0));  //amp
  osc.send(msg, sc); 
}
