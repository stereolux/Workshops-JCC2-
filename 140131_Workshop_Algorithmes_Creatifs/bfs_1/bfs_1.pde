import ai.pathfinder.*;

Pathfinder pathfinder;
Stage[][] stages;
Stage bot, target;
int[] mnode;

float PROB_WALKABLE = 0.3;

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
  stages = new Stage[20][20];
  float dx = width/stages.length;
  float dy = height/stages[0].length;
  for (int i = 0; i < stages.length; i++) {
    for (int j = 0; j < stages[0].length; j++) {
      stages[i][j] = new Stage((i+.5)*dx, (j+.5)*dy);
      if (random(1) < PROB_WALKABLE) stages[i][j].walkable = false;
    }
  }
  for (int i = 0; i < stages.length-1; i++) {
    for (int j = 0; j < stages[0].length-1; j++) {
      stages[i][j].connectBoth(stages[i+1][j]);
      stages[i][j].connectBoth(stages[i][j+1]);
    }
  }
  bot = getRandomStage();
  target = bot;
  pathfinder.radialDisconnectUnwalkables();
}

Stage getRandomStage() {
  Stage st = null;
  while (true) {
    int i = floor(random(stages.length));
    int j = floor(random(stages[0].length));
    st = stages[i][j];
    if (st.walkable) break;
  }
  return st;
}

int[] mouseNode() {
  int spacingX = width/stages.length;
  int spacingY = height/stages[0].length;
  int i = mouseX / spacingX;
  int j = mouseY / spacingY;
  return new int[]{i, j};
}

void drawNodes() {
  stroke(10);
  fill(255);
  strokeWeight(1);
  for (int i = 0; i < stages.length; i++) {
    for (int j = 0; j < stages[0].length; j++) {
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
      stroke(255, 55, 55, 10);
      line(next.x, next.y, bot.x, bot.y);
      
      int dx = width/stages.length;
      int dy = height/stages[0].length;
      int i = floor(next.x/dx);
      int j = floor(next.y/dy);
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
  //ellipse(bot.x, bot.y, 3, 3);
}

