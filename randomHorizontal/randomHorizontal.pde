//Declare and construct two objects (h1,h2) from the class Teresito

HLine h1 = new HLine();
float [] speeds = new float [3];
float ypos;
float rojo= random(255);
float verde= random(255);
float azul= random(255);

void setup ()  {
    size (400, 400);
    background(255);
    speeds [0] = 0.1;
    speeds [1] = 2.0;
    speeds [2] = 0.5;
}

void draw() {
   ypos += speeds [int(random(3))];
  
   if (ypos > width ) {
     ypos = 0;
   }
   h1.update(ypos);
   
}

class HLine {
  void update (float y) {
    stroke(random(255),random(255),random(255),random(255));
    strokeWeight(random(30));
     line (0 , y , width , y);
     
  }
  
}