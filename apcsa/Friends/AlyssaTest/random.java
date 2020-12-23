
public class random {
    public static void main(String[] args) {
        int numberOfGuests = Integer.parseInt(args[0]);
        int trials = Integer.parseInt(args[1]);
        
        int countAll = 0;
        int count =0; // #of ppl who heard the rumor
        int previous; //the previous index
        int pointer; //curr index
        for (int i = 0; i < trials; i++) {
// per trial
            int[] guestsArr = new int[numberOfGuests];
            previous = (int)(Math.random() * (numberOfGuests));
            guestsArr[previous] = 1;
            // create the rumor starter
            
            pointer = findNewIndex(previous, -1, numberOfGuests);
            // the next index

            while (guestsArr[pointer] != 1){
                // Find a new index and test if that index got the rumor already                
                guestsArr[pointer] = 1;
                int hold = pointer;
                pointer = findNewIndex(previous, pointer, numberOfGuests);
                previous = hold;
            }

            // itterate through the created list to see if everyone had gotten the rumor
            boolean everyone = true;
            for(int x = 0; x < guestsArr.length; x++){
                if (guestsArr[x] == 0){
                    everyone = false;


                    // for(int j : guestsArr){
                    //     System.out.print(j);
                    // }
                    // System.out.println();
                    // throw new ArithmeticException("Exception message");

                    
                }else{
                    count++;
                }
            }
            if (everyone){
                countAll ++;
            }           



        }
        // summary
        double prob = (double) countAll / trials;
        double people = (double) count / trials; // error 1
        System.out.println("P(all heard): " + prob);
        System.out.println("expect number of people who heard rumor: " + people);

    }
    
// returns a new index that is within the arr but is not the previous one or this one
//error 2 (main error)
    public static int findNewIndex(int previous, int current, int numberOfGuests) {
        // System.out.println("index:" + previous + current+ numberOfGuests);
        if (numberOfGuests ==1){ //special case, must return previous
            return previous;
        }
        int pointer = previous;

        // pointer cant be prev or curr so try again
        //"A person hearing this rumor for the first time will immediately 
        // tell it ot one other guest emphazize on other"
        while (pointer == previous || pointer == current){
            pointer = (int)(Math.random() * (numberOfGuests)); 
        }

        return pointer;
    }


   



}
