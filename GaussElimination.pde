

void doGauss(){

  double[][] prob = {
        // x = 1, y = 2, z = 3
        { 1,  2, 3 },  // 1x + 2y + 3z = 14
        { 1, -1, 1},  // 1x - 1y + 1z = 2
        { 4, -2, 1}   // 4x - 2y + 1z = 3
    };
  
  double[] sol = {
    14, 2, 3
  };
  
  print(prob);
  
  println(gaussElimination(prob, sol));
  println("solution");
  print(prob);
  
  
  
}



public double[] gaussElimination(double[][] input, double[] solution){
  int rows = input.length;
  int cols = rows;
  
  int[] nan = new int[0];
  
  for(int row = 0; row < rows; row ++){
    
    // 1. set c[row][row] equal to 1
    double factor = input[row][row];
    if(factor == 0){
      nan = append(nan, row);
    } else {
    for(int col = 0; col < cols; col ++){
      input[row][col] /= factor;
    }
    solution[row] /= factor;
    
    
    println("-- " + factor);
    
    // 2. set c[row][row2] equal to 0
    for(int row2 = 0; row2 < rows; row2 ++){
      if(row2 != row) {
        factor = -input[row2][row];
        for (int col = 0; col < cols; col ++){
          input[row2][col] += factor * input[row][col];
        }
        solution[row2] += factor * solution[row];
      }
      
    }
    
    print(input);
    println("-- " + factor);
    
  }
  }
  
  return solution;
}

static public void print(double [][] matrix)
{
    for(int c1 = 0; c1 < matrix.length; c1++)
    {
        System.out.print("[ ");

        for(int c2 = 0; c2 < matrix[0].length-1; c2++)
            System.out.print(matrix[c1][c2] + ", ");

        System.out.println(matrix[c1][matrix[c1].length-1] + " ]");
    }
}
