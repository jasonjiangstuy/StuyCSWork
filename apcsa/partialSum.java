public class partialSum {
    public static void allSum(int[]options, int pointer, int pSum){
        if (pointer >= options.length) System.out.println(pSum);
        else{
            allSum(options, pointer + 1, pSum);
            allSum(options, pointer + 1, pSum + options[pointer]);
        }
    }

    public static void main(String[] args) {
        allSum(new int[]{1, 5, 10}, 0, 0);
    }
}
