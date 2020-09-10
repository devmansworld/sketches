//Declare and construct two objects (h1,h2) from the class Teresito

HLine h1 = new HLine();
float [] speeds = new float [3];
float ypos;
VLine v1 = new VLine();
float [] velocidad = new float [3];
float vpos;


void setup ()  {
    size (600, 600);
    background(255);
    speeds [0] = 0.2;
    speeds [1] = 0.3;
    speeds [2] = 0.9;
    velocidad [0] = 0.1;
   velocidad [1] = 0.4;
   velocidad [2] = 0.5;
}

void draw() {
   ypos += speeds [int(random(3))];
  
   if (ypos > width ) {
     ypos = 0;
   }
   h1.update(ypos);
   
   vpos += velocidad [int(random(3))];
  if (vpos > height) {
     vpos = 0;
  }
  v1.update(vpos);
   
}

class HLine {
  void update (float y) {
    stroke(random(255),random(255),random(255),random(255));
    strokeWeight(random(200));
     line (0 , y , width , y);
     line (0,random(400),width,0);
   
     
  }
  
}


class VLine {
  void update (float x) {
    stroke(random(255),random(255),random(255),random(255));
    strokeWeight(random(300));
    line (x,0,x,height);
    line (width,0,random(400),height);
      
  }
}