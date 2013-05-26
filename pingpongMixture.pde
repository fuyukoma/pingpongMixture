import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Ball ball;
Pad pad;
ArrayList tracks;
boolean menu, replay;

Minim minim;
AudioPlayer base;
AudioPlayer clap;
AudioPlayer[] se = new AudioPlayer[3];

int size = 400;

int n = 1;
float b_scl = 1.0;
boolean hit = false;
int reCnt = 0;

color green = color(63, 184, 175);
color pink = color(255, 61, 127);
color gray1 = color(240);
color gray2 = color(220);
color gray3 = color(150);
void addTracks() {
  tracks.add(new Track(ball.getX(), ball.getY(), ball.getX(), ball.getY()));
}

void setup() {
  size(size, size);
  ball = new Ball(size/2, size/2, 20);
  pad = new Pad(0, 0, 10, 10);
  tracks = new ArrayList();
  tracks.add(new Track(size/2, size/2, size/2, size/2));
  minim = new Minim(this);
  base = minim.loadFile("base.mp3");
  clap = minim.loadFile("clap.mp3");
  for(int i = 0; i < se.length; i++) {
    se[i] = minim.loadFile("se"+(i+1)+".mp3");
  }
  base.loop();
}

void draw() {
  
  if(menu) {
    pushMatrix();
    translate(size/2, size/2);
    if(n >= 1 && n < 100) {
      scale(n/2);
      fill(green, n);
      ellipse(0, 0, 20, 20);
      n++;
    }else if(n >= 100 && n < 200) {
      background(gray1);
      scale(50-(n-100)/2);
      fill(green);
      ellipse(0, 0, 20, 20);
      n++;
    }else{
      background(gray1);
      if(overCircle(size/2, size/2, 20)){
        fill(pink);
        ellipse(0, 0, 20, 20);
        textAlign(CENTER, TOP);
        text("REPLAY?", 0, 20);
        if (mousePressed) {
          menu = false;
          replay = true;
          reCnt = 0;
          base.loop();
          draw();
        }
      }else{
        fill(green);
        ellipse(0, 0, 20, 20);
        fill(gray3);
        textAlign(CENTER, TOP);
        text("REPLAY?", 0, 20);
      }
    }
    popMatrix();

  }else if(replay){
    background(gray1);
    
    for(int i = 0; i < reCnt+1; i++) {
      if(i > tracks.size()-1) break;
      Track t = (Track)tracks.get(i);
      if(i == reCnt) {
          t.move();
          stroke(green);
          line(t.x1, t.y1, t.mx, t.my);
          if(t.mx == t.x2) {
            if (t.mx >= 399
                || t.mx <= 1) {
              se[0].loop();
            }else if (t.my <= 1) {
              se[1].loop();
            } else if(t.my >= 399){
                audioStop();
            }else{
              clap.play();
              clap.rewind();
            }
            
            reCnt++;
          }
      }else{
        t.show();
      }
    }
  }else{
    background(gray2);
    stroke(200);
    fill(gray1);
    pushMatrix();
    translate(-ball.getX()+size/2, -ball.getY()+size/2);
    if(b_scl >= 1.0 && b_scl <= 2.0) {
      b_scl -= 0.1;
    }
    scale(b_scl);
    rect(0, 0, 400, 400);
    ball.move();
  
    // check reflection
    if (ball.getX() >= 400
        || ball.getX() <= 0) {
      ball.dx *= -1;
      addTracks();
      se[0].loop();
    }
    if (ball.getY() <= 0) {
      ball.dy *= -1;
      addTracks();
      se[1].loop();
    } else if(ball.getY() >= 400){
        menu = true;
        audioStop();
        draw();
    }
    
    for(int i = 0; i < tracks.size(); i++) {
      Track t = (Track)tracks.get(i);
      if(i == tracks.size()-1) {
         t.setEndPt(ball.getX(), ball.getY());
      }
      if(i > tracks.size()-6) {
         t.show();
      }

    }
    popMatrix();
  
    pushMatrix();
    translate(size/2, size/2);
    if(size/2 + ball.r/2 >= pad.getX()
          && size/2 - ball.r/2 <= pad.getX() + pad.w
          && size/2 + ball.r/2 >= pad.getY()
          && size/2 - ball.r/2 <= pad.getY() + pad.h) {
      if (!hit){
        b_scl = 2.0;
        ball.dy *= -1;
        hit = true;
        addTracks();
      clap.play();
      clap.rewind();
      }
    }else{
      hit = false;
    }
    ball.show();
    popMatrix();
    pad.show();
  }
}

void audioStop() {
  base.pause();
  for(int i = 0; i < se.length; i++){
    se[i].pause();
   }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}


void stop() {
  audioStop();
  minim.stop();
  super.stop();  
}
