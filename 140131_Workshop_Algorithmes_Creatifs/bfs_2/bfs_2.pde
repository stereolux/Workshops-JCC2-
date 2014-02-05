import ai.pathfinder.*;

Pathfinder pathfinder;
Stage[][] stages;
Stage bot, target;
int[] mnode;

float PROB_WALKABLE = 0.3;
float dx, dy;
int columns, rows;

void setup() {
  size(400, 400);
  smooth();

  initMap();
  background(255);
  drawNodes();
}

void draw() {
  //  background(255);
  //  mnode = mouseNode();
  //  drawNodes();
  drawBot();
}

void initMap() {
  pathfinder = new Pathfinder();

  dx = 10;
  dy = sin(radians(60))*dx;
  columns = floor((float)width/dx);
  rows = floor((float)height/dy);
  stages = new Stage[columns][rows];
  
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      if (j % 2 == 0) stages[i][j] = new Stage(i*dx*3, j*dy);
      else stages[i][j] = new Stage(i*dx*3+dx+dy/2, j*dy);
      if (random(1) < PROB_WALKABLE) stages[i][j].walkable = false;
    }
  }
  
  for (int i = 0; i < columns; i++) {
    stages[i][1].connectBoth(stages[i][0]);
    for (int j = 1; j < rows; j++) {
      if (i == 0) {
        stages[i][j].connectBoth(stages[i][j-1]);
        if (j > 1) stages[i][j].connectBoth(stages[i][j-2]);
      }
      else {
        stages[i][j].connectBoth(stages[i][j-1]);
        if (j > 1) stages[i][j].connectBoth(stages[i][j-2]);
        if (j%2 == 1)stages[i][j-1].connectBoth(stages[i-1][j]);
        else stages[i-1][j-1].connectBoth(stages[i][j]);
      }
    }
  }
  bot = getRandomStage();
  target = bot;
  pathfinder.radialDisconnectUnwalkables();
}

Stage getRandomStage() {
  Stage st = null;
  while (true) {
    int i = floor(random(columns));
    int j = floor(random(rows));
    st = stages[i][j];
    if (st.walkable) break;
  }
  return st;
}

int[] mouseNode() {
  int spacingX = width/columns;
  int spacingY = height/rows;
  int i = mouseX / spacingX;
  int j = mouseY / spacingY;
  return new int[] {
    i, j
  };
}

void drawNodes() {
  stroke(10);
  fill(255);
  strokeWeight(1);
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      stages[i][j].draw();
    }
  }
}

void drawBot() {
  //stages[mnode[0]][mnode[1]];
  ArrayList path = new ArrayList();
  if (bot != target && target.walkable) {
    path = pathfinder.bfs(bot, target);
    // a path starts at finish and ends at start, so the next move would be one away from the end of the path
    if (path.size() > 1) {
      Node next = (Node)path.get(path.size()-2);
      stroke(255, 55, 55, 50);
      line(next.x, next.y, bot.x, bot.y);

      int i = 0, j = 0;
      for (int n = 0; n < columns; n++) {
        for (int m = 0; m < rows; m++) {
          if (stages[n][m].x == next.x && stages[n][m].y == next.y) {
            i = n;
            j = m;
          }
        }
      }
      stages[i][j].counter++;
      bot = stages[i][j];
    }
    else {
      bot = target;
    }
  }
  else {
    target = getRandomStage();
  }

  noStroke();
  fill(240, 40, 40);
//  ellipse(bot.x, bot.y, 3, 3);
}

