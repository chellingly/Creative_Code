
 import processing.sound.*;
 import codeanticode.syphon.*;
 import org.openkinect.freenect.*;
import org.openkinect.processing.*;

particle[] Z = new particle[1000];
float minThresh = 900;
float maxThresh = 950;
// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];
PImage img;



// Kinect Library object
Kinect kinect;
SyphonServer server;// Syphon Sever
Icosahedron ico1;
Icosahedron ico2;
Icosahedron ico3;

// Angle for rotation
float a = 0;



SoundFile input;
  Amplitude rms;
  int scale=1;
  int scaleMid2=1;
  int scale2=1;
  int scale4=1;
  int scaleLow=1;
  int radius=1;
  int circFill;
 int radius2=1;

void settings() {
  size(800,800,P3D);
  PJOGL.profile=1;
}

void setup(){
  
   server = new SyphonServer(this, "Processing Syphon");
  frameRate(30);
  
   kinect = new Kinect(this);
  kinect.initDepth();
   kinect.enableMirror(true);
  img = createImage(kinect.width, kinect.height, RGB);
  

  
 float r;
  float phi;
   for(int i = 0; i < Z.length; i++) {
         
    r = sqrt( random( sq(width/2) + sq(height/2) ) );
    phi = random(TWO_PI);
    Z[i] = new particle( r*cos(phi)+width/2, r*sin(phi)+height/2, 0, 0, random(2.5)+0.5 );
  }
  

  
      //Create an Audio input and grab the 1st channel
    input = new SoundFile(this, "first.mp3");
    
    // Play the file in a loop
    input.loop();
    
    // create a new Amplitude analyzer
    rms = new Amplitude(this);
    
    // Patch the input to an volume analyzer
    rms.input(input);
    
    

 
    
}

void draw(){
   float r;
   int[] depth = kinect.getRawDepth();
   int skip = 10;
   float transp = 0; 
   
  background(0);
  img.loadPixels();
 
  //int record = 4500;
  int record = kinect.height;
  int rx = -400;
  int ry = -200;
  lights();


 
  
     
   radius2=0;  
   radius = 0; //ellipse rad change
   circFill=0; //fill of initial circle
   
   
   scale2=int(map(rms.analyze(), 0, 0.3, 30, 180));//scales color9
   int scale3=int(map(rms.analyze(), .2, .5, 50, 220));//scales color
   scale4 = 190;

  
  
   for (int x = 0; x < kinect.width-70; x += skip) {
   for (int y = 0; y < kinect.height-200; y += skip) {
     int offset = x + y*kinect.width;
   int d = depth[offset];
   if (d > minThresh && d < maxThresh) {
     img.pixels[offset] = color(0);
        mousePressed=true;
  
 
  transp = 40;
  scale2=(0);
  scale3=(0);
  scale4=(0);
  radius=scale;
  radius2=scaleMid2;
  circFill=255;
  if (y < record) {
          record = y;
          rx = x;
          ry = y;
        }
   }else{
     //background image is transparent
        img.pixels[offset] = color(0,0);
       
      }
   }
   }
    img.updatePixels();
  image(img,0,50);
    for(int i = 0; i < Z.length; i++) {
    if( rx != -400) {
      Z[i].gravitate( new particle( rx, ry, 0, 0, 40 ) );
    }
    else if( rx !=-400 ) {
      Z[i].repel( new particle( rx, ry, 0, 0, 40 ) );
    }
    Z[i].deteriorate();
    Z[i].update();
    r = float(i)/Z.length;
    if( sq(Z[i].magnitude)/50 < 0.15 ) {
     stroke(255,255,255 );
    
    }
     Z[i].display();
  }
   scale=int(map(rms.analyze(), 0, 0.6, 20, 25));//scales size
   scaleMid2=int(map(rms.analyze(), 0.2, 0.9, 20, 25));//scales size
   scaleLow=40;
  ico3 = new Icosahedron(scaleLow);



  pushMatrix();
  translate(600,600);
  fill(255,circFill);
  ellipse(0,0,radius,radius);
  rotateX(frameCount*PI/-200);
  rotateY(frameCount*PI/200);
  stroke(51,245,255,transp);
  strokeWeight(3);
  fill(200,255,255,scale2);
  ico3.create();
  popMatrix();
  
  pushMatrix();
  translate(400,600);
  fill(255,circFill);
  ellipse(0,0,radius,radius);
  rotateX(frameCount*PI/500);
  rotateY(frameCount*PI/500);
  stroke(51,245,255,transp);
  strokeWeight(3);
  fill(180,235,255,scale3);
  ico3.create();
  popMatrix();
  
    
  pushMatrix();
  translate(500,600);
  fill(255,circFill);
  ellipse(0,0,radius,radius);
  rotateX(frameCount*PI/200);
  rotateY(frameCount*PI/200);
  stroke(51,245,255,transp);
  strokeWeight(3);
  fill(180,235,255,scale4);
  ico3.create();
  popMatrix();
  
  
 
 
    server.sendScreen();//Seds screen to Syphon
}