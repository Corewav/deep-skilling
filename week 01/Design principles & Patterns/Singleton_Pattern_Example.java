class Logger {

    // Single instance of Logger
    private static Logger instance;

    // Private constructor
    private Logger() {
        System.out.println("Logger Instance Created.");
    }

    // Public method to access the single instance
    public static Logger getInstance() {

        if (instance == null) {
            instance = new Logger();
        }

        return instance;
    }

    // Logging method
    public void log(String message) {
        System.out.println("Log : " + message);
    }
}

public class Singleton_Pattern_Example {

    public static void main(String[] args) {

        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        logger1.log("Application Started.");
        logger2.log("User Logged In.");

        System.out.println();

        System.out.println("Checking Both Instances...");

        if (logger1 == logger2) {
            System.out.println("Only one Logger instance exists.");
        } else {
            System.out.println("Multiple Logger instances exist.");
        }
    }
}