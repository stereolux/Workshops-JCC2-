// Customize the look of your word item here

class WordItem extends SimpleMapItem
{
  String word;

  WordItem(String w)
  {
    this.word = w;
  }

  void draw()
  {
    fill(sqrt(w*h));
    stroke(120);
    strokeWeight(1);
    rect(x, y, w, h);
    if (w > textWidth(word) + 6)
    {
      if (h > textAscent() + 6)
      {
        textAlign(CENTER, CENTER);
        fill(30);
        text(word, x + w/2, y + h/2);
      }
    }
  }
}

