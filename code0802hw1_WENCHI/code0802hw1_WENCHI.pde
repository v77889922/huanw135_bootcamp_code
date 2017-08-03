//hello program1
// written by wen chi

//declare some variables
//use variables as argument for shapes we will draw
String printThis = "Your sketch is: ";
int r = 241, g = 232, b = 210;

int radius = 50;
int xPos = 250;
int yPos = 250; 

//declare the size of the sketch
//change the background color
//fill shapes with a different color
//use variable for println
void setup(){
 size(500, 500);
  println(printThis);
  println(500 + "x" + 500 + "pixels");
  background(r,g,b);
  println(r+ " , " + g + " , " + b);
  println("The value of radius is:" +radius + "Xpos is" + xPos);
  
  
}
//draw circle
//draw square
void draw(){
  noStroke();

ellipseMode(CORNER);
fill(242,222,83);  // Set fill to white
ellipse(91, 104, 50, 50);  // Draw white ellipse using CORNER mode

ellipseMode(RADIUS); // Set ellipseMode to CENTER
fill(226, 114, 109); //Set fill to pink
ellipse(70,80,60,60);

ellipseMode(CORNER);
fill(160,0,0);  // Set fill to white
ellipse(91, 104, 40, 40);  // Draw white ellipse using CORNER mode


 ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
fill(0);  // Set fill to black
ellipse(70, 80, 50, 50);  // Draw black ellipse using RADIUS mode

ellipseMode(CENTER);  // Set ellipseMode to CENTER
fill(45, 11, 69);  // Set fill to purple
ellipse(70, 80, 40, 40);  // Draw purple ellipse using CENTER mode


stroke(0);
fill(113,148,178);
triangle(80,240, 240,240,160,140);

stroke(0);
fill(227,202,218);
triangle(250, 200, 400, 200, 350, 20);//draw a triangle

stroke(0);
line(160,20,160,180);

stroke(0);
strokeCap(PROJECT);
line(145,80, 180, 80);

strokeWeight(3);
strokeCap(ROUND);
stroke(0);
line(150,90, 185, 90);

strokeWeight(1);  // Default
stroke(0);
line(135,30, 210, 80);

  fill(255);
  stroke(0);
  arc(400, 450, 140, 240, 0, PI);

stroke(165,0,0);
arc(350, 300, 140, 120, 0, HALF_PI);

if (keyPressed == true){
    fill(255,255,0);
    ellipse(70,80,30,30);
    println("Show yellow circle");
  }else{
    fill(34,0,54);
     ellipse(70,80,30,30);
    println("nothing happend");
  }
}