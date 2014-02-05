Cara[] cara;
int numC;

void setup() {
  size(800, 800);  
  smooth();
  
  numC = 4;
  cara = new Cara[numC];
    cara[0] = new Cara(width/4, height/4);
    cara[1] = new Cara(3*width/4, height/4);
    cara[2] = new Cara(3*width/4, 3*height/4);
    cara[3] = new Cara(width/4, 3*height/4); 
 
    for (int n = 0; n < numC; n++) {  
      if (n == 0) {
        cara[n].xPoint = cara[numC-1].xCenter;
        cara[n].yPoint = cara[numC-1].yCenter;      
      }
      else {
        cara[n].xPoint = cara[n-1].xCenter;
        cara[n].yPoint = cara[n-1].yCenter;            
      }  
    }    
}


void draw() {
  
  background(200);
  
  if (frameCount % 60 == 0) {
    for (int n = 0; n < numC; n++) {  
      if (n == 0) {
        cara[n].xPoint = cara[numC-1].xCenter;
        cara[n].yPoint = cara[numC-1].yCenter;      
      }
      else {
        cara[n].xPoint = cara[n-1].xCenter;
        cara[n].yPoint = cara[n-1].yCenter;            
      }  
    }
  }
  
  for (int n = 0; n < numC; n++) {
    cara[n].draw();
  }
}
