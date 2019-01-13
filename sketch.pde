


boolean ended;

int red = color(124, 0, 0);
int yel =color(255, 244, 52);
int whi = color(249, 249, 249);

void setup(){
  fullScreen();
  //size(10, 10);
  
  cols = new int[width * height];
  for(int i = 0; i < cols.length; i ++){
    cols[i] = color(255);
  }
  
  thread("makeMap");
  
}


public void makeMap(){
  
  makeHeatmap(-width / 2, -height / 2, width, height, new Function());
  transfer();
  
  ended = true;
  println(min + " < " + max);
}

void draw(){
  
  renderHeatmap();
  if(ended){
    ended = false;
    //size *= 2;
    thread("makeMap");
  }
  //text("render", 0, 0, width, height);
}



float[] col;
float min, max;
int[] cols;

public void renderHeatmap(){
  loadPixels();
  for(int i = 0; i < pixels.length; i ++){
    pixels[i] = cols[i];
  }
  updatePixels();
}

public void transfer(){
  //println(min + " " + max);
  
  for(int i = 0; i < cols.length; i ++){
    
    cols[i] = convertColor(col[i], min, max);
  }
}

public void makeHeatmap(int xPos, int yPos, int xSize, int ySize, Function f){
  col = new float[width * height];
  
  for(int x = 0; x < width; x ++){
    for(int y = 0; y < height; y ++){
      col[x + y * width] = f.getPos(xPos + x * xSize / width, yPos + y * ySize / height);
      if(x == 0 && y == 0){
        min = col[0];
        max = col[0];
        
        
      } else if(col[x + y * width] < min){
        min = col[x + y * width];
        
      } else if(col[x + y * width] > max){
        max = col[x + y * width];
        
      }
      
      
      
    }
  }
  
}

public int convertColor(float value, float min, float max){
  HashMap<Float, Integer> in = new HashMap<Float, Integer>();
  in.put(min, red);
  in.put(min + (max - min) / 2.0, yel);
  in.put(max, whi);
  
  return convertColor(value, in);
}



public int convertColor(float value, HashMap<Float, Integer> cols){
  Float[] entr = cols.keySet().toArray(new Float[0]);
  float last = entr[0];
  for(float f : entr){
    if(value < f){
      int down = cols.get(last);
      int up = cols.get(f);
      float dif = (value - last) / (f - last);
      
      return color(
        red(down) + dif * (red(up) - red(down)),
        green(down) + dif * (green(up) - green(down)),
        blue(down) + dif * (blue(up) - blue(down)));
    } else {
      last = f;
    }
  }
  return cols.get(entr[entr.length - 1]);
}



public void renderCoordinates(){
  
  
}





