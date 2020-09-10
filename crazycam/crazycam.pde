
import processing.video.*;
Capture cam;
void setup() {
  size(800, 800);
  cam = new Capture(this,100,100,15);
  background(255);
  String[] cameras = Capture.list();
   
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
     
    // Initialize Camera
    cam = new Capture(this, cameras[9]);
    cam.start();    
  }     
}
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
   
   
    // Tinting using mouse location
  tint(random(mouseX),random(mouseY),random(mouseY));
  // Multiple Cam
  image(cam,random(mouseX),random(mouseY),mouseX,mouseY);
  image(cam,random(mouseX),random(mouseY),random(mouseX),mouseY);
  image(cam,random(mouseY),random(mouseY),mouseX,mouseY);
  image(cam,random(mouseY),200,mouseX,mouseY);
  image(cam,220,210,random(mouseX) -50 ,mouseY - random(mouseX));
  image(cam,random(mouseX),240,random(mouseY) -50 ,mouseY - 100);
  image(cam,random(mouseX),245,mouseX -10 ,random(mouseY)- 90);
  image(cam,random(mouseX),random(mouseY),random(mouseX)-10 ,mouseY - random(mouseX));
    image(cam,200,200,mouseX,mouseY);
  image(cam,random(mouseX),510,random(mouseY) -50 ,mouseY - 100);
  image(cam,random(mouseY),540,random(mouseY) -50 ,mouseY - 100);
  image(cam,random(mouseX),545,mouseX -10 ,mouseY - 90);
  image(cam,random(mouseX),550,mouseX -10 ,random(mouseY));
   
  
}