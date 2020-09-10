

VLine v1 = new VLine();
float [] velocidad = new float [3];
float vpos;

void setup () {
   size (400,400);
   velocidad [0] = 0.1;
   velocidad [1] = 2.0;
   velocidad [2] = 0.5;
}

void draw () {
  vpos += velocidad [int(random(3))];
  if (vpos > height) {
     vpos = 0;
  }
  v1.update(vpos);
}


//line(x1, y1, x2, y2)
class VLine {
  void update (float x) {
    line (x, 0, x, height);
  }
}
  