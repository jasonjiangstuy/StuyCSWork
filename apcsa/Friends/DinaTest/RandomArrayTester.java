import java.util.Arrays;
public class RandomArrayTester{
  public static void main(String[]args){

    int[][][]arrays = new int[3][][];
    arrays[0]=Demo.create2DArray(3,6,5);
    arrays[1]=Demo.create2DArray(6,3,100);
    arrays[2]=Demo.create2DArrayRandomized(9,2,10);

    System.out.println("Random 3X6 up to 5 - compare to Arrays.toString method");
    System.out.println(Arrays.deepToString(arrays[0]).replace("], ","],\n"));
    System.out.println(Demo.arrayDeepToString(arrays[0]).replace("}, ","},\n"));
    System.out.println("\nRandom 6X3 up to 100");
    System.out.println(Demo.arrayDeepToString(arrays[1]).replace("}, ","},\n"));
    System.out.println("\nRandom 9X(0,1 or 2) up to 10");
    System.out.println(Demo.arrayDeepToString(arrays[2]).replace("}, ","},\n"));

  }
}