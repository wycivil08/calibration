// second Processing applet
import com.shigeodayo.pframe.*;
GUIApplet guiApplet = null;
PFrame guiFrame = null;

void setupGUIApplet() {
  guiApplet = new GUIApplet();
  guiFrame = new PFrame(guiApplet, 640, 100);
  guiFrame.setTitle("Control Panel");
  guiFrame.setLocation(10, 10);

  guiApplet.init(dat);
}

private class GUIApplet extends PApplet {

  PVector imgPos = new PVector(10, 10);
  PVector imgDim = new PVector(640, 480);
  boolean imgcheck=false;

  void setup() {
    size(660, 800);
    dat=new Data();
    background(0, 0, 0);

    setupControl();
    smooth();
  }

  Data dat;
  void init(Data d) {
    dat=d;
    initControl();
  }



  void draw() {

    background(20);
    updateControl();
    image(dat.context.rgbImage(), imgPos.x, imgPos.y);   



    TextOnScreen();
  }

  int offSetX=0;
  int offSetY=0;
  int ScreenPosX=0;
  int ScreenPosY=0;


  void initControl() {
    offSetX=dat.offSetX;
    offSetY=dat.offSetY;
    ScreenPosX=dat.ScreenPosX;
    ScreenPosY=dat.ScreenPosY;
  }



  void updateControl() {

    dat.offSetX=offSetX;
    dat.offSetY=offSetY;
    dat.ScreenPosX=ScreenPosX;
    dat.ScreenPosY=ScreenPosY;

    //dat.ScreenPosX=ScreenPosX;
    //dat.ScreenPosY=ScreenPosY;
  }


  Textarea myTextarea;
  void setupControl() {
    // size(600, 400);
    setupText();
    dat.controlP5 = new ControlP5(this);
    dat.controlP5.begin();
    ControlGroup cg = dat.controlP5.addGroup("Projection Screen", 10, height-200);

    dat.controlP5.begin(cg, 0, 10);
    dat.controlP5.setColorBackground(color(50));
    dat.controlP5.setColorForeground(color(90));
    dat.controlP5.setColorActive(150);

    ScreenPosX=dat.ScreenPosX;
    ScreenPosY=dat.ScreenPosY;
    dat.controlP5.addNumberbox("ScreenPosX", dat.ScreenPosX, 250, height-200, 100, 14).setLabel("Screen Position X");
    dat.controlP5.addNumberbox("ScreenPosY", dat.ScreenPosY, 250, height-150, 100, 14).setLabel("Screen Position Y");
    dat.controlP5.addSlider("offSetX", -200, 200).linebreak().setValue(dat.offSetX);
    dat.controlP5.addSlider("offSetY", -200, 200).linebreak().setValue(dat.offSetY);



    dat.controlP5.addButton("Store", 255, width-120, height-35, 50, 25).setLabel("Save");
    dat.controlP5.addButton("Restore", 255, width-60, height-35, 50, 25).setLabel("Load");





    //dat.controlP5.hide();
    // dat.controlP5.end(cg);
    dat.controlP5.end();
  }


  //mouse events
  /////////////////////////////////////////////////////////////////////

  boolean checkIn() {
    boolean val=false;
    if ((mouseX>=imgPos.x) && (mouseX<=imgPos.x+imgDim.x) && (mouseY>=imgPos.y) && (mouseY<=imgPos.y+imgDim.y)) val=true;
    return val;
  }


  public void Store(int theValue) {  
    println("save the Setup");  
    dat.file.saveFile();
  }

  public void Restore(int theValue) {  
    println("load the Setup");  
    dat.file.loadFile();
  }



  void keyPressed()
  {  

    keyPressedUniversal(key, keyCode);
  }


  void TextOnScreen() {
    textSize(16);


    pushStyle();
    fill(255, 255, 255, 210);
    Info();

    popStyle();
  }

  void Info() {

    text("Press 'b' for BackgrundSubtraction",15,25);
    text("Christian Mio Loclair", 15, height-15);
  }
}

