// Game of life implementation
// Controls:
//   clear screen:     <c>
//   randomise cells:  <r>
//   original state:   <o>
//   pause simulation: <p>

void setup()
{
  size(800, 800);
  cellWidth = width / (float)colCount;
  cellHeight = height / (float)rowCount;
  stroke(255);
  strokeWeight(0.1);
  frameRate(60);
  gameSpeed = 10;  // lower is faster

  //randomise();  // initialise board1 in a random state

  // Initialise a simple pattern
  original();

  // copy into board2
  arrCopy(board_prev, board_cur);
}

float cellWidth;
float cellHeight;

int rowCount = 100;
int colCount = 100;
boolean[][] board_cur = new boolean[rowCount][colCount];
boolean[][] board_prev = new boolean[rowCount][colCount];

boolean pause = false;
int gameSpeed;

void draw()
{
  // draw the board's current iteration
  // at this point board_cur and board_prev are the same
  background(0);
  for (int i = 0; i < rowCount; i++)
  {
    for (int j = 0; j < colCount; j++)
    {
      if (getCell(i, j) == true)
      {
        fill(0, 255, 0);
        rect(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
      } else
      {
        fill(0, 0, 0);
        rect(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
      }
    }
  }

  // only update simulation if the game isn't paused
  // this updates board_cur based on board_prev's values
  if (frameCount % gameSpeed == 0)
  {
    if (!pause)
    {
      // update the board
      for (int i = 0; i < rowCount; i++)
      {
        for (int j = 0; j < colCount; j++)
        {
          int numAlive = countLiveCells(i, j);
          // check if cell is alive in previous iteration
          if (getCell(i, j))
          {
            if (numAlive < 2 || numAlive > 3)
            {
              setCell(i, j, false);
            }
          } else
          {
            if (numAlive == 3)
            {
              setCell(i, j, true);
            }
          }
        }
      }
    }
  }

  // copy board_cur into board_prev
  arrCopy(board_prev, board_cur);
}

// Call functions based on the key a user presses
void keyPressed()
{
  switch(key)
  {
  case 'p':
    pause = !pause;
    break;
  case 'r':
    randomise();
    break;
  case 'c':
    clear();
    break;
  case 'o':
    original();
    break;
  }
}

// updates the cells in the current version of the board
void setCell(int row, int col, boolean val)
{
  // check if index is in bounds
  if (row >= 0 && row < rowCount && col >= 0 && col < colCount)
  {
    board_cur[row][col] = val;
  }
}

// checks the cells in the previous version of the board
boolean getCell(int row, int col)
{
  if (row >= 0 && row < rowCount && col >= 0 && col < colCount)
  {
    return board_prev[row][col];
  } else
  {
    return false;
  }
}

// Count the number of live cells that surround a particular cell
int countLiveCells(int row, int col)
{
  int count = 0;

  for (int i = row - 1; i <= row + 1; i++)
  {
    for (int j = col - 1; j <= col + 1; j++)
    {
      if (getCell(i, j))
      {
        count++;
      }
    }
  }

  // uncount the middle cell if it is set
  if (getCell(row, col))
  {
    count--;
  }
  return count;
}

// set an initial starting state
void randomise()
{
  for (int i = 0; i < rowCount; i++)
  {
    for (int j = 0; j < colCount; j++)
    {
      if ((int)random(0, 2) == 1)
      {
        board_cur[i][j] = true;
        board_prev[i][j] = true;
      } else
      {
        board_cur[i][j] = false;
        board_prev[i][j] = false;
      }
    }
  }
}

void original()
{
  clear();
  board_cur[50][50] = true;
  board_cur[50][51] = true;
  board_cur[50][52] = true;
  board_cur[51][50] = true;
  board_cur[49][51] = true;
}

// copy contents of one 2d array into another
void arrCopy(boolean[][] dest, boolean[][] src)
{
  for (int i = 0; i < dest.length; i++)
  {
    for (int j = 0; j < dest[0].length; j++)
    {
      dest[i][j] = src[i][j];
    }
  }
}

void clear()
{
  for (int i = 0; i < board_prev.length; i++)
  {
    for (int j = 0; j < board_prev.length; j++)
    {
      board_prev[i][j] = false;
      board_cur[i][j] = false;
    }
  }
}