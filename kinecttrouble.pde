import processing.serial.*; //<>//

import processing.video.*;



//immymymymymyPort org.openkinect.processing.*;

  
Serial myPort;
//String myString=null;
String myPortName=null;
//int nl=10;
float val;
//float myVal;
float [] C= new float[1] ;
float [] R= new float[1] ;
color trackColor;
float threshold;
int num=2;
Capture video;
void setup() {
  size(1280,720);
  video=new Capture(this,1280,720,Capture.list()[99]);
  video.start();
  ///printArray(Capture.list());
  ///printArray(Serial.list());
  
  String myPortName = Serial.list()[0];
  myPort = new Serial(this, myPortName, 9600);
  trackColor = color(255, 0, 0);
 
}
void captureEvent(Capture video){
  video.read();
}

void draw() {  
  
 // serialEvent
  if ( myPort.available() > 0) {  
         
            val = myPort.read();  
  }
  if (keyPressed==true){
     image(video,0,0);
    // background(2);
  }
  
  //background(255);
 // tint(255, 80);
  
 
    threshold = 50;

  float colx = 0;
  float coly = 0;
  int count = 0;


  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {
        //stroke(255);
        //strokeWeight(1);
        //point(x, y);
        colx += x;
        coly += y;
   
        count++;
      }
    }
  }


  if (count > 10) { 
    colx = colx / count;
    coly = coly / count;
    
    //fill(255);
    //strokeWeight(4.0);
    //stroke(0);
    //ellipse(colx, coly, 1,1);
   
  if(val<1){
     stroke(255);
      strokeWeight(1);
       ellipse(colx,coly,2,2);
    //background(255);
    
    line(colx,coly,C[0],R[0]);
    }
  
     C[0]=colx;
     R[0]=coly;
  //println(C[0]);
  }}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
 
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}

void keyReleased(){
  background(255, 86, 128);}











//void setup() {
//  size(640, 480);
//  kinect = new Kinect(this);
// kinect.initDepth();

//}


//void draw() {
//  background(0);
//  PImage img = kinect.getDepthImage(); 
//  image(img,0,0);
//}
