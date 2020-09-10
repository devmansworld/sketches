import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioPlayer chickenPlayer;

PFont f, f2;

Bot Player;
CarManager EnemyManager;
Sidewalk SidewalkManager;

float progress;
int roundTime, startMillis;
int roundLength;
float score;
boolean showTitle;
int endCounter;
float speedBonus;

/* @pjs preload="title.gif"; */
/* @pjs preload="port1.gif"; */
/* @pjs preload="port2.gif"; */
/* @pjs preload="port3.gif"; */
/* @pjs preload="port4.gif"; */
/* @pjs preload="port5.gif"; */
/* @pjs preload="chicken_run1.gif"; */
/* @pjs preload="chicken_run2.gif"; */
/* @pjs preload="car_1.gif"; */
/* @pjs preload="car_2.gif"; */
/* @pjs preload="blue_car_1.gif"; */
/* @pjs preload="blue_car_2.gif"; */
/* @pjs preload="pink_car_1.gif"; */
/* @pjs preload="pink_car_2.gif"; */
/* @pjs preload="cityscape.gif"; */
/* @pjs preload="road.gif"; */
/* @pjs preload="leftSide.gif"; */
/* @pjs preload="rightSide.gif"; */

// Images to load in
PImage title, P1, P2, P3, P4, P5, playerSprite, playerSprite2, carSprite, carSprite2, blueCarSprite, blueCarSprite2, pinkCarSprite, pinkCarSprite2, cityScape, roadSprite, leftSidewalk, rightSidewalk;

void setup()
{
  size(600,400,P2D);
  frameRate(60);
  smooth(0);
  noStroke();
  showTitle = true;
  endCounter = 0;
  speedBonus = 0;
  
  // Setup sound stuff
  minim = new Minim(this);
  // load a file, give the AudioPlayer buffers that are 2048 samples long
  player = minim.loadFile("b.mp3");
  chickenPlayer = minim.loadFile("a.mp3");
  
  //roundLength = player.length();    
  roundLength =103000;
  
  f = createFont("Impact", 50, false);
  f2 = createFont("Impact", 20, false);
  textAlign(CENTER);
  
  title = loadImage("title.gif");
  P1 = loadImage("port1.gif");
  P2 = loadImage("port2.gif");
  P3 = loadImage("port3.gif");
  P4 = loadImage("port4.gif");
  P5 = loadImage("port5.gif");
  playerSprite = loadImage("chicken_run1.gif");
  playerSprite2 = loadImage("chicken_run2.gif");
  carSprite = loadImage("car_1.gif");
  carSprite2 = loadImage("car_2.gif");
  blueCarSprite = loadImage("blue_car_1.gif");
  blueCarSprite2 = loadImage("blue_car_2.gif");
  pinkCarSprite = loadImage("pink_car_1.gif");
  pinkCarSprite2 = loadImage("pink_car_2.gif");
  cityScape = loadImage("cityscape.gif");
  roadSprite = loadImage("road.gif");
  leftSidewalk = loadImage("leftSide.gif");
  rightSidewalk = loadImage("rightSide.gif");  
}


