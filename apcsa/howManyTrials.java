public class InsideCircle {
    public static void main(String[] args){
        // Test cases
        System.out.println(isInsideUnitCircle(0.5,0.5));
        System.out.println(isInsideUnitCircle(0.6,0.8));
        System.out.println(isInsideUnitCircle(1.0,1.0));

        for(int i = 10; i <= args[0]; i *= 10)
        
    }

    public static boolean isInsideUnitCircle(double x, double y){
        return x * x + y * y <= 1;
    }
}

