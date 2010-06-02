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
int SIZE = 200;
char DIRECCION = 'd';
PImage output, input;
int X, Y = 0;
float ALFA = 0;
int ZOOM = 1;
int OFFSET = 100;
int TITLE_HEIGHT = 50;


void setup() {
  size(SIZE, SIZE+TITLE_HEIGHT + 100);
  colorMode(RGB);  
  input  = loadImage("basketball_icon.gif");
  output = createImage(SIZE, SIZE, RGB);
  //  X = (int)SIZE/2 - (int)input.width/2;
  //  Y = (int)SIZE/2 - (int)input.height/2;
  process(input, output);
  displayTitle();
  display_instructions(output.width, output.height);
}

void displayTitle(){
  textFont(createFont("Helvetica", 12));
  fill(color(0));
  text("Ejercicio 7: Transformaciones\n Geometricas, Pixel-Filling" , 10, 20);
}

void display_instructions(int base_width, int base_height){
  fill(color(0));
  textFont(createFont("Helvetica", 14));
  text("Controles:\n\t\t\t'+' y '-' escalan\n\t\t\t'z' y 'x' rotan\n\t\t\t'a', 's', 'd', 'w' transladan" , 10, base_height + TITLE_HEIGHT + 20);  
}



void draw() {

}

void process(PImage input, PImage output){
  input.loadPixels();
  output.loadPixels();

  mover(input, output);

  output.updatePixels();
  input.updatePixels();
  image(output,0,TITLE_HEIGHT);

}

void mover(PImage input, PImage output){
  int loc = 0;
  color c;
  float oldx, oldy = 0;

  for (int x = 0; x < output.width; x++) {
    for (int y = 0; y < output.height; y++ ) {
      loc = x + y*output.width;
      output.pixels[loc] = color(0);
    }
  }

  for (int x = 0; x < output.width; x++) {
    for (int y = 0; y < output.height; y++) {
      oldx = (cos(ALFA) * (x) - sin(ALFA) * (y))/ZOOM;
      oldy = (sin(ALFA) * (x) + cos(ALFA) * (y))/ZOOM;
      c= getColorLoc(oldx, oldy, input);
      colorea(x, y, ZOOM, ALFA, c, output);
    }
  }
}

void colorea(int x, int y, int zoom, float degree, color c, PImage img){
  for (int i = 0; i < zoom; i++) 
    for (int j = 0; j < zoom; j++) 
      img.set(x*zoom+i+X + (int)sin(degree), y*zoom+j+ (int)cos(degree) +Y, c);    
}

color getColorLoc(float x, float y, PImage img){
  int loc;
  loc = (int)x + (int)y*img.width;
  if (x > 0 && x < img.width && y < img.height && y > 0)
    return color(img.pixels[loc]);
  else
    return color(0);
}

color biLineal(float x, float y, PImage img){
  int f00 = floor(x) + floor(y)*img.width;
  int f01 = floor(x) + ceil(y)*img.width;
  int f10 = ceil(x) + floor(y)*img.width;
  int f11 = ceil(x) + ceil(y)*img.width;

  color fx0a = color(img.pixels[f10]);
  color fx0b = color(img.pixels[f00]);
  color fx0 = color((red(fx0a) + red(fx0b))/2,
  (green(fx0a) + green(fx0b))/2,
  (blue(fx0a) + blue(fx0b))/2);
  color fx1a = color(img.pixels[f11]);
  color fx1b = color(img.pixels[f01]);
  color fx1 = color((red(fx1a) + red(fx1b))/2,
  (green(fx1a) + green(fx1b))/2,
  (blue(fx1a) + blue(fx1b))/2);

  color fxy = color((red(fx0) + red(fx1))/2,
  (green(fx0) + green(fx1))/2,
  (blue(fx0) + blue(fx1))/2);
  return fxy;
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








