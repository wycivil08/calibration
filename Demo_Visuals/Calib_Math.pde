/*
Basic Mathematical Function including some vector stuff ...
 4 vector to plane math
 and a principal component analysis
 */



void setupVal() {
  for (int i=0;i<dat.val.length;i++) {
    dat.val[i]  = new PVector(0, 0, 0);
  }
}

PVector calcMean(PVector[] val, int num) {
  PVector mean = new PVector(0, 0, 0);
  for (int i =0 ; i< num;i++) {
    mean.x+=val[i].x;
    mean.y+=val[i].y;
    mean.z+=val[i].z;
  }
  mean.x=mean.x/num;
  mean.y=mean.y/num;
  mean.z=mean.z/num;
  return mean;
}



float getD(PVector normalV, PVector p   ) {
  float d=0;
  normalV.normalize();
  d = normalV.dot(p);
  return d;
} 

float getDistToPlane(PVector normalV, float d, PVector ort) {
  float dist=0;

  float dist1 = normalV.x * ort.x + normalV.y * ort.y + normalV.z * ort.z;
  dist = dist1 - d; 
  return dist;
}

PVector CorrectToPlane(PVector dirV, PVector meanV, PVector posV) {
  float d = getD(dirV, meanV);
  float a = getDistToPlane(dirV, d, posV);
  PVector res= new PVector(posV.x-(dirV.x*a), posV.y-(dirV.y*a), posV.z-(dirV.z*a));
  return res;
}



PVector TransToProjection(PVector jointPos) {
  PVector res;
  jointPos = CorrectToPlane(dat.dir2, dat.mean, jointPos);


  float widthMax = dist(dat.calibScreen.xv3d[1].pos.x, dat.calibScreen.xv3d[1].pos.y, dat.calibScreen.xv3d[1].pos.z, 
  dat.calibScreen.xv3d[2].pos.x, dat.calibScreen.xv3d[2].pos.y, dat.calibScreen.xv3d[2].pos.z) ;
  float heightMax = dist(dat.calibScreen.xv3d[1].pos.x, dat.calibScreen.xv3d[1].pos.y, dat.calibScreen.xv3d[1].pos.z, 
  dat.calibScreen.xv3d[0].pos.x, dat.calibScreen.xv3d[0].pos.y, dat.calibScreen.xv3d[0].pos.z) ;


  PVector distX = new PVector(0, 0, 0);
  distX = new PVector(dat.calibScreen.xv3d[2].pos.x-dat.calibScreen.xv3d[1].pos.x, 
  dat.calibScreen.xv3d[2].pos.y-dat.calibScreen.xv3d[1].pos.y, 
  dat.calibScreen.xv3d[2].pos.z-dat.calibScreen.xv3d[1].pos.z);
  float dx = getD(distX, dat.calibScreen.xv3d[1].pos);
  float ax = getDistToPlane(distX, dx, jointPos);



  PVector distY = new PVector(0, 0, 0);
  distY = new PVector(dat.calibScreen.xv3d[1].pos.x-dat.calibScreen.xv3d[0].pos.x, 
  dat.calibScreen.xv3d[1].pos.y-dat.calibScreen.xv3d[0].pos.y, 
  dat.calibScreen.xv3d[1].pos.z-dat.calibScreen.xv3d[0].pos.z);
  float dy = getD(distY, dat.calibScreen.xv3d[0].pos);
  float ay = getDistToPlane(distY, dy, jointPos);


  res= new PVector(((int)(ax/widthMax*dat.datProjectWindow.x)), ((int)(ay/heightMax*dat.datProjectWindow.y)));

  return res;
}


PVector GetScreenJoint(int userId, int jointType1) {
  PVector ScreenV = new PVector(0, 0);
  noFill();
  if (dat.context.isTrackingSkeleton(1)) {
    PVector jointPos = new PVector();
    dat.context.getJointPositionSkeleton(userId, jointType1, jointPos);

    ScreenV = TransToProjection(jointPos);
  }

  ScreenV.x=+dat.offSetX;
  ScreenV.y=+dat.offSetY;

  return ScreenV;
}



double[] eigenvalues;





PVector GetPlaneByPoints(PVector  p1, PVector  p2, PVector  p3) {


  PVector dir1V = new PVector(p1.x-p3.x, p1.y-p3.y, p1.z-p3.z);
  PVector dir2V = new PVector(p2.x-p3.x, p2.y-p3.y, p2.z-p3.z);
  PVector normalVec=new PVector();

  normalVec = new PVector((dir1V.y*dir2V.z)-(dir1V.z*dir2V.y), 
  (dir1V.z*dir2V.x)-(dir1V.x*dir2V.z), 
  (dir1V.x*dir2V.y)-(dir1V.y*dir2V.x));



  normalVec.normalize();
  normalVec.mult(-1);
  return normalVec;
}

