public class JavaAssignment4{

    // part I
    public static boolean isInsideUnitCircle(double x, double y){
        return (x * x + y * y < 1);
    }

    //part II
    public static double ratioOfPoints(int howManyTrials){
       int total= 0;
       for (int i=0; i<howManyTrials; i++){
           double x = Math.random();
           double y = Math.random();
           if (isInsideUnitCircle(x, y)){
               total++;
           }
       }
       return (double)total / howManyTrials;
    }

    //part III
    public static void main(String []args){
       int numOfPower = 7;
       for (int i = 0; i < numOfPower ; i++){
           System.out.println(4 * ratioOfPoints((int)Math.pow(10,(i + 1))));
       }
       
    }
}

//as the number of tests increase the number is more likely to
//be accurate, so we can be more confident in our results