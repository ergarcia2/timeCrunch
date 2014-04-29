int universalX;
Schedule sched;

void setup()
{
  size(1000, 500);
  
  universalX = 500;
  sched = new Schedule();
  for (int i = 0; i < 9; i++)
  {
    sched.addTask(75*i + 50);
  }
}

void draw()
{

  background(0);
  sched.update();
}
void mouseClicked()
{
  if ( mouseX>250 && mouseX<750 && mouseY>sched.getTask(0).getY()-25 && mouseY<sched.getTask(0).getY()+25)
  {
      sched.getTask(0).switchCounter();
      sched.getTask(0).activate();
      sched.getTask(0).halt(); 
  }
}

class Task
{
  int ect, timePassed, startTime, y, dd, counter, fill;
  String name;
  Boolean running;
  color c;
  
  public Task(int y1, int duedate, String n, int ect1)
  {
    fill = 0;
    counter = -1;
    ect = ect1;
    timePassed = 0;
    running = false;
    dd = duedate;
    y = y1;
    name = n;
  }
  int getECT()
  {
    int t = (ect/60000);
    return t;
  }
  int getDD()
  {
    return dd;
  }
  boolean getRunning()
  {
    return running;
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
  void setECT(int a)
  {
    a *= 60000;
    ect = a;
  }
  void setY(int a)
  {
    y = a;
  }
  void setRunning(Boolean a)
  {
    running = a;
  }
  void setDD(int a)
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
//  void displayTask()
//  {
//    rectMode(CENTER);
//    fill(#F5F5F5);
//    rect(universalX, y, 500, 50);
//  }
  void activate()
  {
    running = true;
   if(counter == 1)
   {
      startTime = millis();
      startTime = startTime - timePassed;
      timePassed = 0;
      
   }
  }
  void halt()
  {
    if(counter == -1)
    {
      running = false;
     
    }
  }
  void run()
  {
    if (running)
    {
     timePassed = millis() - startTime;
     boolean temp = timePassed<ect;
     print("" + temp +" ");
     if(timePassed < ect)
     {
     fill = (int)(map(timePassed, 0, ect, 0, 500));
     print("hey");
     }
    
     
    }
    noStroke();
    rectMode(CENTER);
    fill(#F5F5F5);
    rect(universalX, y, 500, 50);
    rectMode(CORNER);
    fill(#93b1C6); 
    rect(250, y-25, fill, 50);
  }
  void scroll(int a)
  {
    y += a;
  }
}

class Schedule 
{
  ArrayList<Task> tasks = new ArrayList<Task>();
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
  void addTask(int x1)
  {
    Task t = new Task(x1, 5, "a", 180000);
    tasks.add(t);
  }
  void update()
  {
    for (int i = 0; i<tasks.size(); i++)
    {
      tasks.get(i).run();
    }
    scroll();
//    if (mousePressed == true && mouseX>250 && mouseX<750 && mouseY>tasks.get(0).getY()-25 && mouseY<tasks.get(0).getY()+25)
//  {
//      tasks.get(0).switchCounter();
//      tasks.get(0).activate();
//      tasks.get(0).halt();
//    }
   
  }
  void scroll()
  {
    if (keyPressed == true && key == 'w')
    {
      if (tasks.get(tasks.size()-1).getY() > 400)
      {
        for (Task temp: tasks)
        {
          temp.scroll(-5);
        }
      }
    }
    else if (keyPressed == true && key == 's')
    {
      if (tasks.get(0).getY() < 50)
      {
        for (Task temp: tasks)
        {
          temp.scroll(5);
        }
      }
    }
  }
}



