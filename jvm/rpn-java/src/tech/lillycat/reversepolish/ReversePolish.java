package tech.lillycat.reversepolish;

import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;

import java.util.Scanner;
import java.util.Stack;

public class ReversePolish {
    public static void main(String[] args) {
        Scanner stdin = new Scanner(System.in);
        String input = stdin.nextLine();
        String[] tokens = input.split(" ");
        System.out.println(evalInput(tokens));
    }

    @Contract(pure = true)
    public static double evalInput(String @NotNull [] expr) {
        Stack<Double> stack = new Stack<>();
        stack.push(Double.NaN);
        Double y;
        Double x;

        for (String s : expr) {
            if (numberTools.isNumeric(s)) {
                if (Double.valueOf(s).isNaN()) {
                    break;
                } else {
                    stack.push(Double.valueOf(s));
                }
            } else {
                switch (s) {
                    case "+" -> {
                        y = stack.pop();
                        x = stack.pop();
                        stack.push(x + y);
                    }
                    case "-" -> {
                        y = stack.pop();
                        x = stack.pop();
                        stack.push(x - y);
                    }
                    case "*" -> {
                        y = stack.pop();
                        x = stack.pop();
                        stack.push(x * y);
                    }
                    case "/" -> {
                        y = stack.pop();
                        x = stack.pop();
                        stack.push(x / y);
                    }
                    case "^" -> {
                        y = stack.pop();
                        x = stack.pop();
                        stack.push(Math.pow(x, y));
                    }
                    default -> System.out.println("Invalid operator");
                }
            }
        }
        return stack.peek();
    }
}

