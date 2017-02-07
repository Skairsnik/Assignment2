//Sub-class for the Player blocks
class Player extends Block
{
    int playerNo;
    int pScore;
    String pName;
    
    //Player Constructor
    Player(int play)
    {
        this.playerNo = play;
        this.pScore = 0;
        if(play == 1)
        {
            this.positionX = width*(.5);
            this.positionY = height*(.95);
        }//end if
        else
        {
            this.positionX = width*(.5);
            this.positionY = height*(.1);
        }//end else
        
        this.blockWidth = width*(.1);
        this.blockHeight = height*(.02);
        this.blockCol = color(255);
        this.pName = null;
    }//end Player
    
    String toString()
    {
        return playerNo + "\t" + pScore + "\t" + pName + "\t" + positionX + "\t" + positionY + "\t" + blockWidth + "\t" + blockHeight + "\t" + blockCol;
    }//end toString()
    
    //Updates the position of the player
    void updatePlayer()
    {
        if((checkKey(LEFT) && playerNo == 1) || (checkKey('A') && playerNo == 2))
        {
            if((positionX-blockWidth*(.5)) > width*(.05))
            {
                positionX = positionX-width*(.005);
            }//end if
        }//end if
        if((checkKey(RIGHT) && playerNo == 1) || (checkKey('D') && playerNo == 2) )
        {
            if((positionX+blockWidth*(.5)) < width*(.95))
            {
                positionX = positionX+width*(.005);
            }//end if
        }//end if
    }//end updatePlayer()
    
    //Controls the computer Player in 1 player Pong
    void updatePlayerAI()
    {
        if(objBall.size() > 0)
        {
            if(objBall.get(0).curPlayer == playerNo && !start)
            {
                start = true;
            }//end if
            
            float dist = height;
            /*if(playerNo == 1)
            {
                dist = height;
            }//end if
            else
            {
                dist = height;
            }//end else*/
            
            int closest = 0;
            
            /*if(objBall.size() == 1)
            {
                if(dist(objBall.get(0).ballPos.x, objBall.get(0).ballPos.y, positionX, positionY) < dist
                && objBall.get(0).theta > HALF_PI && objBall.get(0).theta < HALF_PI*3 && positionY > height*(.5))
                {
                    dist = dist(objBall.get(0).ballPos.x, objBall.get(0).ballPos.y, positionX, positionY);
                    closest = 1;
                }//end if;
                else if(dist(objBall.get(0).ballPos.x, objBall.get(0).ballPos.y, positionX, positionY) < dist
                && (objBall.get(0).theta < HALF_PI || objBall.get(0).theta > HALF_PI*3) && positionY < height*(.5))
                {
                    dist = dist(objBall.get(0).ballPos.x, objBall.get(0).ballPos.y, positionX, positionY);
                    closest = 1;
                }//end if;
                //closest = 1;
            }//end if
            else*/
            {
                for(int i=0; i<objBall.size(); i++)
                {
                    if(dist(objBall.get(i).ballPos.x, objBall.get(i).ballPos.y, positionX, positionY) < dist
                    && objBall.get(i).theta > HALF_PI && objBall.get(i).theta < HALF_PI*3 && positionY > height*(.5))
                    {
                        dist = dist(objBall.get(i).ballPos.x, objBall.get(i).ballPos.y, positionX, positionY);
                        closest = i+1;
                    }//end if;
                    else if(dist(objBall.get(i).ballPos.x, objBall.get(i).ballPos.y, positionX, positionY) < dist
                    && (objBall.get(i).theta < HALF_PI || objBall.get(i).theta > HALF_PI*3) && positionY < height*(.5))
                    {
                        dist = dist(objBall.get(i).ballPos.x, objBall.get(i).ballPos.y, positionX, positionY);
                        closest = i+1;
                    }//end if;
                }//end for
            }//end else
            
            if(closest == 0)
            {
                if(positionX < width*(.5))
                {
                    positionX = positionX+width*(.002);
                }//end if
                else if(positionX > width*(.5))
                {
                    positionX = positionX-width*(.002);
                }//end else if
            }//end if
            else
            {
                if(positionX-blockWidth*(.25) > objBall.get(closest-1).ballPos.x)
                {
                    if((positionX-blockWidth*(.5)) > width*(.05))
                    {
                        positionX = positionX-width*(.005);
                    }//end if
                }//end if
                if(positionX+blockWidth*(.25) < objBall.get(closest-1).ballPos.x)
                {
                    if((positionX+blockWidth*(.5)) < width*(.95))
                    {
                        positionX = positionX+width*(.005);
                    }//end if
                }//end if
            }//end else 
        }//end if
    }//end updatePlayerAI()
    
