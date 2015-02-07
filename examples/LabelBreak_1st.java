
import java.util.Random;

public class LabelBreak_1st {
  public static void main(String[] args) {
    System.out.println("Loop & labels...");

    Random rand = new Random();

first:
    for (int i = 0; i < 10; i++) {

      System.out.println("  rand(a)");
      int a = rand.nextInt(1000);

second:
      for (int j = 0; j < 10; j++ ) {

        System.out.println("    rand(b)");

        int b = rand.nextInt(1000);

third:
        for (int k = 0; k < 10; k++ ) {

          System.out.println("    rand(c)");

          int c = rand.nextInt(1000);

          if (a == b && a == c) {
            System.out.println("      a == b == c");
            break first;
          }
        }
      }
    }
  }
}

