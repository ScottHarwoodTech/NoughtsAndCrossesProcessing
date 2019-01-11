# Making Noughts and Crosses in Processing
---
## What is Processing?
Processing was created to allow artists to code! It was designed to make it easy to draw things!

## What are we making today?
Today you will make a game of Noughts and Crosses that means you and a partner can click to place your piece.
## What do we already have?
You have been given a piece of Starter code
```java
int SIZE = 3; //size of the grid that the game will be played in 3x3 currently
int SECTIONSIZE;
int PADDING = 20;
int OFFSET;
String[][] state; // the current position of the noughts and crosses
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
  stroke(200); //This sets the color of any shape you draw from this point on, if you call this again it doesn't change the color of anything that was already drawn
  drawGrid(); //Draws the board
  drawState(); //Draws all the pieces on the board
}

void drawNought(int x ,int y) { //Draws a Nought piece
  ellipseMode(CORNER);
  ellipse(x,y,SECTIONSIZE,SECTIONSIZE); //draws a circle that has the top left hand corner at the point x, y which is passed to the function!
}

void drawCross(int x, int y){ // Draws a Cross piece
  strokeWeight(2); //sets the width of  the lines
  stroke(100); //sets the colors of the lines
  line(x,y,x + SECTIONSIZE,y + SECTIONSIZE); //draws a line from the top left of the little square to the bottom right of the square
  line(x + SECTIONSIZE,y, x, y + SECTIONSIZE); //draws a line from the top right of the little square to the bottom left of the square
}

void drawGrid() {
  strokeWeight(1);//sets the width of the lines

  for (int y = 1; y < SIZE; y++) {//loop over all the columns and draws a line from the top of the screen to the bottom of the screen
    line(0,y* OFFSET,width,y*OFFSET);
  }
  for (int x = 1; x < SIZE; x++) {//loops over all the rows and draws a line from the left hand side of the screen to the right of the screen
      line(x *OFFSET,0,x * OFFSET,height);
  }
}

void drawState() {
  for (int y = 0; y < SIZE; y++) { //Loops over all the little squares on the grid
    for (int x = 0; x < SIZE; x++) {
      if (state[y][x] == "o") { //if that little square should have a nought in it calls the drawNought function and puts one in that square
        drawNought(x*OFFSET + PADDING/2 ,y*OFFSET + PADDING/ 2);
      } else if (state[y][x] == "x") {//if the square should have a cross in it then the drawCross function is called
        drawCross(x*OFFSET + PADDING / 2 ,y*OFFSET + PADDING / 2);
      }
    }
  }
}
```
If you load the code in processing by going to `file -> open` you will be able to run the program by pressing the button in the top left of the screen.

Another window should have popped up now creating the standard Noughts and Crosses grid.
![Current Grid](https://github.com/ScottHarwoodTech/NoughtsAndCrossesProcessing/blob/master/blank%20board.PNG)

## Adding placing the pieces in the right places.
First we are going to add is the ability to place a piece on the board.

Insert this piece of code inside your project after the setup function
```java
void mouseClicked() {
  int x = mouseX / OFFSET; //finds the location of the mouse pointer in terms of the small grid
  int y = mouseY / OFFSET;
  println(x, y);
  if (state[y][x] == "-") { // if the spot does not have a piece on it then you are allowed to place one there
    state[y][x] = currentPlayer; // set the location of the piece in the state to the current player
    if (currentPlayer == "o") {
      currentPlayer = "x";//change the current player to the opposite
    } else {
      currentPlayer = "o";
    }
  }
}
```
![Board with pieces on it](https://github.com/ScottHarwoodTech/NoughtsAndCrossesProcessing/blob/master/Board%20with%20pieces%20on%20it.PNG)


Now that you have added this code you should be able to run the program again and click to place pieces.

## Adding the win conditions
Now that we are able to place pieces onto the board we need to be able to decide who wins so we are going to make a new function called checkWinner which will check to see if the board has a winner every time it is drawn.
Add this piece of code into the editor below the drawNought function. This code checks to see if there is a winner by looking at the crosses, rows, columns and seeing if there was a draw.
```java
String checkWinners() {//returns the winner
  //check crosses
  boolean win = true;
  for (int i=0; i < SIZE; i++) {
    if (state[i][i] != state[0][0]) {
      win = false;
      break;
    }
  }
  if (win) {
    return state[0][0];
  }
  win = true;
  for (int i=0; i < SIZE; i++){
    if (state[i][SIZE - i - 1] != state[0][0]) {
      win = false;
      break;
    }
  }
  if (win) {
    return state[SIZE][SIZE];
  }

  //check rows
  for (int y = 0; y < SIZE; y++) {    
    win = true;
    for (int x = 0; x < SIZE; x++){
      if (state[y][x] != state[y][0]) {
        win = false;
        break;
      }
    }
    if (win) {
      return state[y][0];
    }
  }
  //check columms
  for (int x = 0; x < SIZE; x++) {
    win = true;
    for (int y = 0; y < SIZE; y++) {
      if (state[y][x] != state[0][x]) {
        win = false;
        break;
      }
    }
    if (win) {
      return state[0][x];
    }
  }
  //check draw
  boolean draw = true;
  for (int x = 0; x < SIZE; x++) {
    for (int y = 0; y < SIZE; y++) {
      if (state[y][x] == "-") {
        draw = false;
        break
      }
    }
    if (!draw) {
      return "-";
    }

  }
  if (draw) {
    return "draw";
  }
  return "-";
}
```

Every time we draw the screen we need check if there is a winner so the best place to add that would be the draw function. Change your draw function to look like this
```java
void draw() {
  background(51); //sets the color of the background feel free to change the color to what ever you like!
  stroke(200); //This sets the color of any shape you draw from this point on, if you call this again it doesn't change the color of anything that was already drawn
  drawGrid(); //Draws the board
  drawState(); //Draws all the pieces on the board
  String winner = checkWinners(); //calls the check winner function
  if (winner != "-") { // if there is either a winner or a draw then the winner is printed to the console and the game is stopped
      println(winner);
      stop();
  }
}
```
![Board Showing Winner](https://github.com/ScottHarwoodTech/NoughtsAndCrossesProcessing/blob/master/WinnerBoard.PNG)
## Your game is now finished, awesome!
Now that your game is all done you can begin to add new features such as:
* drawing the winner on the screen!
* Making your own version of the noughts and crosses maybe pythons and coffee mugs?
* Change the size of the grid, imagine playing on a 25 x 25 noughts and crosses board!