    //Checks if the ball is hitting the player
    void checkPlayer(int x)
    {
        if(objBall.get(x).ballPos.x+objBall.get(x).ballDiam*(.5) > positionX-blockWidth*(.5)  && objBall.get(x).ballPos.x-objBall.get(x).ballDiam*(.5) < positionX+blockWidth*(.5)
        && objBall.get(x).ballPos.y+objBall.get(x).ballDiam*(.5) > positionY-blockHeight*(.5) && objBall.get(x).ballPos.y-objBall.get(x).ballDiam*(.5) < positionY+blockHeight*(.5)
        && playerNo == 1)
        {
            if(objBall.get(0).theta == 0)
            {
                objBall.get(0).theta = random(PI-HALF_PI/2, PI+HALF_PI/2);
            }//end if
            else if(objBall.get(0).theta == TWO_PI)
            {
                objBall.get(0).theta = random(TWO_PI-HALF_PI/2, TWO_PI+HALF_PI/2)%TWO_PI;
            }//end if
            else if(objBall.get(x).ballPos.x <= positionX)
            {
                float temp = map(objBall.get(x).ballPos.x, positionX-blockWidth*(.65), positionX, HALF_PI+PI+(HALF_PI/4), TWO_PI);
                objBall.get(x).theta = temp;
                objBall.get(x).ballPos.y = (positionY-blockHeight*(.5))-objBall.get(x).ballDiam*(.5)-1;
            }//end else if
            else if(objBall.get(x).ballPos.x > positionX)
            {
                float temp = map(objBall.get(x).ballPos.x, positionX, positionX+blockWidth*(.65), 0, HALF_PI-(HALF_PI/4));
                objBall.get(x).theta = temp;
                objBall.get(x).ballPos.y = (positionY-blockHeight*(.5))-objBall.get(x).ballDiam*(.5)-1;
            }//end else if
            
            objBall.get(x).scoreMultiplier = 1;
        }//end if
        else if(objBall.get(x).ballPos.x+objBall.get(x).ballDiam*(.5) > positionX-blockWidth*(.5)  && objBall.get(x).ballPos.x-objBall.get(x).ballDiam*(.5) < positionX+blockWidth*(.5)
        && objBall.get(x).ballPos.y+objBall.get(x).ballDiam*(.5) > positionY-blockHeight*(.5) && objBall.get(x).ballPos.y-objBall.get(x).ballDiam*(.5) < positionY+blockHeight*(.5)
        && playerNo == 2)
        {
            if(objBall.get(0).theta == 0)
            {
                objBall.get(0).theta = random(PI-HALF_PI/2, PI+HALF_PI/2);
            }//end if
            else if(objBall.get(0).theta == TWO_PI)
            {
                objBall.get(0).theta = random(TWO_PI-HALF_PI/2, TWO_PI+HALF_PI/2)%TWO_PI;
            }//end if
            else if(objBall.get(x).ballPos.x <= positionX)
            {
                float temp = map(objBall.get(x).ballPos.x, positionX+blockWidth*(.65), positionX, HALF_PI+(HALF_PI/4), PI);
                objBall.get(x).theta = temp;
                objBall.get(x).ballPos.y = (positionY+blockHeight*(.5))+objBall.get(x).ballDiam*(.5)+1;
            }//end if
            else if(objBall.get(x).ballPos.x > positionX)
            {
                float temp = map(objBall.get(x).ballPos.x, positionX, positionX-blockWidth*(.65), PI, HALF_PI+PI-(HALF_PI/4));
                objBall.get(x).theta = temp;
                objBall.get(x).ballPos.y = (positionY+blockHeight*(.5))+objBall.get(x).ballDiam*(.5)+1;
            }//end else if
        }//end if
    }//end checkPlayer()
}//end Player