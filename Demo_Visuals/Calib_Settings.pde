/*
The CalibArea class to configure the 4 corners of the
 a) Orientation of Wall
 b) the screen dimension
 */



void setupCalib() {
  dat.calibArea= new CalibArea();
  dat.calibScreen = new CalibArea();
}

class CalibArea {


  int ctrl=0;
  int ctrlA=0;   

  float dx=0;
  float dy=0;


  public PVector[] xv = new PVector[4];
  public Calc3dPos[] xv3d = new Calc3dPos[4];
  public Calc3dPos mouse3d = new Calc3dPos();


  CalibArea() {
    xv[0]= new PVector(640/10, 480/10); 
    xv[1]= new PVector(640/10, 480-480/10);
    xv[2]= new PVector(640-640/10, 480-480/10);
    xv[3]= new PVector(640-640/10, 480/10);


    for (int i=0;i<4;i++) {
      xv3d[i]=new Calc3dPos();
    }
  }

  void hover(int MouseX, int MouseY, boolean mouseHeld, int a) {

    float distance=100000;
    int ctrlV=0;
    if (!mouseHeld) {
      for (int i =0;i<4;i++) {
        if (dist(MouseX, MouseY, xv[i].x, xv[i].y) <distance) {
          ctrlV=i;
          ctrlA=ctrlV;
          distance = dist(MouseX, MouseY, xv[i].x, xv[i].y);
        }
      }
    }
    else {
      ctrlV=ctrl;

      // ctrlA=ctrlV;
    }
  }


  void adjust(int MouseX, int MouseY) {


    float distance=100000;


    for (int i =0;i<4;i++) {
      if (dist(MouseX, MouseY, xv[i].x, xv[i].y) <distance) {
        ctrl=i;
        distance = dist(MouseX, MouseY, xv[i].x, xv[i].y);
        dx=xv[i].x-MouseX;
        dy=xv[i].y-MouseY;
      }
    }
    ctrlA=ctrl;
  }


  void moveM(int x, int y) {
    xv[ctrl].x=x+dx;
    xv[ctrl].y=y+dy;
  }  



  boolean in_or_out_of_polygon( int x, int y)
  {
    int[] X = new int[xv.length];
    int[] Y = new int[xv.length];

    for (int i=0;i<xv.length;i++) {
      X[i]=transX((int)xv[i].x);
      Y[i]=transY((int)xv[i].y);
    }



    int i, j;
    boolean c = false;
    for (i = 0, j = X.length-1; i < X.length; j = i++)
    {

      if (( ((Y[i]<=y) && (y<Y[j])) || ((Y[j]<=y) && (y<Y[i])) ) &&
        (x < (X[j] - X[i]) * (y - Y[i]) / (Y[j] - Y[i]) + X[i]))
        c = !c;
    }
    return c;
  }


  void update(PVector Pointv, int x, int y) {

    updateItem(mouse3d, Pointv, x, y, mouseX, mouseY);
    for (int i=0;i<4;i++) {
      updateItem(xv3d[i], Pointv, x, y, (int)xv[i].x, (int)xv[i].y);
    }
  }


  void updateItem(Calc3dPos calc, PVector Pointv, int xworld, int yworld, int xitem, int yitem) {
    xitem=transX(xitem);
    yitem=transY(yitem);
    if (dist(xworld, yworld, xitem, yitem) < calc.distV) {
      calc.enterVal(Pointv, xworld, yworld);
    }
  }

  int transX(int x) {
    int res=0;
    res=x*640/640;
    return res;
  }

  int transY(int y) {
    int res=0;
    res=y*480/480;
    return res;
  }

  void finish(int a) {
    mouse3d.setVal();

    if (a>0) {


      for (int i=0;i<4;i++) {
        xv3d[i].setVal();
        if (dat.State==1)  xv3d[i].pos = CorrectToPlane(dat.dir2, dat.mean, xv3d[i].pos);

        pushStyle();
        fill(255, 255, 255);

        xv3d[i].drawVal();
        popStyle();
      }
    }
  }

  void draw() {
    for (int i=0;i<4;i++) {

      pushStyle();
      fill(255, 255, 255);

      xv3d[i].drawVal();
      popStyle();
    }
  }

  /* 
   calculate the 3D Pos of the draggable Elements
   */

  class Calc3dPos {

    int numR=0;
    float distV=50;
    PVector[] xr = new PVector[100000];
    PVector pos=new PVector(0, 0, 0);


    Calc3dPos() {
      resetVal();
    }

    void enterVal(PVector Pointv, int x, int y) {


      xr[numR] = Pointv; 
      numR++;
    }

    void resetVal() {
      for (int i=0; i<xr.length;i++) {
        xr[i] = new PVector(0, 0, 0);
      }
      numR=0;
    }


    void setVal() {
      PVector result = new PVector();
      result=calcMean(xr, numR);

      numR=0;
      resetVal();
      pos=result;
    }

    void drawVal() {
      pushStyle();
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      noFill();
      if ((pos.z>1500)&& (pos.z<10000)) {

        stroke(0, 255, 0);
        fill(0, 255, 0, 30);
      }
      else {
        stroke(255, 0, 0);
        fill(255, 0, 0, 200);
      }

      box(50, 50, 50);
      popMatrix();
      popStyle();
    }
  }
}













