import controlP5.*;
import ddf.minim.*;  
import ddf.minim.signals.*;

Minim minim;  
AudioOutput out;  
SineWave sine;  
SineWave nullSine;

AudioPlayer player;

ControlP5 cp5;

static final float MAXAMP = 0.7;
float amp  = MAXAMP;
int port   = 30;

int[][] fi = {{6,1,8,0,3,3,9,8,8,7},{4,9,8,9,4,8,4,8,2,0},{4,5,8,6,8,3,4,3,6,5},{6,3,8,1,1,7,7,2,0,3},{0,9,1,7,9,8,0,5,7,6},{2,8,6,2,1,3,5,4,4,8},{6,2,2,7,0,5,2,6,0,4},{6,2,8,1,8,9,0,2,4,4},{9,7,0,7,2,0,7,2,0,4},{1,8,9,3,9,1,1,3,7,4}};
float[] notas = {220.00, 260.25, 290.33, 330.25, 390.99, 415.0, 440, 520.5, 575.66, 660.51};
float nota;
int notActual;
int borX, borY;
PFont font;
int escala = 30;
boolean[][] tocado = new boolean[escala][escala];
int[][] tiempo = new int[escala][escala];
//int tiempo = 0,tiempo2=0;
boolean boo = true;
int duracion = 30;


void setup() {
  size(640, 480);
  borX = width/4;
  borY = height/10;
  font = createFont("Fuente", 12);
  textFont(font);
  cp5 = new ControlP5(this);
  cp5.addButton("Play")
     .setValue(0)
     .setPosition(30,100)
     .setSize(40,40)
     .updateSize()
     ;
  
  // and add another 2 buttons
  cp5.addButton("Stop")
     .setValue(1)
     .setPosition(30,50)
     .setSize(40,40)
     .updateSize()
     ;
   cp5.addSlider("duracion")
     .setPosition(30,20)
     .setRange(0,100)
     ;
  
  minim = new Minim(this);
  
  out = minim.getLineOut(Minim.STEREO);
  nullSine= new SineWave(0, 0, out.sampleRate());
  sine = new SineWave(0, amp, out.sampleRate());
  sine.portamento(port);
  out.addSignal(sine);
  
  
  player = minim.loadFile("c.wav");
  
  
  
  
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      tocado[i][j] = false;
      tiempo[i][j] = 0;
    }
  }
}

void draw() {
  background(100);   
  stroke(100);
  strokeWeight(0.05);
  
  
  //int ancho = width/2/escala+1;
  //int alto = height/escala+1;
  
  //translate(-escala/2, -escala/2);
  
  translate(borX,borY);
  scale(escala);
  fill(200);
  

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      
      if(j%2 == 0) {
        fill(200);
        if(tocado[i][j]){
           fill(200,0,0);
        }
        pushMatrix();    
        translate(0,0);
        translate(i, j);
        
        scale(1,1.24);
        beginShape();
        vertex(0, 0.25);
        vertex(0.5, 0);
        vertex(1, 0.25);
        vertex(1, 0.75);
        vertex(0.5, 1);
        vertex(0, 0.75);
        endShape(CLOSE);
        popMatrix();
      }else{
        fill(200);
        if(tocado[i][j]){
           fill(200,0,0);
        }
        pushMatrix();
        translate(0.5, 0);
        translate(i, j);
        scale(1,1.24);
        beginShape();
        vertex(0, 0.25);
        vertex(0.5, 0);
        vertex(1, 0.25);
        vertex(1, 0.75);
        vertex(0.5, 1);
        vertex(0, 0.75);
        endShape(CLOSE);
        popMatrix();
      }
    }
  }
  scale(0.0333);
    for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      
      if(j%2 == 0) {   
        if(mouseX > borX + i*escala && mouseX < (borX+escala)+i*escala && mouseY > borY+j*escala && mouseY < (borY+escala)+j*escala ){
          tocado[i][j] = true;
          notActual = fi[j][i]; 
          nota = notas[notActual];
          println(notActual+"   "+nota);
          sine.setAmp(0.7);
          sine.setFreq(nota);
          if(tiempo[i][j] < duracion && tocado[i][j]){
            sine.setAmp(0.7);
            tiempo[i][j]++;
          }else {
            sine.setAmp(0.0);       
          }
         }else{
         tocado[i][j] = false;
         tiempo[i][j] = 0;
         }
        fill(50);
        text(fi[j][i], escala*i+20,escala*j+25);   
      }else{     
        if(mouseX > borX + (i+.5)*escala && mouseX < (borX+escala)+(i+.5)*escala && mouseY > borY+j*escala && mouseY < (borY+escala)+j*escala ){
          tocado[i][j] = true;
          notActual = fi[j][i]; 
          nota = notas[notActual];
         println(notActual+"   "+nota);
          if(tiempo[i][j] < duracion && tocado[i][j]){
            sine.setAmp(0.7);
            tiempo[i][j]++;
          }else {
            sine.setAmp(0.0);       
          }

          sine.setFreq(nota);
       
         }else{
          tocado[i][j] = false;
          tiempo[i][j] = 0;
         }
        text(fi[j][i], escala*(i+.5)+20,escala*j+25);
      }
      if(mouseX < borX){
        sine.setAmp(0.0);
        
      } 
      if(mouseX > borX+(300)){
        sine.setAmp(0.0); 
        
      }
      if(mouseY < borY){
        sine.setAmp(0.0);
        
      }
        
      if(mouseY > borX+(300)){
      sine.setAmp(0.0);
      
      }
    }
  
}
translate(-borX,-borY);
pushMatrix();
stroke(230);
strokeWeight(1);
translate(width/4, height-120);
 for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, width/2 );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width/2 );
    line( x1, 30 + player.left.get(i)*30, x2, 30 + player.left.get(i+1)*30 );
    line( x1, 90 + player.right.get(i)*30, x2, 90 + player.right.get(i+1)*30 );
  }
popMatrix();





}

public void controlEvent(ControlEvent theEvent) {
 
  
  if(theEvent.getName() == "Play"){
  player.loop();
  
  }
  if(theEvent.getName() == "Stop"){
  player.pause();
  }
}

