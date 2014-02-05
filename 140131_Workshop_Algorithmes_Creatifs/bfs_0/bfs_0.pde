// Demo of bfs algorithm
// This demonstrates how you might guide a bot with the Pathfinder

import ai.pathfinder.*;

Pathfinder bfs;
Node bot = new Node();

int w = 20;
int h = 20;
int spacing;

int mNode = 0;
PFont font;

void setup(){
  size(400, 400);
  frameRate(12);
  spacing = width / w;
  smooth();
  rectMode(CENTER);
  initMap();
  
  drawNodes();
  fill(255, 200);
  rect(width/2, height/2, width, height);
}

void draw(){
//  background(80);
  mNode = mouseNode();
 // drawNodes();
  drawBot();
}

void mousePressed(){
  //initMap();
}

void initMap(){
  bfs = new Pathfinder();
  bfs.offsetX = spacing/2;
  bfs.offsetY = spacing/2;
  bfs.setCuboidNodes(w, h, spacing);
  for(int i = 0; i < 100; i++){
    Node temp = getRandomNode();
    temp.walkable = false;
  }
  bot = getRandomNode();
  bfs.radialDisconnectUnwalkables();
}

Node getRandomNode(){
  Node n = null;
  while(true){
    n = (Node)bfs.nodes.get((int)random(bfs.nodes.size()));
    if(n.walkable) break;
  }
  return n;
}

int mouseNode(){
  int x = mouseX / spacing;
  int y = mouseY / spacing;
  return x + y * w;
}

void drawNodes(){
  stroke(10);
  fill(255);
  strokeWeight(1);
  for(int i = 0; i < bfs.nodes.size(); i++){
    Node temp = (Node)bfs.nodes.get(i);
    if(temp.walkable){
      if(i == mNode){
        fill(155,40,40);
      }else{
        fill(255);
      }
      ellipse(temp.x, temp.y, spacing, spacing);
    }
  }
}

void drawBot(){
  Node target = (Node)bfs.nodes.get(mNode);
  ArrayList path = new ArrayList();
  if(bot != target && target.walkable){
    path = bfs.bfs(bot, target);
    // a path starts at finish and ends at start, so the next move would be one away from the end of the path
    if(path.size() > 1){
      bot = (Node)path.get(path.size()-2);
    }
  }
  noStroke();
  fill(40, 40, 240);
  ellipse(bot.x, bot.y, spacing*.2, spacing*.2);
}

