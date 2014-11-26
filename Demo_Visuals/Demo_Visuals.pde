import javax.swing.JFrame;
import processing.opengl.*;
import java.awt.Frame;
import java.awt.Color;
import javax.media.opengl.*;

import javax.media.opengl.glu.*;
import com.sun.opengl.util.*;
import java.nio.*;

Data dat;

public void init() {
  frame.removeNotify();
  frame.setUndecorated(true); 
  frame.addNotify();
  super.init();
}


void setup()
{ 

  dat=new Data();
  size(1024, 768,OPENGL);

  setupNI();
  setupGUIApplet();
  setupCalib();
  dat.file.loadFile();

}



void draw()
{
  
background(0);
  frame.setLocation(dat.ScreenPosX, dat.ScreenPosY);
  dat.context.update();

  DrawPix();  
}

