package tech.lillycat.cat;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class §Cat {
    public static void main(String[] args) {
        Scanner stdin = new Scanner(System.in);

        if (args.length == 0) {
            while (stdin.hasNextLine()) {
                String input = stdin.nextLine();
                System.out.println(input);
            }
        }
        else {
            for (String arg : args) {
                File file = new File(arg);
                if (file.isDirectory()) {
                    System.out.println("cat: " + arg + ": Is a directory");
                    System.exit(1);
                }
                else if (!file.exists()) {
                    System.out.println("cat: " + arg + ": No such file or directory");
                    System.exit(1);
                }
                else {
                    try {
                        Scanner fileScanner = new Scanner(file);
                        while (fileScanner.hasNextLine()) {
                            String input = fileScanner.nextLine();
                            System.out.println(input);
                        }
                    }
                    catch (FileNotFoundException e) {
                        System.out.println("cat: " + arg + ": No such file or directory");
                    }
                }
            }
        }
    }
}
