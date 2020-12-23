import java.util.ArrayList;
import java.util.Arrays;

public class Competition {
    public static void main(String[] args) {
        
 
        ArrayList<Integer> a = new ArrayList<Integer>(Arrays.asList(new Integer[]{70, 75, 80}));
        ArrayList<Integer> b = new ArrayList<Integer>(Arrays.asList(new Integer[]{80, 82, 85}));
        ArrayList<Integer> c = new ArrayList<Integer>(Arrays.asList(new Integer[]{90, 91, 92}));
        System.out.println(golfingBrothers(a, b, c).equals("adam"));

        a = new ArrayList<Integer>(Arrays.asList(new Integer[]{100, 75}));
        b = new ArrayList<Integer>(Arrays.asList(new Integer[]{80, 82, 85, 86}));
        c = new ArrayList<Integer>(Arrays.asList(new Integer[]{90, 91, 92}));
        // System.out.println(golfingBrothers(a, b, c));
        System.out.println(golfingBrothers(a, b, c).equals("bob"));

        a = new ArrayList<Integer>(Arrays.asList(new Integer[]{70}));
        b = new ArrayList<Integer>(Arrays.asList(new Integer[]{90, 91, 92}));
        c = new ArrayList<Integer>(Arrays.asList(new Integer[]{80, 82}));
        System.out.println(golfingBrothers(a, b, c).equals("craig"));

        a = new ArrayList<Integer>(Arrays.asList(new Integer[]{70}));
        b = new ArrayList<Integer>(Arrays.asList(new Integer[]{90, 91, 92}));
        c = new ArrayList<Integer>(Arrays.asList(new Integer[]{80, 82}));
        System.out.println(golfingBrothers(a, b, c).equals("craig"));

        a = new ArrayList<Integer>(Arrays.asList(new Integer[]{}));
        b = new ArrayList<Integer>(Arrays.asList(new Integer[]{90, 91, 92}));
        c = new ArrayList<Integer>(Arrays.asList(new Integer[]{0, 20}));
        System.out.println(golfingBrothers(a, b, c).equals("craig"));
    }
    public static String golfingBrothers(ArrayList<Integer> adamList, ArrayList<Integer> bobList, ArrayList<Integer> craigList) {
        double a = add(adamList);
        double b = add(bobList);
        double c = add(craigList);

        if (a > b){
            if (b < c){
                return "bob";
            }
            else{
                return "craig";
            }
        }
        else{
            if (a < c){
                return "adam";
            }
            else{
                return "craig";
            }
        }

        
    }
    public static double add(ArrayList<Integer> oneList) {
        if (oneList.size() < 2){
            return Double.POSITIVE_INFINITY;
        }

        int total = 0;
        for (int i = 0; i < oneList.size();i++){
            total += oneList.get(i);
        }
        return (double)total/oneList.size();
        
    }
    
}
