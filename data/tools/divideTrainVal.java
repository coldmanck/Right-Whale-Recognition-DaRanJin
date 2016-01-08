import java.io.*;
import java.util.Scanner;

public class divideTrainVal {
	public static void main(String[] args) throws IOException{
		Scanner input = new Scanner(new FileInputStream("label_train.txt"));
		PrintWriter output = new PrintWriter(new FileOutputStream("label_val.txt"));
		String str;
		try {
			while((str = input.nextLine()) != null){
//				String[] strs = str.split(" ");
				if(str.contains("w_9"))
					output.println(str);
				else
					System.out.println(str);
			}
		} catch (java.util.NoSuchElementException ex){
		}

		input.close();
		output.close();
	}
}
