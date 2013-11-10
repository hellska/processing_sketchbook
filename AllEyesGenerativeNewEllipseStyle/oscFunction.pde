// communication beween processing and Supercollider
import netP5.*;
import oscP5.*;

NetAddress sc;
OscP5 osc;

void paramChange(String synth, String params, float freq) {
  OscMessage msg= new OscMessage("/oo");
  msg.add(synth);
  msg.add("set");
  msg.add(params);
  msg.add(freq);
  osc.send(msg, sc); 
}
