//original code from Daniel Shiffman
//revised by WEN CHI HUANG
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;
float pTime = 0;
float vel;

import peasy.*;
//boolean isRotating = true;
int currentFrame= 1;
int ptsW, ptsH;
boolean isActivate = false;

PImage img;
PImage bg;
PImage logo;
PShape rock;
PeasyCam cam;
int num = 300;
int numPointsW;
int numPointsH_2pi; 
int numPointsH;


float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;

boolean follow = true;
//boolean lighting = true;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  noStroke();
 
  minim = new Minim(this);
  //song = minim.loadFile("He's Dead.mp3", 512);
  //song = minim.loadFile("03 Relight My Fire by Azumi Takahashi (online-audio-converter.com).mp3", 512);
  //song = minim.loadFile("Vlien_Boy_Montrose_-_Uh_-_De_-_Dus_Goblin_Promotion[MP3Fiber.com].mp3", 512);
  //song = minim.loadFile("DiscoVer. - Paradise Side (Original Mix).mp3", 512);
   //song = minim.loadFile("Trap_Renegade_-_PizZa_Cats_Tacos.mp3", 512);
   //song = minim.loadFile("Teardrops (Original Mix).mp3", 512);
    song = minim.loadFile("FKJ - Drops feat. Tom Bailey.mp3", 512);
    //song = minim.loadFile("Freeez - I.O.U. (12 Version) (1983).mp3", 512);
    
  //song.loop();
  fft = new FFT(song.bufferSize(), song.sampleRate());
 
  imageMode(CENTER);
  img=loadImage("fluonewlandingpage-01.png");

  image(img, 640, 360, 1280, 720);


  for (int i = 0; i < num; i++) {
    float r = random(300, 400);
    float theta = random(TWO_PI);
    float y = r*sin(theta);
    float x = r*cos(theta);
  }
  bg = loadImage("newstarbackground.jpg");
   ambientLight(255, 255, 255);
  
  img=loadImage("colorrock11.jpg");
  rock= createShape(SPHERE, 500);
  ptsW=10;
  ptsH=10;

  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);
  cam = new PeasyCam(this, 500);
  println("Flourescent Rock");
  println("Press 'space' to start");
  println(" ");  
  println("Use mousepress left to rotate the stone");
  println(" ");  
  println("Use mouse weel to zoom in and out");
  println(" ");  
  println("Use mousepress right to light on the stone");
  println(" ");  
  println("Press S to spin the rock");
  println("Or Press L to turn the lights on");  
  println("Press P to speed up the spin");
  println(" ");  
  println("Press T to end the spin");
  println(" ");  
  println("press 'Y', 'R', 'M','B', 'O'to change the texture of rock");
  
}


// Use arrow keys to change detail settings

void draw() {
  
  initializeSphere(ptsW, ptsH);
  if (isActivate == false) {
    //loading page
  } else {
    //draw
    song.play();
    
    
    
   
  
    currentFrame=currentFrame+1;
    background(bg);

   
    smooth();

    fft.forward(song.mix);

    float time = millis()*0.001;
    float dt = time - pTime;
    //println(dt);
    pTime = time;

    float fftVal = fft.getBand(300);
    vel = map(fftVal, 0, 0.1, 1, 20);

    if (follow) {
      ptsW= (int) vel;
      ptsH= (int) vel/2;
    }
    

    //if (lighting) {
    //  directionalLight(180, 180, 180, 0.2, 0, -0.2);
    // //lightSpecular(204, 204, 204);
    //  directionalLight(180, 180, 180, 0, 0.2, -0.2);
    // //lightSpecular(0, 0, 200);
    //  directionalLight(190, 190, 190, 0.2, 0.2, 0);
    // //lightSpecular(0, 200, 0);
    //  directionalLight(150, 150, 150, 0.2, 0.2, 0.5);
    //}



    println("vel: " + vel); 
    beginCamera();
    rock.rotate(vel); 
    if  (keyCode == 'S' || keyCode =='S') {
      rotateX(radians(vel/3));
      rotateY(radians(vel/5));
      rotateZ(radians(vel/3));
      //rock.scale(vel*0.1);
    }

    if (keyCode =='P'||keyCode=='p') {

      rotateY(vel*0.75);
      rotateZ(PI/-1*vel);
    }

    if (keyCode =='T'||keyCode=='t') {

      rotateX(0);
      rotateZ(0);
    }

    if (mousePressed && (mouseButton == RIGHT)) {

      //directionLight(0, 0, 200);
      directionalLight(0,0,200, 0, 1, -1);
      directionalLight(0,0,250, 0, 1, 0);
      //spotLight(0, 0, 255, width, height/2,50, -1, 0, -1, PI/16.0, 32);
      //pointLight(0, 0, 255, mouseX, mouseY, 64);
      //pointLight(0, 0, 255, width - mouseX, height - mouseY, 64);
 
      lightSpecular(0,0,255);
      
 
      specular(255,255,255);
      shininess(1.0 + (100 * abs(cos(frameCount * 1))));
      ambient(0,0,255);
    
    }

    //pushMatrix();


    textureSphere(600, 600, 600, img);
    sphereDetail(50);
    endCamera();
  }
}


