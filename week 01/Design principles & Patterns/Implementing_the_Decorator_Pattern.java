interface Notifier {
    void send(String message);
}

class EmailNotifier implements Notifier {

    @Override
    public void send(String message) {
        System.out.println("Email Notification : " + message);
    }
}

abstract class NotifierDecorator implements Notifier {

    protected Notifier notifier;

    NotifierDecorator(Notifier notifier) {
        this.notifier = notifier;
    }

    @Override
    public void send(String message) {
        notifier.send(message);
    }
}

class SMSNotifierDecorator extends NotifierDecorator {

    SMSNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String message) {
        super.send(message);
        sendSMS(message);
    }

    private void sendSMS(String message) {
        System.out.println("SMS Notification : " + message);
    }
}

class SlackNotifierDecorator extends NotifierDecorator {

    SlackNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String message) {
        super.send(message);
        sendSlackMessage(message);
    }

    private void sendSlackMessage(String message) {
        System.out.println("Slack Notification : " + message);
    }
}

public class Implementing_the_Decorator_Pattern {

    public static void main(String[] args) {

        Notifier emailNotifier = new EmailNotifier();

        System.out.println("===== Only Email Notification =====");
        emailNotifier.send("Your order has been placed.");

        System.out.println();

        System.out.println("===== Email + SMS Notification =====");
        Notifier emailAndSMS = new SMSNotifierDecorator(emailNotifier);
        emailAndSMS.send("Your payment was successful.");

        System.out.println();

        System.out.println("===== Email + SMS + Slack Notification =====");
        Notifier multiChannelNotifier =
                new SlackNotifierDecorator(
                        new SMSNotifierDecorator(
                                new EmailNotifier()
                        )
                );

        multiChannelNotifier.send("Your order has been shipped.");
    }
}