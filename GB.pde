import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;
//declare global variables at the top of your sketch
//AudioContext ac; is declared in helper_functions

ControlP5 p5;
SamplePlayer sp;
SamplePlayer bing;
SamplePlayer v1;
SamplePlayer v2;
SamplePlayer v3;
Gain g;
Glide gainGlide;
Panner p;
Slider cutOffFreqSlider;
boolean played;
Textlabel label;
//Noise n;
//end global variables

//runs once when the Play button above is pressed
void setup() {
  size(600, 300); //size(width, height) must be the first line in setup()
  ac = new AudioContext(); //AudioContext ac; is declared in helper_functions 
  p = new Panner(ac);
  //Create new sample player
  sp = getSamplePlayer("sin.wav");
  bing = getSamplePlayer("bing.wav");
  v1 = getSamplePlayer("soft.wav");
  v1.pause(true);
  v2 = getSamplePlayer("medium.wav");
  v2.pause(true);
  v3 = getSamplePlayer("hard.wav");
  v3.pause(true);
  p5 = new ControlP5(this);
  played = false; 
  sp.setEndListener(
  new Bead(){
      public void messageReceived (Bead mess) {
        sp.setToLoopStart();
        sp.start();
      }
    }
  );
  label = p5.addTextlabel("status","OK LOCK YOUR AIM!",50,150);
  gainGlide = new Glide (ac, 1, 500);
  gainGlide.setValue(2);
  g = new Gain(ac, 1, gainGlide);

  cutOffFreqSlider = p5.addSlider("cutOffFreqSlider")
    .setPosition(90, 10)
    .setSize(200, 40)
    .setRange(-.9, .9)
    .setValue(0)
    .setLabel("Position");
  
  p.addInput(sp);
  //g.addInput(p);
  p.addInput(g);
  ac.out.addInput(bing);
  ac.out.addInput(p);
  ac.out.addInput(v1);
  ac.out.addInput(v2);
  ac.out.addInput(v3);
  p.setPos(0.0);
  
  bing.pause(true);
  
  p5.addButton("Soft").setPosition(width / 2 - 125, 100).setSize(50, 20).activateBy((ControlP5.RELEASE));
  
  p5.addButton("Medium").setPosition(width / 2 - 125, 150).setSize(50, 20).activateBy((ControlP5.RELEASE));
  
  p5.addButton("Hard").setPosition(width / 2 - 125, 200).setSize(50, 20).activateBy((ControlP5.RELEASE));
  
  //p5.addButton("RESET").setPosition(width / 2 - 175, 50).setSize(50, 20).activateBy((ControlP5.RELEASE));
  
  ac.start();
  
         
}

public void Soft(float value){
  println(" Soft Button Pressed");
  v1.start();
  v1.setToLoopStart();
}

public void Medium(float value){
  println(" Medium Button Pressed");
  v2.start();
  v2.setToLoopStart();
}

public void Hard(float value){
  println(" Hard Button Pressed");
  v3.start();
  v3.setToLoopStart();
}

public void RESET(float value){
  println(" RESET Button Pressed");
  p.setPos(0);
  gainGlide.setValue(0);
}

void cutOffFreqSlider(float value) {
  p.setPos(value);
  gainGlide.setValue(value);
  if (value < .1 && value > -.1){
    bing.start();
    p.pause(true);

    label.get().show();

  } else {
    p.start();
    bing.setToLoopStart();
    bing.pause(true);
    label.get().hide();
  }
}

void draw() {
  background(0);  //fills the canvas with black (0) each frame
  
}