void keyPressed() {


  if (key == 'Y' || key == 'y') {
    img=loadImage("bluepurplerock2.jpg");
  }

  if (key == 'R' || key == 'r') {
    img=loadImage("yellowrock3.jpg");
  }

  if (key == 'M' || key == 'm') {
    img=loadImage("multicolorrock4.jpg");
  }

  if (key == 'O' || key == 'o') {
    img=loadImage("colorrock11.jpg");
  }

  if (key == 'B' || key == 'b') {
    img=loadImage("redandblue3.jpg");
  }


  if (keyCode == ENTER) saveFrame();
  if (keyCode == UP)   ptsH= (int) vel++;
  if (keyCode == DOWN) ptsH= (int) vel--;
  if (keyCode == LEFT) ptsW= (int)vel++;
  if (keyCode == RIGHT) ptsW= (int)vel--;
  if (ptsW == 0) ptsW = 10;
  if (ptsH == 0) ptsH = 10;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);

  if ( key == ' ' ) {
    isActivate = true;
  }
  
  if(key=='f'||key=='F'){
    follow = !follow;
    if(!follow){
      ptsW = 20;
      ptsH = 20;
    }
    
   //if(key=='c'||key=='C'){
   //  isrotating=true;
     
     }
   }
//}


void initializeSphere(int numPtsW, int numPtsH_2pi) {



  //for (int i = 0; i < num; i++) {
  // numPointsW[i].x += vel * dt;
  //  numPointsH[i].y += vel *dt;
  // float xScale = map( numPointsH(ptsw[i].x), 0, 1, -1, 1);
  // float yScale = map(  numPointsH([ptsh[i].y), 0, 1, -1, 1);

  // The number of points around the width and height
  numPointsW=numPtsW+1;
  numPointsH_2pi=numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
  numPointsH=ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)

  coorX=new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
  coorY=new float[numPointsH];   // All the y-coor in a vertical circle radius 1
  coorZ=new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
  multXZ=new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)

  for (int i=0; i<numPointsW; i++) {  // For all the points around the width
    float thetaW=i*2*PI/(numPointsW-1);
    coorX[i]=sin(thetaW);
    coorZ[i]=cos(thetaW);
  }

  for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
    if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
      float thetaH=(i-1)*2*PI/(numPointsH_2pi);
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=0;
    } else {
      //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
      float thetaH=i*2*PI/(numPointsH_2pi);

      //PI+ below makes the top always the point instead of the bottom.
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=sin(thetaH);
    }
  }
}

void textureSphere(float rx, float ry, float rz, PImage t) { 
  // These are so we can map certain parts of the image on to the shape  //<>//
  float changeU=t.width/(float)(numPointsW-1); 
  float changeV=t.height/(float)(numPointsH-1); 
  float u=10;  // Width variable for the texture
  float v=30;  // Height variable for the texture
  //pointLight(150, 102, 126, 10, 360, 360);
  //ambientLight(255, 255, 255);
  //lights();

  if (key =='l'||key=='L') { //<>//
     directionalLight(204,204,204,0,-1,0);
      ambientLight(24,24,24);
      directionalLight(180, 180, 180, 0.2, 0, -0.2);
    
      directionalLight(190, 190, 190, 0.2, 0.2, 0);
   
      directionalLight(150, 150, 150, 0.2, 0.2, 0.5);
    
  }
  
     
      ////lightSpecular(0, 200, 0);
   ////lightSpecular(204, 204, 204);
      //directionalLight(180, 180, 180, 0, 0.2, -0.2);
     ////lightSpecular(0, 0, 200);
  //if(keyCode =='L' || keyCode == 'l'){
  

  
  //}
   
   

 
  
  beginShape(TRIANGLE_STRIP);
  texture(t);
  for (int i=0; i<(numPointsH-1); i++) {  // For all the rings but top and bottom
    // Goes into the array here instead of loop to save time
    float coory=coorY[i];
    float cooryPlus=coorY[i+1];

    float multxz=multXZ[i];
    float multxzPlus=multXZ[i+1];

    for (int j=0; j<numPointsW; j++) { // For all the pts in the ring
      normal(-coorX[j]*multxz, -coory, -coorZ[j]*multxz);
      vertex(coorX[j]*multxz*rx, coory*ry, coorZ[j]*multxz*rz, u, v);
      normal(-coorX[j]*multxzPlus, -cooryPlus, -coorZ[j]*multxzPlus);
      vertex(coorX[j]*multxzPlus*rx, cooryPlus*ry, coorZ[j]*multxzPlus*rz, u, v+changeV);
      u+=changeU;
    }
    v+=changeV;
    u=0;
  }
  endShape();
}