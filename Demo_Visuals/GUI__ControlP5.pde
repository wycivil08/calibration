/*
control P5 Function to control the offset to adjust little calibration errors
 only in CalibrationMod=false;
 */
PrintWriter output;

import controlP5.*;

void keyPressedUniversal(int key, int keyCode) {
  switch(key)
  {
  case ' ':
    dat.context.setMirror(!dat.context.mirror());
    break;
  case 'm':
    dat.State=(dat.State+1)%3;
    break;


  case 'i': 
    dat.InformationPanel=!dat.InformationPanel;
    println(dat.InformationPanel);
    break;
  case 'p':
    dat.usePCA=!dat.usePCA;

    break;
  case 'l':
    dat.file.loadFile();
    break;

  case 's':
    dat.file.saveFile();


    break;
  
  
    case 'b':
    backGroundSub();


    break;
  }
}


//Keyinput
////////////////////////////////////////////////////////////////////////////
void keyPressed()
{  

  keyPressedUniversal(key, keyCode);
}


PFont font;

void  setupText() {
  //font = loadFont("ArialMT-16.vlw");
  font = createFont("Courier", 24, true);
  textFont(font); 
  textSize(16);
  textMode(SCREEN);
}