void draw()
{
  if (showTitle)
  {
    // force initialize the fonts
    textFont(f);    
    text("¿jugar?",width/2,120);      
    textFont(f2);
    text("para empezar presiona R",width/2,290);
      
    image(title,0,0);
  }
  else
  {
    progress = map(roundTime, 0,roundLength, 0,1);
    
    speedBonus += (Player.xPos/600) / roundLength;
    //progress += speedBonus;
    
    if (progress > 1.05)
    {
      progress = 1.05;
    }
    
    background(#800080); 
    fill(#ffff00);
    ellipse(500,50,50,50);
    image(cityScape, -(int(800 * progress) % cityScape.width),0);
    image(cityScape, cityScape.width - (int(800 * progress) % cityScape.width),0);
    
    fill(#808000);
    rect(0,150,width,height); 
    image(roadSprite, -(int(30000 * progress) % roadSprite.width),143);
    image(roadSprite, roadSprite.width-(int(30000 * progress) % roadSprite.width),143);
    
    SidewalkManager.update();
    Player.update();    
    EnemyManager.update();    
    
    SidewalkManager.draw();
    Player.draw();    
    EnemyManager.draw();    
    
    roundTime = millis() - startMillis;
        
    fill(255);
    if (Player.alive)
    {
      pushStyle();
      stroke(0);
      strokeWeight(2);
      line(250, 300, width - 50, 300);
      line(250, 290, 250, 310);
      line(width - 50, 290, width - 50, 310);
      
      fill(255);
      noStroke();
      ellipseMode(CENTER);
      ellipse(map(progress,0,1,250,width - 50), 300, 10,10);
      popStyle();
    }
    
    if ((!Player.alive) && (Player.canWin == false))
    {
      textFont(f);
    
      text("Fin del Juego",width/2,120);
      text("has cruzado:",width/2,210);
      text("" + int(score) +"%",width/2,260);
      textFont(f2);
      text("del camino",width/2,290);
      text("Presiona R para empezar de nuevo",width/2,330);
      
      endCounter += 1;
    }
    
    if ((progress < 0.065) && (progress > 0.015))
    {
      textFont(f);
    
      text("Llega hasta el final",width/2,80);
      
    }
    
    if ((progress < 0.065) && (progress > 0.035))
    {
      
      textFont(f2);
      text("Muévete usando las flechas izquierda y derecha",width/2,110);
      text("'Salta con la Barra Espaciadora",width/2,140);
    }     
    
    if ((progress > 1) && (Player.canWin))
    {
      textFont(f);
    
      text("Has Ganado!",width/2,60);
      textFont(f2);
      text("Presiona R para empezar nuevamente",width/2,90);
      Player.alive = false;
      endCounter += 1;
    }
  }
  
  if (endCounter > 1800)
  {
    showTitle = true;
  }  
}

void restartGame()
{
  chickenPlayer.pause();
  chickenPlayer.rewind();
  player.rewind();
  progress = 0;
  startMillis = millis();  
  Player = new Bot();
  EnemyManager = new CarManager();
  SidewalkManager = new Sidewalk();
  player.play();
  endCounter = 0;
  speedBonus = 0;
}

void stop()
{
  // always close Minim audio classes when you are done with them
  player.rewind();
  player.close();
  chickenPlayer.rewind();
  chickenPlayer.close();
  // always stop Minim before exiting
  minim.stop();
  
  super.stop();
}







class Bot 
{
  float xPos, yPos;
  float minX = 0, maxX = 600;
  float maxY = 150;
  float ySpeed, xSpeed;
  float xAccel;
  
  float speed; // this is a value that goes from 0 to 1 which corresponds to min and max X
  float gravity = 0.2, hGravity = 0.2;
  float forwardForce, backwardForce;
  int lives = 3;
  boolean alive, vulnerable, canWin;
  boolean leftPress;
  int vulnerableCounter;
  float portraitPos;
  
  int frame;
  
  
  Bot()
  {
    xPos = -150;
    yPos = 150;
    
    ySpeed = 0;
    xSpeed = 25;
    backwardForce = 0.5;
    forwardForce = 2;
    
    alive = true;
    vulnerable = true;
    canWin = true;
    leftPress = false;
    frame = 0;
  }
  
  void update()
  {
    
    if (alive)
    {
      // Jumping
      if (yPos <= maxY)
      {
        ySpeed += gravity;
        yPos += ySpeed;
      }
      if (yPos > maxY)
      {
        yPos = maxY;
        ySpeed = 0;
      }
      
      speed = map(xPos, minX, maxX, 0, 1);
      
      if (speed < 0.2)
      {
        backwardForce = (pow(speed,3)) * 3;
      }
      else if (speed > 0.8)
      {
        backwardForce = (pow(speed,3)) * 3;
      }
      else
      {
        backwardForce = 0.24 + (speed * 0.1);
      }
      
      
      forwardForce -= 0.07;
      if (forwardForce < 0)
      {
        forwardForce = 0;
      }
        
      xAccel = 0;
      xAccel -= backwardForce;
      xAccel += forwardForce;
      
      xSpeed += xAccel;
      //friction
      xSpeed -= (xSpeed * 0.05);
      
      if (xSpeed > 6)
      {
        xSpeed = 6;
      }
      
      if (xSpeed < -6)
      {
        xSpeed = -6;
      }
      
      xPos += xSpeed;
      if (xPos > maxX)
      {
        xPos = maxX;
      }
    }
    else
    {
      xPos -= 4;
    }
    
    
    //Check for collisions
    if (EnemyManager.isColliding(xPos,yPos)  && (alive))
    {
      this.hit();
    }
  }
 
  void draw()
  {
    if (alive)
    {
      frame = (frame+1) % 12;
    }
    
    if (vulnerableCounter > 0)
    {
      vulnerableCounter -= 1;
    }
    else
    {
      if (alive)
      {
        
        chickenPlayer.rewind();
        chickenPlayer.pause();
        vulnerable = true;
      }
    }
    
    
    // Draw shadow
    pushMatrix();
    pushStyle();
    
    fill(#000000);
    translate(this.xPos, maxY + 8);
    ellipseMode(CENTER);
    ellipse(0,0,(38 * (1 - (maxY - yPos)/(0.5*maxY))),(10 * (1 - (maxY - yPos)/(maxY))));
    
    popStyle();
    popMatrix();
    
    // Draw chicken
    if ((vulnerableCounter % 4) == 0)
    {
      pushMatrix();
      translate(this.xPos, this.yPos);
      if (frame > 6)
      {
        image(playerSprite,-(playerSprite.width/2),12-(playerSprite.height));
      }
      else
      {
        image(playerSprite2,-(playerSprite.width/2),12-(playerSprite.height));
      }
      popMatrix();
    }
    
    
    // Show Health
    switch(lives)
    {
      case 3:
        image(P1, 0, 420 - P1.height);
        break;
      case 2:
        image(P2, 0, 420 - P2.height);
        break;
      case 1:
        image(P3, 0, 420 - P3.height);
        break;
      case 0:
        image(P4, random(-1,1), 420 - P4.height);
        break;
      case -1:
        image(P5, random(-2,2), 420 - P5.height + (portraitPos - xPos) * 0.15);
        break;
    }
  }
  
  void jump()
  {
    if (yPos >= maxY - 10)
    {
      ySpeed = -5.2;
    }
  }
  
  void hit()
  {
    if (vulnerable)
    {
      if (alive)
      {
        chickenPlayer.play();
      }
      
      lives -= 1;
      if (lives < 0)
      { 
        alive = false;
        Player.canWin = false;
        portraitPos = xPos;
        score = progress * 100;
      }
      else
      {
        
        vulnerable = false;
        vulnerableCounter = 120;
      }
    } 
  }
  
  void beat(boolean left)
  {
    if (left && !leftPress)
    {
      leftPress  = true;
      forwardForce +=  0.6;
    }
    else if (!left && leftPress)
    {
      leftPress  = false;
      forwardForce +=  0.6;
    }
  }
  
}
class Car 
{
  float xPos, yPos;
  float xSpeed;
  float colLength, colHeight;
  boolean isAlive;
  PShape s;
  int type;  
  int frame;
  
  Car(float speed, int inputType)
  {
    xPos = (600) + 70;
    colLength = 70;
    colHeight = 20;
    xSpeed = speed;
    yPos = 150; 
    frame = 0;
    type = inputType;
    
    if (speed < 0) 
    {
      isAlive = true;
    }
    else
    {
      isAlive = false;
    }    
  }
  
  void update()
  {
    if (isAlive)
    {
      xPos += xSpeed;
      if (xPos < -40)
      {
        isAlive = false;
      }
    }
  }
  
  
  void draw()
  {
    if (isAlive)
    {
      frame = (frame+1) % 12;
      
      pushMatrix();
      translate(xPos, yPos);
      
      if (frame > 6)
      {
        if (type == 1)
        {
          image(carSprite, -carSprite.width /2, 12 - carSprite.height);
        }
        else if (type == 2)
        {
          image(blueCarSprite, -carSprite.width /2, 12 - carSprite.height);
        }
        else if (type == 3)
        {
          image(pinkCarSprite, -carSprite.width /2, 12 - carSprite.height);
        }
      }
      else
      {
        if (type == 1)
        {
          image(carSprite2, -carSprite.width /2, 12 - carSprite.height);
        }
        else if (type == 2)
        {
          image(blueCarSprite2, -carSprite.width /2, 12 - carSprite.height);
        }
        else if (type == 3)
        {
          image(pinkCarSprite2, -carSprite.width /2, 12 - carSprite.height);
        }
      }   
    
      popMatrix();      
    }
  }
  
  boolean isColliding(float x, float y)
  {
    if (isAlive)
    {
      if ((x < (xPos + colLength/2)) && (x > (xPos - colLength/2)) && (y > (yPos - colHeight)))
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      return false;
    }
  }
}
class CarManager
{
  Car Car1;
  Car Car2;
  Car Car3;
  Car Car4;
  
  CarManager()
  {
    Car1 = new Car(0,1);
    Car2 = new Car(0,1);
    Car3 = new Car(0,1);
    Car4 = new Car(0,2);
  }
  
  void update()
  {
    Car1.update();
    Car2.update();
    Car3.update();
    Car4.update();
    
    if ((progress < 0.96) && (random(2) < (0.18 + progress * 0.2) ) && (random(2) < 0.18 + progress * 0.2) && (progress > 0.06))
    {
      generateCar();
    }
    
    if ((progress < 0.96) && (random(2) < (0.18 + progress * 0.2) ) && (random(2) < 0.18 + progress * 0.2) && (progress > 0.8))
    {
      generateCar2();
    }
    
    if ((progress < 0.96) && (random(2) < (0.18 + progress * 0.2) ) && (random(2) < 0.18 + progress * 0.2) && (progress > 0.53))
    {
      generateCar3();
    }
  }
  
  void draw()
  {
    Car1.draw();
    Car2.draw();
    Car3.draw();
    Car4.draw();
  }
  
  boolean isColliding(float x, float y)
  {
    if (Car1.isColliding(x,y) || Car2.isColliding(x,y) || Car3.isColliding(x,y) || Car4.isColliding(x,y))
    {
      return true;
    }
    else
    {
      return false;
    } 
  }
  
  void generateCar()
  {
    if(!Car1.isAlive)
    {
      Car1 = new Car(-6,1);
    } 
    else if(!Car2.isAlive)
    {
      Car2 = new Car(-6,1);
    }
    
  }
  
  void generateCar2()
  {
    if(!Car4.isAlive)
    {
      Car4 = new Car(-8,2);
    } 
  }
  
  void generateCar3()
  {
    if(!Car3.isAlive)
    {
      Car3 = new Car(-6,3);
    }
  }
  
}
// Handle input
void keyPressed() 
{
  if ( showTitle)
  {
    showTitle = false;
    restartGame();
  }
  
  if (keyCode == LEFT)  //This code is a bit redundant, but Windows is being finicky about key presses
  {  
    Player.beat(true);    
  }
  else if (keyCode == RIGHT) 
  {
    Player.beat(false);
  }   
  else if (key == CODED) 
  {
    
    if (keyCode == LEFT)
    {
      Player.beat(true);
    } 
    else if (keyCode == RIGHT) 
    {
      Player.beat(false);      
    } 
  }   
  
  if (keyCode == ' ')
  {
    Player.jump();
  } 
    
  if (key == 'r' || key == 'R')
  {
    restartGame();
  }   
}
class Sidewalk 
{
  float xPos;
  float xSpeed;
  float finalPosition;
  boolean victoryReached;  
  
  Sidewalk()
  {
    xPos = 0;
    xSpeed = 5;
    victoryReached = false;
  }
  
  void update()
  {
    xPos -= xSpeed; 
    if(progress > 0.98)
    {
      if (!victoryReached)
      {
        finalPosition = xPos;
      }
      victoryReached = true;
    } 
  }
  
  void draw()
  {
    if (progress < 0.05)
    {
      image(leftSidewalk, xPos, 113);
    } 
    else if (progress > 0.98)
    {
      image(rightSidewalk, max(600 + (xPos - finalPosition), -200), 116);      
    }
  }
}



