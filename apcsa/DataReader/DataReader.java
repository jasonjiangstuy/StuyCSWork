import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
public class DataReader {

    public static void main(String[]args){
        
        try{
            foo("data.txt");
        }
        catch (FileNotFoundException e){
            System.out.println("File not found");
            System.exit(1);
        }
    }
        public static void foo(String fileName) throws FileNotFoundException{
            File f = new File(fileName);
            Scanner in = new Scanner(f);
            //NOW read the file here and process it.
            while(in.hasNext()){
                String line = in.nextLine();
                String[] splitLine = line.split(" ");
                if (splitLine[1].equals("+")){
                    System.out.println(Double.valueOf(splitLine[0]) + Double.valueOf(splitLine[2]));
                }
                else if(splitLine[1].equals("-")){
                    System.out.println(Double.valueOf(splitLine[0]) - Double.valueOf(splitLine[2]));
                }
                else if(splitLine[1].equals("*")){
                    System.out.println(Double.valueOf(splitLine[0]) * Double.valueOf(splitLine[2]));
                }
                else if(splitLine[1].equals("/")){
                    System.out.println(Double.valueOf(splitLine[0]) / Double.valueOf(splitLine[2]));
                }
                else{
                    System.out.println("bad operator");
                    System.exit(1);
                }
          }
        
        
        
            
        
    }
}