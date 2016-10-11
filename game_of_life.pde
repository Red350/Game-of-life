void setup()
{
  size(800, 800);
  cellWidth = width / (float)colCount;
  cellHeight = height / (float)rowCount;
  stroke(255);
  strokeWeight(0.1);
  frameRate(5);
  // test for out of bounds
  //toggle(0, 0);
  //toggle(-1, 0);
  //toggle(0, -1);
  //toggle(99, 99);
  //toggle(100, 99);
  //toggle(99, 100);

  randomise();  // initialise board1
  //board_cur[50][50] = true;
  //board_cur[50][51] = true;
  //board_cur[50][52] = true;
  //board_cur[51][50] = true;
  //board_cur[49][51] = true;
  
  // copy into board2
  arrCopy(board_prev, board_cur);
  //for (int i = 0; i < board1.length; i++)
  //{
  //  board2[i] = board1[i].clone();
  //}
  
}

float cellWidth;
float cellHeight;

int rowCount = 100;
int colCount = 100;
boolean[][] board_cur = new boolean[rowCount][colCount];
boolean[][] board_prev = new boolean[rowCount][colCount];

void draw()
{
  // update the board
  for (int i = 0; i < rowCount; i++)
  {
    for (int j = 0; j < colCount; j++)
    {
      int numAlive = countLiveCells(i,j);
      // if cell is alive
      if (getCell(i,j))
      {
        if (numAlive < 2 || numAlive > 3)
        {
          setCell(i,j,false);
        }
      }
      else
      {
        if (numAlive == 3)
        {
          setCell(i,j,true);
        }
      }
    }
  }
  
  // update the previous version to be the same as the current
  arrCopy(board_prev, board_cur);
  // draw the board
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

  // flip the board pointers
  boolean[][] temp;
  temp = board_cur;
  board_cur = board_prev;
  board_prev = temp;
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
      } else
      {
        board_cur[i][j] = false;
      }
    }
  }
}

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