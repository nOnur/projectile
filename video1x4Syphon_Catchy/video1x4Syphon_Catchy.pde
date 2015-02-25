// code by N.Onur GUL
// Dividing screen into 4 multiple screen(screenSect) that plays 4 different videos
// plays each video according to your mouse cursor.
// When you change your cursor to different section, 
// currently playing stop itself and targeted video starts

// Add your videos under data/videos
//name your 4 files as 1.mp4/2.mp4/3.mp4/4.mp4
//or change videos under USER PREF

import codeanticode.syphon.*;
import processing.video.*;
import processing.opengl.*;
import jsyphon.*; // Syphon

Capture inputProjectile;
SyphonServer server;

Movie[] projectile = new Movie[4];

int screenSect;
int curScreenSect = 0;
float[] durationsMax = new float[4];
float[] durations = new float[4];


//----------------------------USER PREF ----------------------------
float videoSpeed = 5.0;
//Video directories
String video1 = "videos/1.mp4";
String video2 = "videos/2.mp4";
String video3 = "videos/3.mp4";
String video4 = "videos/4.mp4";


void setup() {
  
  size(640,480,OPENGL);
  background(100);
//  frameRate(60);

  //  inputProjectile=new Capture(this, 640, 480);
  //  inputProjectile.start();  

  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
  noCursor();
  
  projectile[0] = new Movie(this, video1);
  projectile[0].loop();
  projectile[1] = new Movie(this, video2);
  projectile[1].loop();
  projectile[2] = new Movie(this, video3);
  projectile[2].loop();
  projectile[3] = new Movie(this, video4);
  projectile[3].loop();

  durationsMax[0] = projectile[0].duration();
  durationsMax[1] = projectile[1].duration();
  durationsMax[2] = projectile[2].duration();
  durationsMax[3] = projectile[3].duration();
  
}


void draw() {
    
    screenSect = screenSect(mouseX, mouseY);
    curScreenSect = screenSect;
    
    image(projectile[curScreenSect], 0, 0, width, height);
    stopVideosExcept(curScreenSect);
   
   //Syphon 
    server.sendScreen();
    
  }
    
    
void stopVideosExcept(int screenSect){
        
  for(int i=0; i<projectile.length; i++)
    if(i != screenSect ){
      projectile[i].stop();
//      durations[i] = projectile[i].time();
    }
    projectile[screenSect].play();
}


int screenSect(int x, int y){
  
  int screenSect = 0;
  
  if (y < height/2){
    if(x < width/2)
      screenSect = 0;
    else
      screenSect = 1;
  }else{
    if(x < width/2)
      screenSect = 2;
    else
      screenSect = 3;
  }
  
  return screenSect;
}

void movieEvent(Movie m) {
  m.read();
}
