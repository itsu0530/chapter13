Ball[] balls = new Ball[300];
bullet[] bullets = new bullet[1000000];
int i,I;
float g;
float a;
int count;
int deadCount;
int clearCount;




void setup() {
	size(600,900);
	background(255);
	balls[0] = new Ball();
	g=0.01;
	count = 0;
	bullets[0] = new bullet();
	deadCount = 0;
	clearCount = 0;
	noLoop();

	
}

void draw() {
	background(255);

	i = frameCount;
	I = frameCount/40; 
	stand();
	for(int b = 0;b < count;b++){
		bullets[b].shot();
	}
	hit();





	
		if (i%40==0) {
			if(I<100){
		balls[I]= new Ball();
		}
	}
	for (int j = 0; j < I; j++) {
		noStroke();
		balls[j].display();
		balls[j].fall();
	}

	judge();
	
}

void stand(){
	
	fill(0);
	a = atan2(mouseY-height,mouseX-width/2);
	translate(width/2, height);
	ellipse(0,0,30,30);
	stroke(0);
	strokeWeight(10);
	rotate(a);
	line(0,0,30,0);
	rotate(-a);
	translate(-width/2,-height);
	
	
}

void hit(){
	for(int b = 0; b<count;b++){
		for(int k = 0;k < I; k++){
			float dis = dist( balls[k].x, balls[k].y, bullets[b].x,bullets[b].y);
			if(dis < balls[0].r*2){
				balls[k].x= -40;
				balls[k].y= -40;
				bullets[b].x= -80;
				bullets[b].y= -80;
				clearCount++;
			}
		}
	}
	textSize(50);
	textAlign(CENTER);
	text(clearCount,100,height-100);
	
}

void judge(){
	for(int b = 0;b < I; b++){
	if(balls[b].y>height && balls[b].x>0){
		deadCount++;
		balls[b].x= -40;
	}
	}
	textAlign(CENTER);	
	textSize(50);
	if(deadCount>=5){
		background(255);
		fill(255,0,0);
		text("your lose",width/2,height/2);
		noLoop();
	}
	fill(255,0,0);
		if(bullets[0].y==height)text("PUSH G TO START", width/2,height/2);
	text("LIFE-"+(5-deadCount) ,width-100,50);
	if(clearCount>=100){
		background(255);
		text("CLEAR",width/2,height/2);
		text(clearCount,100,height-100);
		noLoop();
	}

	

}




class Ball{
	float x,y;
	float vy;
	int r;

	Ball(){
		 x = random(10,width-10);
		 y = 0; 
		 r = 20;
		 vy = 0.1;
		 
		
	}

	void display(){
		fill(0,0,255);
		ellipse(x,y,r*2,r*2);
	}

	void fall(){
		vy += g;
		y += vy;
	}	 
}

class bullet{
	float x,y;
	float v;
	float n;

bullet(){
	x = width/2;
	y = height;
	v =10;
	n = atan2(mouseY-height,mouseX-width/2);
}

void shot(){
	
	x += v*cos(n);
	y += v*sin(n);
	fill( 255, 0, 0);
	noStroke();
	ellipse( x, y, 8, 8);
}



}

void mousePressed() {

	if(mouseButton==LEFT){
		bullets[count] = new bullet();
	}
	count++;
}

void keyPressed() {
	if(key =='g'){
		deadCount = 0;
		clearCount = 0;
		loop();
	}
}
