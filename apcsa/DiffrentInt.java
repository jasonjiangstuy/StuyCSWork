
public class DiffrentInt {
    // public static void main(String [] args){
    //     int[] randInts = new int [5];
    //     for (int i =0 ; i< randInts.length; i++){
    //         randInts[i] = i;
    //     }
    //     System.out.println(arrToString(randInts));
    // }

    // public static String arrToString(int[] arr){
    //     if (arr.length < 1){
    //       return "{}";
    //     }
    //     String sum = "{";
    //     for (int i = 0; i< arr.length; i++){
    //       sum += arr[i]+ ", "; 
    //     }
    //     sum = sum.substring(0, sum.length() - 2);
    //     sum += '}';
    //     return sum;
    //   }
//____________________________________________________________
        public static void main(String [] args){
        int[] randInts = new int [5];
        for (int i =0 ; i< randInts.length; i++){
            randInts[i] = i};
        }
        System.out.println(arrToString(randInts));
    }

    public static String arrToString(int[] arr){
        if (arr.length < 1){
          return "{}";
        }
        String sum = "{";
        for (int i = 0; i< arr.length; i++){
          sum += arr[i]+ ", "; 
        }
        sum = sum.substring(0, sum.length() - 2);
        sum += '}';
        return sum;
      }

      public static String arrToString(int[][] arr){
        if (arr.length < 1){
          return "{}";
        }
        String sum = "{";
        for (int i = 0; i< arr.length; i++){
          sum += arrToString(arr[i]) + ", "; 
        }
        sum = sum.substring(0, sum.length() - 2);
        sum += '}';
        return sum;
      }
      
}
