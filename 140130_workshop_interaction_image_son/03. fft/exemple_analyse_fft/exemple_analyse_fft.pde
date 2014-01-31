import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer son;
FFT         fft;

void setup() {
  size(512, 600);
  minim = new Minim(this);
  son = minim.loadFile("son_04.mp3", 1024);
  son.loop();
  fft = new FFT( son.bufferSize(), son.sampleRate() );
  fft.linAverages(4);
}

void draw() {
  background(0);
  stroke(255);
  fft.forward( son.mix );
  for(int i = 0; i < fft.avgSize(); i++) {
    rect(i*128, height - fft.getAvg(i)*height , 128, fft.getAvg(i)*height);
    // on peut utiliser switch(i) pour travailler sur les valeurs
  }
}
