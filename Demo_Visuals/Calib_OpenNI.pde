/* --------------------------------------------------------------------------
**   BUILD ON TOP OF SIMPLE OPENNI by MAX RHEINER
*/

import SimpleOpenNI.*;


void setupNI()
{
  dat.context = new SimpleOpenNI(this,SimpleOpenNI.RUN_MODE_MULTI_THREADED);


    // recording
    // enable depthMap generation 
    if (dat.context.enableDepth() == false)
    {
      println("Can't open the depthMap, maybe the camera is not connected!"); 
      exit();
      return;
    }

    // enable ir generation
    if (dat.context.enableRGB() == false)
    {
      println("Can't open the rgbMap, maybe the camera is not connected or there is no rgbSensor!"); 
      exit();
      return;
    }



  dat.context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  // enable the scene, to get the floor
  dat.context.enableScene();
  dat.context.alternativeViewPointDepthToImage();

}

