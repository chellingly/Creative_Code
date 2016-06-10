import org.openkinect.processing.*; //<>//
import codeanticode.syphon.*;

SyphonServer server;// Syphon Sever
Kinect kinect;//Kinect

float minThresh = 480;
float maxThresh = 800;
float spin = .01;
PShape[] shapes;
PImage img;
PImage snow;
PImage sky;
ParticleSystem ps;
Icosahedron ico1;



void settings() {
  size(800,800, P3D);
  PJOGL.profile=1;
}


void setup() {
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
  frameRate(30);
  
  ico1 = new Icosahedron(75);
  
  shapes = new PShape[5];
  shapes[0] = loadShape("jagged.obj");
  shapes[1] = loadShape("jagged.obj");
  shapes[2] = loadShape("jagged2.obj");
  shapes[3] = loadShape("jagged3.obj");
  shapes[4] = loadShape("jagged3.obj");
  
  
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  ps = new ParticleSystem(shapes, new PVector(width/2, 50));
  img = createImage(kinect.width, kinect.height, RGB);
  snow = loadImage("snow0000.png");
  sky = loadImage("sky.png");
}


void draw() {
  background(0);
  image(sky,0,0);
  image(snow,0,0);
  noCursor();


  img.loadPixels();

  PImage dImg = kinect.getDepthImage();
  //image(dImg, 0, 0);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  
  //int record = 4500;
  int record = kinect.height;
  int rx = -400;
  int ry = -200;

  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];

      //if (d > minThresh && d < maxThresh && x > 100 && y > 50) {
        if (d > minThresh && d < maxThresh) {
        
         //This affects the image within the Threshold
         //closest image is pink
        img.pixels[offset] = color(67, 13, 94);
        
        if (y < record) {
          record = y;
          rx = x;
          ry = y;
        }
        
        
      } else {
        
        
        ////background image is transparent
        //img.pixels[offset] = color(0,0);
      }
    }
  }
  img.updatePixels();
  translate(150,150);
  //image(img,0,0);
  
  
  ps.run();

  //ps.addParticle(rx,ry);
  
//draws circle at closest point
  //fill(255);
  //ellipse(rx, ry, 32, 32);
  //if (rx > 1 && ry > 1){
  //  //if (mouseX > 1 && mouseY > 1){
    
  ////translate(rx, ry);
  ////translate(mouseX, mouseY);
  //  ps.run();

  ps.addParticle(rx,ry);
   //ps.addParticle(mouseX,mouseY);
 
  //}else{
  ////ps.erase();
  //}
  
  spin = spin + .08;
  
  server.sendScreen();//Seds screen to Syphon
}