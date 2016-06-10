class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PShape star;
  
  float lifespan;
  float spin = .01;
  float add = random(-1,1);


  Particle(float x, float y, PShape star_) {
    acceleration = new PVector(0,0.003);
    velocity = new PVector(random(-1,1),random(-2,2));
    location = new PVector(x, y);
    lifespan = 300.0;
    star = star_;
  }

  void run() {
    if (millis()>3000){
    update();
    display();
    }
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
   
    stroke(255);
    //fill(0,243,246);
    //ellipse(location.x,location.y,10,10);
    lights();
    
    directionalLight(245, 19, 226, -1, 0, 0);
    directionalLight(50, 20, 146, 20, 40, -30);
    
    pushMatrix();
   rotateY(spin);
   //rotateX(spin);
 
    shape(star, location.x, location.y);
    popMatrix();
    
    spin = spin + .05*add;
    
  }
  
  void erase(){
    lifespan = 0;
    
  }

 
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0  ) {
      return true;
    } else {
      return false;
    }
  }

}