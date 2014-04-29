import java.util.Arrays;
int universalX;
Schedule sched;
PFont font1, font2, font3;

void setup()
{
  size(900, 550, P2D);
  font1 = createFont("Arial Bold", 35);
  font3 = createFont("Arial Bold", 15);
  font2 = createFont("Arial", 10);
  noStroke();
  smooth();
  frameRate(30);
  universalX = 450;
  sched = new Schedule();
  sched.addTask(150, "0112", "Tester", 10000, #A6B8C4, #619BC4);
  sched.addTask(100 +150, "0112", "Tester1", 50000, #AEC4A6, #7BC461);
  sched.addTask(200 +150, "0112", "Tester1", 10000, #AEC4A6, #7BC461);
  sched.addTask(300 +150, "0114", "Tester1", 40000, #A6B8C4, #619BC4);
  sched.addTask(400 +150, "0113", "Tester1", 60000, #A6B8C4, #619BC4);
  sched.addTask(500 +150, "0112", "Tester1", 70000, #AEC4A6, #7BC461);
  sched.addTask(600 +150, "0112", "Tester1", 20000, #AEC4A6, #7BC461);
  sched.addTask(700 + 150, "9999", "+", 0, #A6B8C4, #619BC4);
}

void draw()
{
  background(#F5F5F5);
  sched.update();
}

void mouseClicked()
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
   print("old: " +  sched.getTaskArray());
    sched.organize();
    println("new: " + sched.getTaskArray());
    print("hey");
  }
}

class Task  implements Comparable
{
  int ect, timePassed, startTime, y, counter, fill, hueOne, hueTwo, countTwo, flashcount, flashcountTwo;
  String name, ectPrint, dd;
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

  int getECT()
  {
    int t = (ect/1000);
    return t;
  }
  String getDD()
  {
    String out = dd.substring(0, 2) + "/" + dd.substring(2);
    return out;
  }
  int getDDM()
  {
    int out;
    if (int(dd.charAt(0)) == 0)
    {
       out = int(dd.charAt(1));
    }
    else
    {
       out = int(dd.substring(0, 2));
    }
    return out;
  }
  int getDDD()
  {
    int out;
    if (int(dd.charAt(2)) == 0)
    {
       out = int(dd.charAt(3));
    }
    else
    {
       out = int(dd.substring(2));
    }
    return out;
  }
  boolean getRunning()
  {
    return running;
  }
  boolean getComplete()
  {
    return complete;
  }
  String getTName()
  {
    return name;
  }
  int getTimePassed()
  {
    int t = (timePassed/60000);
    return t;
  }
  int getCounter()
  {
    return counter;
  }
  int getStartTime()
  {
    return startTime;
  }
  int getY()
  {
    return y;
  }
  void setMoveUp(Boolean a)
  {
    moveUp = a;
  }
  void setECT(int a)
  {
    a *= 60000;
    ect = a;
  }
  void setFlashing(boolean a)
  {
    flashing = a;
  }
  void setY(int a)
  {
    y = a;
  }
  void setRunning(Boolean a)
  {
    running = a;
  }
  void setDD(String a)
  {
    dd = a;
  }
  void setCounter(int a)
  {
    counter = a;
  }
  void setTName(String a)
  {
    name= a;
  }
  void switchCounter()
  {
    counter *= -1;
  }

  void activate()
  {
    running = true;
    if (counter == 1)
    {
      startTime = millis();
      startTime = startTime - timePassed;
      timePassed = 0;
    }
  }
  void halt()
  {
    if (counter == -1)
    {
      running = false;
    }
  }
  
  public int compareTo(Object o)
  {
    Task c = (Task)o;
    int i = 0;
    if (getDDM() < c.getDDM())
    {
      i = -1;
    }
    else if (getDDM() == c.getDDM())
    {
      if (getDDD() < c.getDDD())
      {
        i = -1;
      }
      else if (getDDD() == c.getDDD())
      {
        //print("days_equal ");
        if (getECT() < c.getECT())
        {
          //print(""+getECT()+" "+c.getECT());
          //print("less_than"+(getECT()<c.getECT()));
          i = 1;
        }
        else if (getECT() == c.getECT())
        {
          //print("equal"+(getECT()==c.getECT()));
          i = 0;
        }
        else
        {
          i =-1;
        }
      }
      else
      {
        i = 1;
      }  
    }
     else 
      {
        i = 1;
      }
    return i;
  }
    
    void run()
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
      fill(#7C7C7C); 
      rect(universalX+10, y+10, 500, 80, 10);
      fill(hueOne); 
      rect(universalX, y, 500, 80, 10);
      rectMode(CORNER);
      fill(hueTwo); 
      rect(universalX-250, y-40, fill, 80, 10);
      rectMode(CENTER);
      fill(hueOne); 
      rect(universalX, y, 450, 50, 10);
      rectMode(CORNER);

      if (flashing)
      {
        if ( complete == true && flashcount%2 == 0)
        {
          fill(hueTwo); 
          rect(universalX-250, y-40, fill, 80, 10);
          rectMode(CENTER);
          fill(hueOne); 
          rect(universalX, y, 450, 50, 10);
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
          fill(#FF7148); 
          rect(universalX-250, y-40, fill, 80, 10);
          rectMode(CENTER);
          fill(hueOne); 
          rect(universalX, y, 450, 50, 10);
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
    void moveUp()
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
    void scroll(int a)
    {
      y += a;
    }
    String timeIt()
    {

      String minutes = "";
      String seconds = "";
      String out = "";
      minutes = minutes + (timePassed)/60000;
      seconds = seconds + ((timePassed)%60000)/1000;
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
    void displayText()
    {
      if (getY() == sched.getTask(sched.getTaskArray().size()-1).getY())
      {
        textAlign(CENTER);
        fill(#2e2e2e);
        textFont(font1);
        text(name, universalX, y+10);
      }
      else
      {
        textAlign(CENTER);
        fill(#2e2e2e);
        textFont(font2);
        text("Set Time", universalX-140, y-10);
        text("Time Passed", universalX+140, y-10);

        textFont(font1);
        text(timeIt(), universalX+140, y+20);
        text(ectPrint, universalX-140, y+20);
        textFont(font3);
        text("Due: ", universalX-23, y+20);
        text(name, universalX, y-5);
        text(getDD(), universalX+17, y+20);
      }
    }
  }

  class Schedule 
  {
    ArrayList<Task> tasks = new ArrayList<Task>();
    ArrayList<Task> completed = new ArrayList<Task>();
    public Schedule()
    {
    } 
    Task getTask(int i)
    {
      return tasks.get(i);
    }
    void setTask(int i, Task t)
    {
      tasks.set(i, t);
    }
    ArrayList<Task> getTaskArray()
    {
      return tasks;
    }
    void addTask(int y1, String duedate, String n, int ect1, int hue1, int hue2)
    {
      Task t = new Task(y1, duedate, n, ect1, hue1, hue2);
      tasks.add(t);
    }
    void completeTask()
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
    void organize()
    {
      Object[] ar = tasks.toArray();
      Arrays.sort(ar);
      tasks.clear();
      for (int i = 0; i<ar.length; i++)
      {
        tasks.add((Task)ar[i]);
        tasks.get(i).setY(100*i + 150);
      }
    }
    void update()
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
    String toString()
    {
      String s = "[";
      for (int i = 0; i<tasks.size();i++)
      {
        s= s + " " + tasks.get(i).getY();
      }
      s = s + " ]";
      return s;
    }
    void scroll()
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

