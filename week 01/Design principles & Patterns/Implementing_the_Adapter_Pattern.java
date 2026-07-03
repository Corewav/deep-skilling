interface PaymentProcessor {
    void processPayment(double amount);
}

class PayPalGateway {

    public void makePayment(double amount) {
        System.out.println("Payment of ₹" + amount + " processed using PayPal Gateway.");
    }
}

class StripeGateway {

    public void pay(double amount) {
        System.out.println("Payment of ₹" + amount + " processed using Stripe Gateway.");
    }
}

class RazorpayGateway {

    public void createOrderAndPay(double amount) {
        System.out.println("Payment of ₹" + amount + " processed using Razorpay Gateway.");
    }
}

class PayPalAdapter implements PaymentProcessor {

    private PayPalGateway payPalGateway;

    PayPalAdapter(PayPalGateway payPalGateway) {
        this.payPalGateway = payPalGateway;
    }

    @Override
    public void processPayment(double amount) {
        payPalGateway.makePayment(amount);
    }
}

class StripeAdapter implements PaymentProcessor {

    private StripeGateway stripeGateway;

    StripeAdapter(StripeGateway stripeGateway) {
        this.stripeGateway = stripeGateway;
    }

    @Override
    public void processPayment(double amount) {
        stripeGateway.pay(amount);
    }
}

class RazorpayAdapter implements PaymentProcessor {

    private RazorpayGateway razorpayGateway;

    RazorpayAdapter(RazorpayGateway razorpayGateway) {
        this.razorpayGateway = razorpayGateway;
    }

    @Override
    public void processPayment(double amount) {
        razorpayGateway.createOrderAndPay(amount);
    }
}

public class Implementing_the_Adapter_Pattern {

    public static void main(String[] args) {

        PaymentProcessor paypalProcessor = new PayPalAdapter(new PayPalGateway());
        PaymentProcessor stripeProcessor = new StripeAdapter(new StripeGateway());
        PaymentProcessor razorpayProcessor = new RazorpayAdapter(new RazorpayGateway());

        paypalProcessor.processPayment(2500);
        stripeProcessor.processPayment(4200);
        razorpayProcessor.processPayment(6800);
    }
}