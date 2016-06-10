ParticleSystem ps;

void setup() {
  size(1000,1000, OPENGL);
   ps = new ParticleSystem(new PVector(random(10,width),-300));
  yuck = loadShape("doge.obj");
}

void draw() {
  background(240,10,250);
 
  ps.addParticle();
  ps.run();
}