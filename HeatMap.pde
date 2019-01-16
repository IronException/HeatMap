


boolean ended;

int red = color(124, 0, 0);
int yel = color(255, 244, 52);
int whi = color(249, 249, 249);


Function function;

void setup(){
  //fullScreen();
  size(200, 200);
  
  
  
  String[] dataFormat = getDataFormat("x z d", new String[]{"x", "z", "d"});
  
  String[] info = new String[0];
  String[] inf0 = new String[]{
    "20 0 0",
    "30 0 1",
    "0 15 0",
    "0 20 0",
    "0 25 0",
    "0 30 0"
  };
  double[] x = new double[info.length];
  double[] y = new double[info.length];
  double[] days = new double[info.length];
  HashMap<String, String> zw;
  for(int i = 0; i < info.length; i ++){
    zw = getData(dataFormat, info[i]);
    x[i] = Double.parseDouble(zw.get("x"));
    y[i] = Double.parseDouble(zw.get("z"));
    days[i] = Double.parseDouble(zw.get("d"));
    
  }
  
  
  
  double[] stuff = gaussElimination(getMatrix(x, y), days);
  
  function = new Function(stuff);
  
  init();
  //thread("makeMap");
  
}

public void init(){
  cols = new int[width * height];
  for(int i = 0; i < cols.length; i ++){
    cols[i] = color(255);
  }
}


public void makeMap(){
  
  makeHeatmap(-width / 2, -height / 2, width, height, function);
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
  float[] pos = getPositions(min, max);
  int[] colss = getColors();
  
  
  for(int i = 0; i < cols.length; i ++){
    cols[i] = convertColor(col[i], pos, colss);
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

public int[] getColors(){
  return new int[]{
    red,
    yel,
    whi };
}

public float[] getPositions(float min, float max){
  return new float[]{
    min,
    min + (max - min) / 2.0,
    max };
}

public int convertColor(float value, float[] pos, int[] cols){
  for(int i = 0; i < pos.length; i ++){
    if(value < pos[i]){
      int down = cols[i - 1];
      int up = cols[i];
      float dif = (value - pos[i - 1]) / (pos[i] - pos[i - 1]);
      
      return color(
        red(down) + dif * (red(up) - red(down)),
        green(down) + dif * (green(up) - green(down)),
        blue(down) + dif * (blue(up) - blue(down)));
    }
  }
  return cols[cols.length - 1];
}



public void renderCoordinates(){
  
  
}
