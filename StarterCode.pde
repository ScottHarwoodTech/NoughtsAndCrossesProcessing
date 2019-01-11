int SIZE = 3; //size of the grid that the game will be played in 3x3 currently
int SECTIONSIZE;
int PADDING = 20;
int OFFSET;
String[][] state; // the current position of the naughts and crosses
/* The computer things that the state variable is a little grid so it knows what the board currently looks like
It thinks it looks like this:
[[ -, -, -],
 [ -, -, -],
 [ -, -, -]]
 Which means that is a blank board
*/
void setup() { // This is the setup function, processing calls this once when you load up your program, you use it to setup your program and set things like variables.
   size(400,400);//set the size of the screen, always make sure that it is a square! But feel free to make it as big as you want
  SECTIONSIZE = (width / SIZE) - PADDING;  //This sets the size of the little squares inside the grid
  OFFSET = width/SIZE; //used for setting the location of all the shapes
  state = new String[SIZE][SIZE]; 
  for (int y = 0; y < SIZE; y++) {
    for (int x = 0; x < SIZE; x++) {
      state[x][y] = "-"; // This sets all little squares on the board to "-"
    }
  }
}

void draw() {// This is the draw 
  background(51); //sets the color of the background feel free to change the color to what ever you like!
  stroke(200); //This sets the color of any shape you draw from this point on, if you call this again it doesnt change the color of anything that was already drawn
  drawGrid(); //Draws the board
  drawState(); //Draws all the pieces on the board
}

void drawNought(int x ,int y) { //Draws a Nought piece
  ellipseMode(CORNER);
  ellipse(x,y,SECTIONSIZE,SECTIONSIZE); //draws a circle that has the top left hand corner at the point x,y which is passed to the function!
}

void drawCross(int x, int y){ // Draws a Cross piece
  strokeWeight(2); //sets the width of  the lines
  stroke(100); //sets the colors of the lines
  line(x,y,x + SECTIONSIZE,y + SECTIONSIZE); //draws a line from the top left of the little square to the bottom right of the square 
  line(x + SECTIONSIZE,y, x, y + SECTIONSIZE); //draws a line from the top right of the little square to the bottom left of the square
}

void drawGrid() {
  strokeWeight(1);//sets the width of the lines

  for (int y = 1; y < SIZE; y++) {//loop voer over all the columns and draws a line from the top of the screen to the bottom of the screen
    line(0,y* OFFSET,width,y*OFFSET);
  }
  for (int x = 1; x < SIZE; x++) {//loops over all the rows and draws a line from the left hand side of the screen to the right of the screen
      line(x *OFFSET,0,x * OFFSET,height);
  }
}

void drawState() {
  for (int y = 0; y < SIZE; y++) { //Loops over all the little squares on the grid 
    for (int x = 0; x < SIZE; x++) {
      if (state[y][x] == "o") { //if that little square should have a naught in it calls the drawNaught function and puts one in that square
        drawNought(x*OFFSET + PADDING/2 ,y*OFFSET + PADDING/ 2);
      } else if (state[y][x] == "x") {//if the square should have a cross in it then the drawCross function is called
        drawCross(x*OFFSET + PADDING / 2 ,y*OFFSET + PADDING / 2);
      }
    }
  }
}