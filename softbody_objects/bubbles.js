

function Bubble(x, y, alpha){
	this.x = x;
	 this.y = y;
	this.speed = 2;
	this.size = random(2,10);
		this.grow = 1;
		// center point
	this.centerX = 0.0, this.centerY = 0.0;

	this.radius = 45, this.rotAngle = -90;
	this.accelX = 0.0, this.accelY = 0.0;
	this.deltaX = 0.0, this.deltaY = 0.0;
	this.springing = 0.0009, this.damping = 0.9;

	//corner nodes
	this.nodes = 50;

	//zero fill arrays
	this.nodeStartX = [];
	this.nodeStartY = [];
	this.nodeX = [];
	this.nodeY = [];
	this.angle = [];
	this.frequency = [];

	// soft-body dynamics
	this.organicConstant = 1.0;
	

	this.initialize = function(){
		this.centerX= random(0,width);
		this.centerY=random(0,height);
		for (var i=0; i<this.nodes; i++){
		    this.nodeStartX[i] = 0;
		    this.nodeStartY[i] = 0;
		    this.nodeX[i] = 0;
		    this.nodeY[i] = 0;
		    this.angle[i] = 0;
  }

	  for (var i=0; i<this.nodes; i++){
	    this.frequency[i] = random(8, 10);
	  }

	  frameRate(30);



	}

	this.display = function(){
		// this.alpha = noise(this.x, this.y, millis()/ 1000);
	
		  //calculate node  starting locations
	  for (var i=0; i<this.nodes; i++){
	    this.nodeStartX[i] = this.centerX+cos(radians(this.rotAngle))*this.radius;
	    this.nodeStartY[i] = this.centerY+sin(radians(this.rotAngle))*this.radius;
	    this.rotAngle += 360.0/this.nodes;
	  }

	  // draw polygon
	  //curveTightness(this.organicConstant);
	  stroke(255);
	  noFill();
	  beginShape();
	  for (var i=0; i<this.nodes; i++){
	    curveVertex(this.nodeX[i], this.nodeY[i]);
	  }
	  for (var i=0; i<this.nodes-1; i++){
	    curveVertex(this.nodeX[i], this.nodeY[i]);
	  }
	  endShape(CLOSE);
}
 
  		

  	


	this.move = function(){
		//move center point
  this.deltaX = width/2-this.centerX;
  this.deltaY = height/2-this.centerY;

  // create springing effect
  this.deltaX *= this.springing;
  this.deltaY *= this.springing;
  this.accelX += this.deltaX;
  this.accelY += this.deltaY;

  // move predator's center
  this.centerX += this.accelX;
  this.centerY += this.accelY;

  // slow down springing
  //this.accelX *= this.damping;
  //this.accelY *= this.damping;

  // change curve tightness
  this.organicConstant = 1-((abs(this.accelX)+abs(this.accelY))*0.1);

  //move nodes
  for (var i=0; i<this.nodes; i++){
    this.nodeX[i] = this.nodeStartX[i]+sin(radians(this.angle[i]))*(this.accelX*2);
    this.nodeY[i] = this.nodeStartY[i]+sin(radians(this.angle[i]))*(this.accelY*2);
    this.angle[i] += this.frequency[i];
  }
	
}
	}