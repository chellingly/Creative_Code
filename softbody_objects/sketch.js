
var bubbles = [];
var numBubble = 15;

function setup() {
	createCanvas(400, 300);
	  	for(var i=0; i<numBubble;i++){
	  	bubbles.push(new Bubble (random(0, windowWidth), random(0,windowHeight)));
	  }
	  for(var i=0; i<bubbles.length; i++){
	  	bubbles[i].initialize();
	  }

}

function draw() {
  background(0,30);
  for(var i=0; i<bubbles.length; i++){
  	bubbles[i].display();
  	bubbles[i].move();


	  }


  

}


