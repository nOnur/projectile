// code by N.Onur GUL
// Dividing screen into 4 multiple screen(screenSect) that plays 4 different videos
// plays each video according to your mouse cursor.
// When you change your cursor to different section, currently playing video fast forward itself
// for getting the illusion of interaction 

// Add your videos under data/videos
// name your 4 files as 1.mp4/2.mp4/3.mp4/4.mp4
//or change videos under USER PREF

import processing.video.*;
Capture inputProjectile;

Movie[] projectile = new Movie[4];

int screenSect;
int curScreenSect = -1;
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
  
  size(640,480);
  background(100);
  frameRate(100);
//  noCursor();
  
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
  
    image(projectile[0], 0, 0, width/2, height/2);
    image(projectile[1], width/2, 0, width/2, height/2);
    image(projectile[2], 0, height/2, width/2, height/2);
    image(projectile[3], width/2, height/2, width/2, height/2);  
    
    screenSect = getScreenSect(mouseX, mouseY);

//    print(screenSect);
    for(int i=0; i<projectile.length; i++){
//      println(curScreenSect);
      
      if(screenSect == i && curScreenSect == -1 ){
        println('1');
        curScreenSect = i;
        projectile[curScreenSect].play(); 
      }
      
      if((durationsMax[curScreenSect] - durations[curScreenSect]) > 1  ){
        if(curScreenSect != screenSect){
          println('2');
          projectile[curScreenSect].speed(videoSpeed);
        }
        if(curScreenSect == screenSect){
          println('3');
          projectile[curScreenSect].speed(1);
        }
        stopVideosExcept(curScreenSect);
        durations[curScreenSect] = projectile[curScreenSect].time(); 
//        println("durations"+(durationsMax[curScreenSect] - durations[curScreenSect]));
//        println("curScreenSect " + curScreenSect);
      }
      
      if((durationsMax[curScreenSect] - durations[curScreenSect]) < 1 &&  screenSect == i ){
        println('3');
        curScreenSect = i;
        projectile[curScreenSect].play();
      }
     }
    }
    
    
void stopVideosExcept(int screenSect){
        
  for(int i=0; i<projectile.length; i++)
    if(i != screenSect ){
      projectile[i].pause();
      durations[i] = projectile[i].time();
    }
}
  
  
// Which section your mouse cursor is ?
int getScreenSect(int x, int y){
  
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
