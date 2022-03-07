import de.bezier.guido.*;

//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private static final int NUM_ROWS = 20;
private static final int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r, c);
      }
    }
    
    //code to intialize mines
    mines = new ArrayList <MSButton> ();
    for(int i = 0; i < 35; i++){
      setMines();
    }
}


public void setMines()
{
    //your code
    int ranRow = (int)(Math.random() * NUM_ROWS);
    int ranCol = (int)(Math.random() * NUM_COLS);
      
    if(mines.contains(buttons[ranRow][ranCol]) == false)
      mines.add(buttons[ranRow][ranCol]);    
}


public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}


public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].clicked == false && !mines.contains(buttons[r][c]))
          return false;
      }
    }
    
    return true;
}


public void displayLosingMessage()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].clicked == false && mines.contains(buttons[r][c])){
          buttons[r][c].clicked = true;
        }
      }
    }
    
    for(int i = 0; i < 20; i++)
      buttons[8][i].setLabel(" ");
          
    buttons[9][0].setLabel(" ");
    buttons[9][1].setLabel(" ");
    buttons[9][2].setLabel(" ");
    buttons[9][3].setLabel(" ");
    buttons[9][4].setLabel("B");
    buttons[9][5].setLabel("E");
    buttons[9][6].setLabel("T");
    buttons[9][7].setLabel("T");
    buttons[9][8].setLabel("E");
    buttons[9][9].setLabel("R");
    buttons[9][10].setLabel(" ");
    buttons[9][11].setLabel("L");
    buttons[9][12].setLabel("U");
    buttons[9][13].setLabel("C");
    buttons[9][14].setLabel("K");
    buttons[9][15].setLabel(" ");
    buttons[9][16].setLabel(" ");
    buttons[9][17].setLabel(" ");
    buttons[9][18].setLabel(" ");
    buttons[9][19].setLabel(" ");
    buttons[10][0].setLabel(" ");
    buttons[10][1].setLabel(" ");
    buttons[10][2].setLabel(" ");
    buttons[10][3].setLabel(" ");
    buttons[10][4].setLabel(" ");
    buttons[10][5].setLabel(" ");
    buttons[10][6].setLabel("N");
    buttons[10][7].setLabel("E");
    buttons[10][8].setLabel("X");
    buttons[10][9].setLabel("T");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("T");
    buttons[10][12].setLabel("I");
    buttons[10][13].setLabel("M");
    buttons[10][14].setLabel("E");
    buttons[10][15].setLabel("!");
    buttons[10][16].setLabel(" ");
    buttons[10][17].setLabel(" ");
    buttons[10][18].setLabel(" ");
    buttons[10][19].setLabel(" ");
          
    for(int i = 0; i < 20; i++)
      buttons[11][i].setLabel(" ");
}


public void displayWinningMessage()
{
    //your code here
    for(int i = 0; i < 20; i++)
      buttons[8][i].setLabel(" ");
    
    buttons[9][0].setLabel(" ");
    buttons[9][1].setLabel(" ");
    buttons[9][2].setLabel("C");
    buttons[9][3].setLabel("O");
    buttons[9][4].setLabel("N");
    buttons[9][5].setLabel("G");
    buttons[9][6].setLabel("R");
    buttons[9][7].setLabel("A");
    buttons[9][8].setLabel("T");
    buttons[9][9].setLabel("U");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("A");
    buttons[9][12].setLabel("T");
    buttons[9][13].setLabel("I");
    buttons[9][14].setLabel("O");
    buttons[9][15].setLabel("N");
    buttons[9][16].setLabel("S");
    buttons[9][17].setLabel("!");
    buttons[9][18].setLabel(" ");
    buttons[9][19].setLabel(" ");
    
    for(int i = 0; i < 20; i++)
      buttons[10][i].setLabel(" ");
}


public boolean isValid(int r, int c)
{
    //your code here
    if(r < NUM_ROWS && c < NUM_COLS){
      if(r >= 0 && c >= 0)
      return true;
    }
    
    return false;
}


public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for(int r = row - 1; r <= row + 1; r++){
      for(int c = col - 1; c <= col + 1; c++){
        if(isValid(r, c) == true){
          if(mines.contains(buttons[r][c]) == true)
            numMines++;
        }
      }
    }
    
    if(mines.contains(buttons[row][col]) == true)
      numMines--;
    
    return numMines;
}


public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol * width;
        y = myRow * height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add(this); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          flagged = !flagged;
            
          if(flagged == false)
            clicked = false;
        }
        
        else if(mines.contains(this))
          displayLosingMessage();
          
        else if(countMines(myRow, myCol) > 0)
          setLabel(countMines(myRow, myCol));
          
        else{
          for(int i = -1; i < 2; i++){
            if(isValid(myRow + i, myCol - 1) == true && buttons[myRow + i][myCol - 1].clicked == false)
              buttons[myRow + i][myCol - 1].mousePressed();
          }
          
          if(isValid(myRow - 1, myCol) == true && buttons[myRow - 1][myCol].clicked == false)
              buttons[myRow - 1][myCol].mousePressed();
              
          if(isValid(myRow + 1, myCol) == true && buttons[myRow + 1][myCol].clicked == false)
              buttons[myRow + 1][myCol].mousePressed();
          
          for(int i = -1; i < 2; i++){
            if(isValid(myRow + i, myCol + 1) == true && buttons[myRow + i][myCol + 1].clicked == false)
              buttons[myRow + i][myCol + 1].mousePressed();
          }
        }
          
    }
    
    public void draw () 
    {    
        if (flagged)
            fill(255, 204, 255);
          
        else if(clicked && mines.contains(this)){
            fill(255, 153, 204);
        }
         
        else if(clicked)
            fill(229, 204, 255);
           
        else 
            fill(204, 153, 255);

        rect(x, y, width, height);
        fill(0);
        text(myLabel, (x + (width / 2)), (y + (height / 2)));
    }
    
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    
    public void setLabel(int newLabel)
    {
        myLabel = "" + newLabel;
    }
    
    public boolean isFlagged()
    {
        return flagged;
    }
}
