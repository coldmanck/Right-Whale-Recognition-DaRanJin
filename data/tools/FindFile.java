import java.util.*;


public class FindFile {
	public static void main(String[] args) {
		try{
			String folderPath1 = new String("croppedTestImageNew/");
			String folderPath2 = new String("croppedTestImage/");
			java.io.File folder1 = new java.io.File(folderPath1);
			java.io.File folder2 = new java.io.File(folderPath2);
			String [] list1 = folder1.list();
			String [] list2 = folder2.list();
			int check1 [] = new int[list1.length];
			int check2 [] = new int[list2.length];

			for (int i = 0 ; i < list1.length; i++) {
				for (int j = 0; j < list2.length; j++) {
					if (list1[i].equals(list2[j])) {
						check1[i] = 1;
						check2[j] = 1;
						break;
					}
				}
			}
			for (int i = 0; i < check1.length; i++) {
				if (check1[i] != 1)
					System.out.println(folderPath1 + " " +  list1[i]);
			}
			for (int i = 0; i < check2.length; i++) {
				if (check2[i] != 1)
					System.out.println(folderPath2 + " " + list2[i]);
			}
		} catch(Exception e){
			System.out.println("Error");
			// e.printStackTree();
		}
    }
}
