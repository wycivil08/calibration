PVector projectWindow=new PVector(1024, 768);
public class Data {




  PVector datProjectWindow=new PVector(projectWindow.x, projectWindow.y);
  boolean CalibrationMode = false;  //If you want to calibrate = true ; 
  boolean       recordFlag = true;

  boolean InformationPanel = false;

  SimpleOpenNI  context;
  boolean contextReady=false;

  File file;
  // if your done calibrating and want to project = false
  int State=0; //The State of calibration ---Change with pressing m---0 Plane ;;;;; m ---1 Screen edges;!!!


  CalibArea calibArea;
  CalibArea calibScreen;

  boolean usePCA=false;
  PVector mean = new PVector(0, 0, 0);

  PVector dir0 = new PVector(0, 0, 0); //vector in plane
  PVector dir1 = new PVector(0, 0, 0); ////vector in plane
  PVector dir2 = new PVector(0, 0, 0); //this is the normal of the plane


  PrintWriter output;
  ControlP5 controlP5;


  int offSetX=0;
  int offSetY=0;
  int ScreenPosX=700;
  int ScreenPosY=100;




  PVector[] val = new PVector[360000];







  public Data() {
    contextReady=false;
    file = new File();


    calibArea= new CalibArea();
    calibScreen = new CalibArea();
  }  

  public void init() {
  }
}

