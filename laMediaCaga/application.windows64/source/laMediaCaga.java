import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class laMediaCaga extends PApplet {

//Declare and construct two objects (h1,h2) from the class Teresito

HLine h1 = new HLine();
float [] speeds = new float [3];
float ypos;
VLine v1 = new VLine();
float [] velocidad = new float [3];
float vpos;


public void setup ()  {
    
    background(255);
    speeds [0] = 0.2f;
    speeds [1] = 0.3f;
    speeds [2] = 0.9f;
    velocidad [0] = 0.1f;
   velocidad [1] = 0.4f;
   velocidad [2] = 0.5f;
}

public void draw() {
   ypos += speeds [PApplet.parseInt(random(3))];
  
   if (ypos > width ) {
     ypos = 0;
   }
   h1.update(ypos);
   
   vpos += velocidad [PApplet.parseInt(random(3))];
  if (vpos > height) {
     vpos = 0;
  }
  v1.update(vpos);
   
}

class HLine {
  public void update (float y) {
    stroke(random(255),random(255),random(255),random(255));
    strokeWeight(random(200));
     line (0 , y , width , y);
     line (0,random(400),width,0);
   
     
  }
  
}


class VLine {
  public void update (float x) {
    stroke(random(255),random(255),random(255),random(255));
    strokeWeight(random(300));
    line (x,0,x,height);
    line (width,0,random(400),height);
      
  }
}
  public void settings() {  size (600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "laMediaCaga" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
