public class RumorsJ {
    public static void main(String[] args) {
        int n = Integer.parseInt(args[0]);
        int trials = Integer.parseInt(args[1]);
        int[] guests = new int[n];
        int count = 0;
        for (int i = 0; i < trials; i++) {
            // System.out.println(i); 
            int spreader = 0;
            int r = (int) (Math.floor(Math.random()*n));
            // System.out.println(r);
            while (true) {
                if (r == spreader && r == n - 1) {
                    r = 0;
                } else if (r == spreader) {
                    r++;
                }
                guests[r] += 1;
                System.out.println(r);
                System.out.println(guests[r]);
                if (guests[r] >= 2){
                    break;
                }
                spreader = r;
                r = (int) (Math.floor(Math.random()*n));
            }
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


// 4 - 1 = 3 * (0-1), 0.1 1.1 2.2


// 0 - .2499999 => 0
// .25 - .4999 => 1
// 4 = floor(4 * [0 - 1)) int = 0, 1, 2, 3

// Math.floor(Math.random()*(max))



