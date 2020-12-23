import java.util.Random;
public class DemoRandom{
  public static void main(String[]args){

    //here no seed is provided, so it uses the clock as a seed
    //this can be used to produce a random seed for a different Random object!
    Random rng = new Random();
    for(int i =  0; i < 5; i++ ){
      System.out.println(rng.nextInt() % 1000);
    }
    System.out.println();

    //specified seed can be used to reproduce sequences
    rng = new Random(100);//seed of 100 is stored.
    for(int i =  0; i < 5; i++ ){
      System.out.println(rng.nextInt() % 1000);
    }
  }
}