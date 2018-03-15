class Level
{
  Level() 
  {
    lcheck();
  }

  void backgrounds() // any background images
  {
    if (levels == 1)
    {
      background(0);
      fill(255);
      text(score, 10, 10);
      text((millis() - time)/1000, 100, 10);
    }
    if (levels == 2)
    {
      background(0);
      fill(255);
      text(score, 10, 10);
    }
    if (levels == 3)
    {
      background(0);
      fill(255);
      text(score, 10, 10);
    }
    if (levels == 0)
    {
      menu();
    }
    if (levels == 4)
    {
      finalScore();
    }
  }

  void menu()// press r to get to level 1
  {
    cheats = true;
    background(0);
    
  }

  void levelOne()// example world
  {
    cheats = false;
    time = millis(); // resets time
    tlimit = 15; // time limit in secounds
    maxpoints = 1; // maxpoints need to progress
    level[28][38] = 1;
    points[28][39] = 1;
    collapse[29][35] = 1;
    spike[29][12] = 1;
  }

  void levelTwo()
  {
    cheats = false;
  }

  void levelThree()
  {
    cheats = false;
  }

  void finalScore()// press r on final to go back to menu
  {
    cheats = true;
    background(0);
    textSize(32);
    text(scores[0], width/2, 50); // highscore
    textSize(20);
    for (int i = 1; i < scores.length; i++) // all attempts
    {
      text(scores[i], width/2, 100 + i * 50);
    }
  }

  void update()
  {
    fill(255);
    noStroke();
    for ( int ix = 0; ix < WIDTH; ix++ )
    {
      for ( int iy = 0; iy < HEIGHT; iy++ )
      {
        if (level[iy][ix] == 1) 
        {
          fill(255);
          rect(ix*16, iy*16, 16, 16);
        }
        if (points[iy][ix] == 1) 
        {
          fill(255, 255, 0);
          rect(ix*16+4, iy*16+4, 8, 8);
        }
        if (collapse[iy][ix] == 1) 
        {
          fill(100);
          rect(ix*16, iy*16, 16, 16);
        }
        if (spike[iy][ix] == 1) 
        {
          fill(255, 0, 0);
          rect(ix*16, iy*16, 16, 16);
        }
      }
    }
  }

  boolean placeFree(int xx, int yy) 
  {
    //checks if location is free
    yy = int(floor(yy/16.0));
    xx = int(floor(xx/16.0));

    boolean answer = false;

    if ( xx > -1 && xx < level[0].length && yy > -1 
      && yy < level.length ) 
    {
      if ( level[yy][xx] == 0 ) 
      {
        answer = true;
      }
      if ( points[yy][xx] == 1 ) 
      {
        answer = true;
        points[yy][xx] = 0;
        score = score + 5;
        collected = collected+ 1;
        if ( collected >= maxpoints)
        {
          ldone = true;
          lreset();
          levels = levels + 1;
          lcheck();
        }
      }
      if ( collapse[yy][xx] == 1 ) 
      {
        collapse[yy][xx] = 0;
      }
      if ( spike[yy][xx] == 1 ) 
      {
        p1.death();
      }
    }

    return answer;
  }

  void cheats(boolean enabled)
  {
    if (enabled)
    {
      if (level[int(mouseY/16.0)][int(mouseX/16.0)] == 0)
      {
        level[int(mouseY/16.0)][int(mouseX/16.0)] = 1;
      } else 
      {
        level[int(mouseY/16.0)][int(mouseX/16.0)] = 0;
      }
    }
  }

  void lreset()
  {
    for ( int ix = 0; ix < WIDTH; ix++ )
    {
      for ( int iy = 0; iy < HEIGHT; iy++ )
      {
        if (level[iy][ix] == 1) 
        {
          level[iy][ix] = 0;
        }
        if (points[iy][ix] == 1) 
        {
          points[iy][ix] = 0;
        }
        if (collapse[iy][ix] == 1) 
        {
          collapse[iy][ix] = 0;
        }
        if (spike[iy][ix] == 1) 
        {
          spike[iy][ix] = 0;
        }
      }
    }
  }

  void lcheck() // checks level and resets collected
  { 
    collected = 0;

    if (levels == 1)
    {
      levelOne();
    } 
    if (levels == 2)
    {
      levelTwo();
    } 
    if (levels == 3)
    {
      levelThree();
    } 
    if (levels == 0)
    {
      menu();
    } 
    if (levels == 4)
    {
      finalScore();
    }
    ldone = false;
  }

  // to use but time = millis at start of level and set tlimit
  void timer()
  {
    if ((millis() - time)/1000 <= tlimit && ldone)
    {
      score= score + 100;
      time = millis();
    }
  }
}

