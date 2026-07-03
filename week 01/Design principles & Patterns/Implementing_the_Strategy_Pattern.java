interface PaymentStrategy {
    void pay(double amount);
}

class CreditCardPayment implements PaymentStrategy {

    @Override
    public void pay(double amount) {
        System.out.println("Payment of ₹" + amount + " made using Credit Card.");
    }
}

class PayPalPayment implements PaymentStrategy {

    @Override
    public void pay(double amount) {
        System.out.println("Payment of ₹" + amount + " made using PayPal.");
    }
}

class PaymentContext {

    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void makePayment(double amount) {

        if (paymentStrategy == null) {
            System.out.println("Please select a payment method.");
            return;
        }

        paymentStrategy.pay(amount);
    }
}

public class Implementing_the_Strategy_Pattern {

    public static void main(String[] args) {

        PaymentContext paymentContext = new PaymentContext();

        paymentContext.setPaymentStrategy(new CreditCardPayment());
        paymentContext.makePayment(2500);

        paymentContext.setPaymentStrategy(new PayPalPayment());
        paymentContext.makePayment(4500);
    }
}