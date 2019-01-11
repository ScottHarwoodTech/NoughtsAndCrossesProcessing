int SIZE = 3;
int SECTIONSIZE;
int PADDING = 20;
int OFFSET;
String[][] state;
String currentPlayer = "x";
void setup() {
  size(400,400);
  SECTIONSIZE = (width / SIZE) - PADDING;  
  OFFSET = width/SIZE;
  state = new String[SIZE][SIZE];
  for (int y = 0; y < SIZE; y++)
  {
    for (int x = 0; x < SIZE; x++)
    {
      state[x][y] = "-";
    }
  }
}
void mouseClicked() {
  stroke(100);
  int x = mouseX / OFFSET;
  int y = mouseY / OFFSET;
  println(x, y);
  if (state[y][x] == "-") { 
    state[y][x] = currentPlayer;
    if (currentPlayer == "o") {
      currentPlayer = "x";
    } else {
      currentPlayer = "o";
    }
  }
}
void draw() {
  background(51);
  stroke(200);
  drawGrid();
  drawState();
  String winner = checkWinners();
  if (winner != "-") {
      println(winner);
  }
}

String checkWinners() {//returns the winner
  //check crosses
  boolean win = true;
  for (int i=0; i < SIZE; i++)
  {
    if (state[i][i] != state[0][0]) {
      win = false;
      break;
    }
  }
  if (win) {return state[0][0];}
  win = true;
  for (int i=0; i < SIZE; i++)
  {
    if (state[i][SIZE - i - 1] != state[0][0]) {
      win = false;
      break;
    }
  }
  if (win) {return state[SIZE][SIZE];}
  
  //check rows
    for (int y = 0; y < SIZE; y++)
    {
      win = true;
      for (int x = 0; x < SIZE; x++)
      {
        if (state[y][x] != state[y][0]) {
          win = false;
          break;
        }
      }
      if (win) { return state[y][0]; }
    }
    //check columms 
    for (int x = 0; x < SIZE; x++)
    {
      win = true;
      for (int y = 0; y < SIZE; y++)
      {
        if (state[y][x] != state[0][x]) {
          win = false;
          break;
        }
      }
      if (win) { return state[0][x]; }
    }
    //check draw
    boolean draw = true;
     for (int x = 0; x < SIZE; x++)
    {
      for (int y = 0; y < SIZE; y++)
      {
        if (state[y][x] == "-") {
          draw = false;
        }
      }
      if (!draw) { return "-"; }
      break;
    }
    if (draw) { return "draw";}
  return "-";
}
void drawNought(int x ,int y) {
  ellipseMode(CORNER);
  ellipse(x,y,SECTIONSIZE,SECTIONSIZE);
}

void drawCross(int x, int y){
  strokeWeight(2);
  stroke(100);
  line(x,y,x + SECTIONSIZE,y + SECTIONSIZE);
  line(x + SECTIONSIZE,y, x, y + SECTIONSIZE);
}
void drawState() {
  for (int y = 0; y < SIZE; y++)
    {
      for (int x = 0; x < SIZE; x++)
      {
        if (state[y][x] == "o"){
          drawNought(x*OFFSET + PADDING/2 ,y*OFFSET + PADDING/ 2);
        } else if (state[y][x] == "x") {
          drawCross(x*OFFSET + PADDING / 2 ,y*OFFSET + PADDING / 2);
        }
      }
    }
}

void drawGrid() {
  strokeWeight(1);

  for (int y = 1; y < SIZE; y++)
  {
    line(0,y* OFFSET,width,y*OFFSET);
  }
  for (int x = 1; x < SIZE; x++)
   {
      line(x *OFFSET,0,x * OFFSET,height);
    }
}