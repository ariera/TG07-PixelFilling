/********************************************************
 *                                                       *
 *  19/04/2010                                           *
 *  TÉCNICAS GRAFICAS - Transformaciones Geometricas     *
 *                                                       *
 *  Alejandro Riera Mainar                               *
 *  NºMat: 010381                                        *
 *  ariera@gmail.com                                     *
 *                                                       *
 ********************************************************/
float PI = 3.141592;
int SIZE = 500;
char DIRECCION = 'd';
PImage output, input;
int X, Y = 0;
float ALFA = 0;
int ZOOM = 1;
int OFFSET = 100;

void setup() {
  size(SIZE, SIZE);
  colorMode(RGB);  
  input  = loadImage("basketball_icon.gif");
  output = createImage(SIZE, SIZE, RGB);
//  X = (int)SIZE/2 - (int)input.width/2;
//  Y = (int)SIZE/2 - (int)input.height/2;
  process(input, output);
}



void draw() {

}

void process(PImage input, PImage output){
  background(192, 64, 0);
  input.loadPixels();
  output.loadPixels();

  mover(input, output);

  output.updatePixels();
  input.updatePixels();
  image(output,0,0);
}

void mover(PImage input, PImage output){
  int loc = 0;
  color c;
  int oldx, oldy = 0;

  for (int x = 0; x < output.width; x++) {
    for (int y = 0; y < output.height; y++ ) {
      loc = x + y*output.width;
      output.pixels[loc] = color(0);
    }
  }

  for (int x = 0; x < output.width; x++) {
    for (int y = 0; y < output.height; y++) {
      oldx = (int)(cos(ALFA) * (x) - sin(ALFA) * (y))/ZOOM;
      oldy = (int)(sin(ALFA) * (x) + cos(ALFA) * (y))/ZOOM;
      c= getColorLoc(oldx, oldy, input);
      colorea(x, y, ZOOM, c, output);
    }
  }
}

void colorea(int x, int y, int zoom, color c, PImage img){
  for (int i = 0; i < zoom; i++) 
    for (int j = 0; j < zoom; j++) 
      img.set(x*zoom+i+X, y*zoom+j+Y, c);    
}

color getColorLoc(int x, int y, PImage img){
  int loc;
  loc = x + y*img.width;
//  if (loc < img.width * img.height)
  if (x > 0 && x < img.width && y < img.height && y > 0)
    return color(img.pixels[loc]);
  else
    return color(0);
}

void nuevaPosicion(char dir){
  switch(dir){ 
  case 'w':
    Y -= 10;
    break;
  case 's':
    Y += 10;
    break;
  case 'a':
    X -= 10;
    break;
  case 'd':
    X += 10;
    break;
  };
}


void keyPressed(){
  switch(key){ 
  case 'z':
    ALFA += PI/6;
    break;
  case 'x':
    ALFA -= PI/6;
    break;
  case '+':
    ZOOM += 1;
    break;
  case '-':
    ZOOM -= 1;
    break;    
  default:
    nuevaPosicion(key);
  };
  process(input, output);
}







