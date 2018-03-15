class Player 
{
  float xSpeed = 0;
  float ySpeed = 0;
  float accel = 0.5;
  float deccel = 0.5;
  float maxXspd = 2;
  float maxYspd = 12;
  float xSave = 0;
  float ySave = 0;
  float gravity = 0.25;

  int x, y;
  int xRep = 0;
  int yRep = 0;
  int signX;
  int signY;
  int offsetX;
  int offsetY;

  Player(int tempX, int tempY) 
  {
    x = tempX;
    y = tempY;
  }

  void update() 
  {
    if ( right ) 
    {
      xSpeed += accel;
      if ( xSpeed > maxXspd ) 
      {
        xSpeed = maxXspd;
      }
    } else if ( left ) {
      xSpeed -= accel;
      if ( xSpeed < -maxXspd ) 
      {
        xSpeed = -maxXspd;
      }
    } else 
    { //neither right or left pressed, decelerate
      if ( xSpeed > 0 ) 
      {
        xSpeed -= deccel;
        if ( xSpeed < 0 )
        {
          xSpeed = 0;
        }
      } else if ( xSpeed < 0 ) 
      {
        xSpeed += deccel;
        if ( xSpeed > 0 )
        {
          xSpeed = 0;
        }
      }
    }

    if ( up ) 
    {
      if ( !world.placeFree(x, y+16) || !world.placeFree(x+15, y+16) )
      {
        ySpeed = -5.3;
      }
    }

    ySpeed += gravity;
    xRep = 0;
    yRep = 0;
    xRep += floor(abs(xSpeed));
    yRep += floor(abs(ySpeed));
    xSave += abs(xSpeed)-int(abs(xSpeed));
    ySave += abs(ySpeed)-int(abs(ySpeed));

    if (xSpeed<0)
    { 
      signX = -1;
      offsetX = 0;
    } else 
    {
      signX = 1;
      offsetX = 15;
    }
    if (ySpeed<0)
    { 
      signY = -1;
      offsetY =0;
    } else 
    {
      signY = 1;
      offsetY = 15;
    }
    if ( xSave >= 1 ) 
    {
      xSave -= 1;
      xRep++;
    }
    if ( ySave >= 1 ) 
    {
      ySave -= 1;
      yRep++;
    }

    for (; yRep > 0; yRep-- ) 
    {
      if ( world.placeFree(x, y+offsetY+signY) && 
        world.placeFree(x+15, y+offsetY+signY) ) 
      {
        y += signY;
      } else {
        ySpeed = 0;
      }
    }
    for (; xRep > 0; xRep-- ) 
    {
      if ( world.placeFree(x+offsetX+signX, y) && 
        world.placeFree(x+offsetX+signX, y+15)) 
      {
        x += signX;
      } else
      {
        xSpeed = 0;
      }
    }
  }
  void show() 
  {
    pushMatrix();
    fill(155, 0, 255);
    noStroke();
    rect(x, y, 16, 16);
    popMatrix();
  }

  void death()
  {
    x = startX*16;
    y = startY*16;
    for (int i = 1; i < scores.length; i++)
    {
      if (scores[i] == 0)
      {
        scores[i] = score;
        if ( scores.length < 10)
        {
          scores = expand(scores, scores.length + 1);
        }
        i = scores.length;
      }
    }
    for ( int i = 1; i < scores.length; i++)
    {
      if (scores[i] > scores[0])
      {
        scores[0] = scores[i];
      }
    }
    world.lreset();
    collected = 0;
    time = millis();
    score = 0;

    if (levels <= 3 && levels >= 1)
    {
      world.lcheck(); 
    }
    if (levels == 0)
    {
      levels = 1;
      world.lcheck();
    } 
    if (levels == 4)
    {
      levels = 0;
      world.lcheck();
    }
  }
}

