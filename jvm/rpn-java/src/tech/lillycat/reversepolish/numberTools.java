package tech.lillycat.reversepolish;

import org.jetbrains.annotations.Contract;

public class numberTools {
    @Contract(pure = true)
    public static boolean isNumeric(String str) {
        try {
            Double.parseDouble(str);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }
}
