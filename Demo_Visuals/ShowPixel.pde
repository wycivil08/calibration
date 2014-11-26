float[][] background = new float[640][480];


void setupBackground() {
for (int i=0;i<640;i++) {
  for (int j =0;j<480;j++ ) {
    background[i][j]=0;  
  }
 }  
}

void backGroundSub() {

 int n = 0;
  int[]   depthMap = dat.context.depthMap();
  int     steps   = 1;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
  
  int userCount = dat.context.getNumberOfUsers();
  int[] userMap = null;
  if (userCount > 0)
  {
    userMap = dat.context.getUsersPixels(SimpleOpenNI.USERS_ALL);
  }
  pushStyle();
  for (int y=0;y < dat.context.depthHeight();y+=steps)
  {
    for (int x=0;x < dat.context.depthWidth();x+=steps)
    {
      index = x + y * dat.context.depthWidth();
      if (depthMap[index] > 0)
      { 

      //  if (userMap != null && userMap[index] != 0)
      //  {  // calc the user color
          realWorldPoint = dat.context.depthMapRealWorld()[index];
       
        //  realWorldPoint = TransToProjection(realWorldPoint);

          background[x][y]=realWorldPoint.z;

        /*  //strokeWeight(10);
          stroke(255, 0, 0); 
          strokeWeight(5);
         // point(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
          point(realWorldPoint.x,height- realWorldPoint.y);*/
      //  }
      }
    }
  }
  popStyle();
  
}



void DrawPix() {
  background(0);
  stroke(255);
 int n = 0;
  int[]   depthMap = dat.context.depthMap();
  int     steps   = 3;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
  
  translate(dat.offSetX,dat.offSetY);
  int userCount = dat.context.getNumberOfUsers();
  int[] userMap = null;
  if (userCount > 0)
  {
    userMap = dat.context.getUsersPixels(SimpleOpenNI.USERS_ALL);
  }
  pushStyle();
  for (int y=0;y < dat.context.depthHeight();y+=steps)
  {
    for (int x=0;x < dat.context.depthWidth();x+=steps)
    {
      index = x + y * dat.context.depthWidth();
      if (depthMap[index] > 0)
      { 

      //  if (userMap != null && userMap[index] != 0)
      //  {  // calc the user color
          realWorldPoint = dat.context.depthMapRealWorld()[index];
       if (abs(background[x][y]-realWorldPoint.z)>10) {
          realWorldPoint = TransToProjection(realWorldPoint);

          

          //strokeWeight(10);
          stroke(255, 0, 0); 
          strokeWeight(5);
         // point(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
          point(width-realWorldPoint.x,height- realWorldPoint.y);
        }
      //  }
      }
    }
  }
  popStyle();
}
