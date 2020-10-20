public class Assignment9 { 

    public static void main(String[] args) {
        Demo();
        Demo(3);
        Demo(5);
    }
    public static void Demo(int x){
        for (int i= 1 ; i <= x; i++){
            for (int j=x-i+1; j<= x; j++){
                System.out.print(i);
            }
            System.out.println();
        }
    }
    public static void Demo(){
        Demo(5);
    }
}


