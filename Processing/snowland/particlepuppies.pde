

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int m = millis();
  PShape[] textures;
 
  ParticleSystem(PShape[] shapes, PVector v) {
    textures = shapes;
    particles = new ArrayList();
   
  }

  void addParticle(float x, float y) {
   int r = int(random(textures.length));
   
    particles.add(new Particle(x,y,textures[r]));
    
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
  
  void erase(){ 
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
   p.erase(); 
    }
  }
  
  
 
}