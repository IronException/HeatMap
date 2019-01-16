

public String[] getDataFormat(String sorting, String[] symbols){
  String[] rV = new String[0];
  String cur = "";
  int ind;
  for(int i = 0; i < sorting.length(); i ++){
    cur += sorting.charAt(i);
    ind = compareContains(symbols, cur);
    if(ind != -1){
      rV = append(rV, cur.substring(0, cur.length() - ind));
      rV = append(rV, cur.substring(cur.length() - ind));
      cur = "";
    }
    
  }
  
  for(int i = 0; i < rV.length; i ++){
    println("[" + i + "]: (" + rV[i] + ")");
  }
  return rV;
}



public HashMap<String, String> getData(String[] dataFormat, String data){
  HashMap<String, String> rV = new HashMap<String, String>();
  int ind = 0; // index in dataFormat
  int lastInd = dataFormat[ind].length();
  ind += 2;
  
  for(int i = 0; i < data.length() && ind < dataFormat.length; i ++){
    
  
    if(dataFormat[ind].equals(data.substring(i, i + dataFormat[ind].length()))){
      
      rV.put(dataFormat[ind - 1], data.substring(lastInd, i));
      
      lastInd = i + dataFormat[ind].length();
      ind += 2;
      
      
    }
  }
  rV.put(dataFormat[ind - 1], data.substring(lastInd));
  
  println(rV);
  return rV;
}


public void println(HashMap<String, String> in){
  String[] entr = in.keySet().toArray(new String[0]);
  for(int i = 0; i < entr.length; i ++){
    println("[" + entr[i] + "]: " + in.get(entr[i]));
  }
}

// TODO what does contains do?
/*public boolean compareContains(String[] data, String var, int ind){
  return compareContains(data, var.substring(ind));
}

public boolean compareContains(String[] data, String toComp){
  for(int i = 
}*/


public int compareContains(String[] data, String toComp){
  for(int i = 0; i < data.length; i ++){
    if(compEnd(data[i], toComp)){
      return i;
    }
  }
  return -1;
}

public boolean compEnd(String a, String b){
  String shord = a;
  String toComp = b;
  if(toComp.length() < shord.length()){
    shord = b;
    toComp = a;
  }
  
  int lenS = shord.length() - 1;
  int lenC = toComp.length() - 1;
  
  for(int i = 0; i < shord.length(); i ++){
    if(shord.charAt(lenS - i) != toComp.charAt(lenC - i)){
      return false;
    }
  }
  return true;
}

public boolean compStart(String a, int aInd, String b, int bInd){
  return compStart(a, aInd, b.substring(bInd));
}

public boolean compStart(String a, int aInd, String b){
  return compStart(a.substring(aInd), b);
}

public boolean compStart(String a, String b){
  String shord = a;
  String toComp = b;
  if(toComp.length() < shord.length()){
    shord = b;
    toComp = a;
  }
  
  for(int i = 0; i < shord.length(); i ++){
    if(shord.charAt(i) != toComp.charAt(i)){
      return false;
    }
  }
  return true;
}


// inputs have to be converted already
public double[][] getMatrix(double[] xCoords, double[] yCoords){
  int len = xCoords.length;
  double[][] rV = new double[len][];
  for(int i = 0; i < len; i ++){
    rV[i] = getLine(xCoords[i], yCoords[i], len);
  }
  return rV;
}


public double[] getLine(double xCoord, double yCoord, int len){
  double[] rV = new double[len];
  double xIn = xCoord;
  double yIn = yCoord;
  for(int i = 0; i < len; i ++){
    if(i % 2 == 0){
      rV[i] = xIn;
    } else {
      rV[i] = yIn;
      xIn *= xCoord;
      yIn *= yCoord;
    }
  }
  return rV;
}
