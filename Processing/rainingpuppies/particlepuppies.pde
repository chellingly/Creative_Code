// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
PShape yuck;

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}



// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.02);
    velocity = new PVector(random(-3,3),random(-2,2));
    location = l.get();
    lifespan = 500.0;
  }

  void run() {
    update();
    display();
 
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    //fill(0,243,246);
    //ellipse(location.x,location.y,10,10);
    lights();
    directionalLight(245, 19, 226, -1, 0, 0);
    directionalLight(50, 20, 146, 20, 40, -30);
    shape(yuck, location.x, location.y);
  }

  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}