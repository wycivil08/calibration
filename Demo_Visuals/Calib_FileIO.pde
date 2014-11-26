/*
 this is the File IO for dat.dat.calibration...if you are a beginner then make sure
 that u dont STUDY this crap...im really sorry for the rubbish coding in this part...but for simpliciy
 i wanted to avoid any xml and the depending libs
 */
public class File {

  public File() {
  }
  String FileName="../data/calibFile/calibration.cal";

  void loadFile() {

    String[] lines;
    int indexF = 0;
    lines = loadStrings(FileName);

    String[] pieces;

    //Area
    //2D  
    for (int i=0;i<4;i++) {
      pieces = split(lines[indexF], '\t');
      dat.calibArea.xv[i].x = int(pieces[0]) ;     
      dat.calibArea.xv[i].y = int(pieces[1]) ;     
      dat.calibArea.xv[i].z = int(pieces[2]) ;
      indexF++;
    }

    //3D 
    for (int i=0;i<4;i++) {     
      pieces = split(lines[indexF], '\t');
      dat.calibArea.xv3d[i].pos.x = float(pieces[0]) ;     
      dat.calibArea.xv3d[i].pos.y = float(pieces[1]) ;     
      dat.calibArea.xv3d[i].pos.z = float(pieces[2]) ;
      indexF++;
    }

    //Screen
    //2D
    for (int i=0;i<4;i++) {   
      pieces = split(lines[indexF], '\t');
      dat.calibScreen.xv[i].x = int(pieces[0]) ;     
      dat.calibScreen.xv[i].y = int(pieces[1]) ;     
      dat.calibScreen.xv[i].z = int(pieces[2]) ;
      indexF++;
    }

    //3D  
    for (int i=0;i<4;i++) {  
      pieces = split(lines[indexF], '\t');
      dat.calibScreen.xv3d[i].pos.x = float(pieces[0]) ;     
      dat.calibScreen.xv3d[i].pos.y = float(pieces[1]) ;     
      dat.calibScreen.xv3d[i].pos.z = float(pieces[2]) ;
      indexF++;
    }

    pieces = split(lines[indexF], '\t');
    dat.mean.x = float(pieces[0]) ;     
    dat.mean.y = float(pieces[1]) ;     
    dat.mean.z = float(pieces[2]) ;
    indexF++;
    pieces = split(lines[indexF], '\t');
    dat.dir0.x = float(pieces[0]) ;     
    dat.dir0.y = float(pieces[1]) ;     
    dat.dir0.z = float(pieces[2]) ;
    indexF++;
    pieces = split(lines[indexF], '\t');
    dat.dir1.x = float(pieces[0]) ;     
    dat.dir1.y = float(pieces[1]) ;     
    dat.dir1.z = float(pieces[2]) ;
    indexF++;
    pieces = split(lines[indexF], '\t');
    dat.dir2.x = float(pieces[0]) ;     
    dat.dir2.y = float(pieces[1]) ;     
    dat.dir2.z = float(pieces[2]) ;
    indexF++;
    pieces = split(lines[indexF], '\t');
    dat.offSetX = int(pieces[0]) ;     
    dat.offSetY = int(pieces[1]) ;     
    indexF++;
    pieces = split(lines[indexF], '\t');
    dat.ScreenPosX = int(pieces[0]) ;     
    dat.ScreenPosY = int(pieces[1]) ;     
    indexF++;
  }

  void saveFile() {
    output = createWriter(FileName);

    //Area
    //2D
    for (int i=0;i<4;i++) {
      output.println(dat.calibArea.xv[i].x + "\t" + dat.calibArea.xv[i].y + "\t" + dat.calibArea.xv[i].z);
    }

    //3D 
    for (int i=0;i<4;i++) {
      output.println(dat.calibArea.xv3d[i].pos.x + "\t" + dat.calibArea.xv3d[i].pos.y + "\t" + dat.calibArea.xv3d[i].pos.z);
    }

    //Screen
    //2D
    for (int i=0;i<4;i++) {
      output.println(dat.calibScreen.xv[i].x + "\t" + dat.calibScreen.xv[i].y + "\t" + dat.calibScreen.xv[i].z);
    }

    //3D
    for (int i=0;i<4;i++) {  
      output.println(dat.calibScreen.xv3d[i].pos.x + "\t" + dat.calibScreen.xv3d[i].pos.y + "\t" + dat.calibScreen.xv3d[i].pos.z);
    }
    //dat.mean ortsVector
    output.println(dat.mean.x + "\t" + dat.mean.y + "\t" + dat.mean.z);  

    //dat.dir
    output.println(dat.dir0.x + "\t" + dat.dir0.y + "\t" + dat.dir0.z);  
    output.println(dat.dir1.x + "\t" + dat.dir1.y + "\t" + dat.dir1.z);  
    output.println(dat.dir2.x + "\t" + dat.dir2.y + "\t" + dat.dir2.z);  
    output.println(dat.offSetX + "\t" + dat.offSetY );   
    output.println(dat.ScreenPosX + "\t" + dat.ScreenPosY ); 
    output.flush(); // Write the remaining data
    output.close(); // Finish the file
  }
}

