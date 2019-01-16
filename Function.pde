


public class Function{
  
  
  
  public Function(double[] stuff){
    this.vars = stuff;
  }
  
  double[] vars;
  
  public float getPos(int x, int y){
    /*
    if(y == 0){
      return x;
    }*/
    double rV = 0;
    double xx = 1;
    double yy = 1;
    for(int i = 0; i < vars.length; i ++){
      if(i % 2 == 0){
        xx *= x;
        rV += xx * vars[i];
      } else {
        yy *= y;
        rV += yy * vars[i];
      }
    }
    
    return (float) rV;
  }
  
  
  
  
  
  
}
