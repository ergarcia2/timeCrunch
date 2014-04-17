import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ticktock extends PApplet {

int universalX;
Schedule sched;
PFont font1, font2, font3;

public void setup()
{
  size(900, 550, P2D);
  font1 = createFont("Arial Bold", 35);
  font3 = createFont("Arial Bold", 15);
  font2 = createFont("Arial", 10);
  noStroke();
  smooth();
  frameRate(30);
  universalX = 600;
  sched = new Schedule();
  
  sched.addTask(150, "0112", "Tester", 10000, 0xffA6B8C4, 0xff619BC4);
  sched.addTask(100 +150, "0112", "Tester1", 10000, 0xffAEC4A6, 0xff7BC461);
  sched.addTask(200 +150, "0112", "Tester1", 300, 0xffAEC4A6, 0xff7BC461);
  sched.addTask(300 +150, "0112", "Tester1", 300, 0xffA6B8C4, 0xff619BC4);
  sched.addTask(400 +150, "0112", "Tester1", 300, 0xffA6B8C4, 0xff619BC4);
  sched.addTask(500 +150, "0112", "Tester1", 300, 0xffAEC4A6, 0xff7BC461);
  sched.addTask(600 +150, "0112", "Tester1", 300, 0xffAEC4A6, 0xff7BC461);
  sched.addTask(700 + 150, "0112", "+", 10000, 0xffA6B8C4, 0xff619BC4);
}

public void draw()
{
  background(0);
  sched.update();
}

public void mouseClicked()
{

  if ( mouseX>universalX-250 && mouseX<universalX+250 && mouseY>sched.getTask(0).getY()-37 
    && mouseY<sched.getTask(0).getY()+37 && sched.getTaskArray().size() > 1)
  {

    if (sched.getTask(0).getComplete() == false)
    {
      sched.getTask(0).switchCounter();
      sched.getTask(0).activate();
      sched.getTask(0).halt();
    }
    else
    {
      sched.getTask(0).setFlashing(false);
      sched.completeTask();
    }
  }
  else if ( mouseX>universalX-250 && mouseX<universalX+250 && mouseY>sched.getTask(0).getY()-37 
    && mouseY<sched.getTask(sched.getTaskArray().size()-1).getY()+37)
  {
    //add a new task
  }
}

class Task  
{
  int ect, timePassed, startTime, y, counter, fill, hueOne, hueTwo, countTwo, flashcount, flashcountTwo;
  String name, ectPrint,  dd;
  Boolean running, moveUp, complete, flashing;
  PShape s;
  public Task(int y1, String duedate, String n, int ect1, int hue1, int hue2)
  {
    dd =  duedate;
    countTwo = 1;
    fill = 0;
    moveUp = false;
    counter = -1;
    ect = ect1;
    timePassed = 0;
    running = false;
    complete = false;
    flashing = false;
    y = y1;
    name = n;
    hueOne = hue1;
    hueTwo = hue2;
    flashcount = 1;
    flashcountTwo = 0;
    //instanciate ectPrint
    String minutes = "";
    String seconds = "";
    ectPrint = "";
    minutes = minutes + (ect)/60000;
    seconds = seconds + ((ect)%60000)/1000;
    if (minutes.length() == 1)
    {
      minutes = 0 + minutes;
    }
    if (seconds.length() == 1)
    {
      seconds = 0 + seconds;
    }
    ectPrint = ectPrint + minutes + " : " + seconds;
  }

  public int getECT()
  {
    int t = (ect/60000);
    return t;
  }
  public String getDD()
  {
    String out = dd.substring(0,2) + " / " + dd.substring(2);
    return out;
  }
  public boolean getRunning()
  {
    return running;
  }
  public boolean getComplete()
  {
    return complete;
  }
  public String getTName()
  {
    return name;
  }
  public int getTimePassed()
  {
    int t = (timePassed/60000);
    return t;
  }
  public int getCounter()
  {
    return counter;
  }
  public int getStartTime()
  {
    return startTime;
  }
  public int getY()
  {
    return y;
  }
  public void setMoveUp(Boolean a)
  {
    moveUp = a;
  }
  public void setECT(int a)
  {
    a *= 60000;
    ect = a;
  }
  public void setFlashing(boolean a)
  {
    flashing = a;
  }
  public void setY(int a)
  {
    y = a;
  }
  public void setRunning(Boolean a)
  {
    running = a;
  }
  public void setDD(String a)
  {
    dd = a;
  }
  public void setCounter(int a)
  {
    counter = a;
  }
  public void setTName(String a)
  {
    name= a;
  }
  public void switchCounter()
  {
    counter *= -1;
  }

  public void activate()
  {
    running = true;
    if (counter == 1)
    {
      startTime = millis();
      startTime = startTime - timePassed;
      timePassed = 0;
    }
  }
  public void halt()
  {
    if (counter == -1)
    {
      running = false;
    }
  }
  public void run()
  {
    if (running ||  flashing)
    {
      timePassed = millis() - startTime;
    }
    if (running)
    {
      if (timePassed < ect  )
      {
        fill = (int)(map(timePassed, 0, ect, 0, 500));
      }
      else {
        fill = 500;
        running = false; 
        complete = true;
        flashing = true;
        flashcountTwo++;
      }
    }
    rectMode(CENTER);
    fill(0xff7C7C7C); 
    rect(universalX+10, y+10, 500, 80);
    fill(hueOne); 
    rect(universalX, y, 500, 80);
    rectMode(CORNER);
    fill(hueTwo); 
    rect(universalX-250, y-40, fill, 80);
    rectMode(CENTER);
    fill(hueOne); 
    rect(universalX, y, 450, 60, 10);
    rectMode(CORNER);

    if (flashing)
    {
      if ( complete == true && flashcount%2 == 0)
      {
        fill(hueTwo); 
        rect(universalX-250, y-40, fill, 80);
        rectMode(CENTER);
        fill(hueOne); 
        rect(universalX, y, 450, 60, 10);
        rectMode(CORNER);
        if (flashcount == 40)
        {
          flashcount = 1;
        }
        else
        {
          flashcount += 2;
        }
      }
      else 
      {
        fill(0xffFF7148); 
        rect(universalX-250, y-40, fill, 80);
        rectMode(CENTER);
        fill(hueOne); 
        rect(universalX, y, 450, 60, 10);
        rectMode(CORNER);
        if (flashcount == 39)
        {
          flashcount = 0;
        }
        else
        {
          flashcount += 2;
        }
      }
    }
    displayText();
  }
  public void moveUp()
  {
    if (moveUp && countTwo < 25)
    {
      scroll(-4); 
      countTwo++;
    }
    else
    {
      moveUp = false; 
      countTwo = 0;
    }
  }
  public void scroll(int a)
  {
    y += a;
  }
  public String timeIt()
  {

    String minutes = "";
    String seconds = "";
    String out = "";
    minutes = minutes + ( timePassed)/60000;
    seconds = seconds + (( timePassed)%60000)/1000;
    if (minutes.length() == 1)
    {
      minutes = 0 + minutes;
    }
    if (seconds.length() == 1)
    {
      seconds = 0 + seconds;
    }

    out = out + minutes + " : " + seconds;
    return out;
  }
  public void displayText()
  {
    textAlign(CENTER);
    fill(0xff2e2e2e);
    textFont(font2);
    text("Set Time", universalX-140, y-10);
    text("Time Passed", universalX+140, y-10);
    text("Due On", universalX, y+10);
    textFont(font1);
    text(timeIt(), universalX+140, y+25);
    text(ectPrint, universalX-140, y+25);
    textFont(font3);
    text(name, universalX, y-15);
    text(getDD(), universalX, y + 25);
  }
}

class Schedule 
{
  ArrayList<Task> tasks = new ArrayList<Task>();
  ArrayList<Task> completed = new ArrayList<Task>();
  public Schedule()
  {
  } 
  public Task getTask(int i)
  {
    return tasks.get(i);
  }
  public void setTask(int i, Task t)
  {
    tasks.set(i, t);
  }
  public ArrayList<Task> getTaskArray()
  {
    return tasks;
  }
  public void addTask(int y1, String duedate, String n, int ect1, int hue1, int hue2)
  {
    Task t = new Task(y1, duedate, n, ect1, hue1, hue2);
    tasks.add(t);
  }
  public void completeTask()
  {
    Task temp = tasks.get(0);
    tasks.remove(0);
    if (completed.size() == 0)
    {
      temp.setY(200 +(tasks.get(tasks.size()-1).getY()));
    }
    else
    {
      temp.setY(100 +(completed.get(completed.size()-1).getY()));
    }
    completed.add(temp);
    for (int i = 0; i<tasks.size(); i++)
    {
      tasks.get(i).setMoveUp(true);
    }
    for (int i = 0; i<completed.size(); i++)
    {
      completed.get(i).setMoveUp(true);
    }
  }
  public void update()
  {
    for (int i = 0; i<tasks.size(); i++)
    {
      tasks.get(i).run();
      tasks.get(i).moveUp();
    } 

    for (int i = 0; i<completed.size(); i++)
    {
      completed.get(i).run();
      completed.get(i).moveUp();
    } 
    scroll();
  }
  public String toString()
  {
    String s = "[";
    for (int i = 0; i<tasks.size();i++)
    {
      s= s + " " + tasks.get(i).getY();
    }
    s = s + " ]";
    return s;
  }
  public void scroll()
  {
    if (keyPressed == true && key == 'w')
    {
      if (completed.size() == 0)
      {
        if (tasks.get(tasks.size()-1).getY() > 400)
        {
          for (Task temp: tasks)
          {
            temp.scroll(-10);
          }
        }
      }
      else
      {
        if (completed.get(completed.size()-1).getY() > 400)
        {
          for (Task temp: completed)
          {
            temp.scroll(-10);
          }
          for (Task temp: tasks)
          {
            temp.scroll(-10);
          }
        }
      }
    }
    else if (keyPressed == true && key == 's')
    {

      if (tasks.get(0).getY() < 150)
      {
        for (Task temp: tasks)
        {
          temp.scroll(10);
        }
        for (Task temp: completed)
        {
          temp.scroll(10);
        }
      }
    }
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "ticktock" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
