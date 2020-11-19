public class Rumors {
    public static void main(String[] args) {
        System.out.println("test");
        int n = Integer.parseInt(args[0]);

        int trials = Integer.parseInt(args[1]);

        //  = number of guests (not including alice) and trials


        int[] guests = new int[n];

        int count = 0;

        for (int i = 0; i < trials; i++) {
            int spreader = 0;
            int r = (int) (Math.random() * (n - 1));
            System.out.println("test");
            while (guests[r] != 2) {
                System.out.println("test1");
                // do we ever set guests[r] to 2
                r = (int) (Math.random() * (n - 1));
                while (r == spreader) {
                    r = (int) (Math.random() * (n - 1));
                    // System.out.println(r);0
                    // System.out.println(spreader);0
                    System.out.println(Math.random() * (n - 1));
                    System.out.println(n);   
                    // redonent?
                    if (r != spreader) 
                        break;
                    // 

                }
                spreader = r;
                guests[r] += 1; // times of rumors
                if (guests[r] == 2)
                    break;
            }
//             Write a program to estimate the probability
//    that everyone at the party will hear the rumor before it
            boolean everyone = true;
            for (int j = 0; j < n; j++) {
                if (guests[j] == 0) {
                    everyone = false;
                    break;
                }
            }
            if (everyone) count++;
        }
        double prob = (double) count / trials;
        double people = prob * n;
        System.out.println("P(all heard): " + prob);
        System.out.println("expect number of people who heard rumor: " + people);
    }
}