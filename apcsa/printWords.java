public class printWords {
    public static void main(String[] args) {
        // printAllWords(0, "");
        // printAllWords(1, "");
        // printAllWords(2, "");
        // printAllWords(3);
        // printNoDoubleLetterWords(2, new char[]{'a','b','c'});
        // printNoDoubleLetterWords(3,new char[]{'a','b','c'});
    }
    public static void printAllWords(int length){
        printAllWords(length,"");
    }
    public static void printAllWords(int length, String word){
        if (length > 0){
            for (int i = 0; i < 26; i++){
                printAllWords(length - 1, word + (char)('a' + i));
            }
            
        }
        else{
            System.out.println(word);
        }
        
    }

    public static void printNoDoubleLetterWords(int length,char[] letters){
        printNoDoubleLetterWords(length,"",letters);
        }

    /*Print all words that are made of the characters in letters. There may not be consecutive equal letters,
    *aax is not allowed, but axa is allowed.
    *@param length : either how many more letters need to be
    *@param word : the partial word so far.
    *@param letters: the letters you should be using
    */
    public static void printNoDoubleLetterWords(int length,String word,char[]letters){
        if (length > 0){
            for (char i : letters){
                if (word.length() == 0 || word.charAt(word.length() - 1) != i){
                    printNoDoubleLetterWords(length - 1, word + i, letters);
                }
                
            }
            
        }
        else{
            System.out.println(word);
        }
    }
}
