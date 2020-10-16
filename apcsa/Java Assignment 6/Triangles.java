public class Triangles {

    public static double distance(double x1, double y1, double x2, double y2){

        return (double)
        (Math.round(Math.sqrt(
            Math.pow(x1 - x2, 2) 
            +
            Math.pow(y1 - y2, 2)    
                    ) 
            * 10000.0)
            /10000.0);
    }

    public static String classify(  double x1, double y1, 
					            double x2, double y2, 
						     double x3, double y3){
        int sameLen = 0;
        double l1 = distance(x1, y1, x2, y2);
        double l2 = distance(x3, y3, x2, y2);
        double l3 = distance(x1, y1, x3, y3);
        // System.out.println(l1);
        // System.out.println(l3);
        // System.out.println(l2);
        if (l1==l2)
        sameLen ++;
        if (l1==l3)
        sameLen ++;
        if (l3==l2)
        sameLen ++;

        switch(sameLen) {
            case 0:
                return ("scalene");
            case 1:
                return ("isosceles");
            case 3:
                return ("equilateral");  
        }
        return "Fail";
    }

    public static double perimeter( double x1, double y1, 
					                double x2, double y2, 
					    	        double x3, double y3){
    double l1 = distance(x1, y1, x2, y2);
    double l2 = distance(x3, y3, x2, y2);
    double l3 = distance(x1, y1, x3, y3);
    return l1 + l2 + l3;
}

public static double area(  double x1, double y1, 
					        double x2, double y2, 
				                double x3, double y3){
    double l1 = distance(x1, y1, x2, y2);
    double l2 = distance(x3, y3, x2, y2);
    double l3 = distance(x1, y1, x3, y3);
        // System.out.println(l1);
        // System.out.println(l3);
        // System.out.println(l2);
    double semi = (l1 + l2 + l3) / 2.0 ;
    return Math.round((Math.sqrt(semi * (semi - l1) * (semi - l2) * (semi - l3))) * 10000.0) / 10000.0;
}        
    
}
