import java.util.ArrayList;
import java.util.List;

interface Observer {
    void update(String stockName, double stockPrice);
}

interface Stock {
    void registerObserver(Observer observer);
    void deregisterObserver(Observer observer);
    void notifyObservers();
}

class StockMarket implements Stock {

    private List<Observer> observers = new ArrayList<>();

    private String stockName;
    private double stockPrice;

    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void deregisterObserver(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(stockName, stockPrice);
        }
    }

    public void setStock(String stockName, double stockPrice) {
        this.stockName = stockName;
        this.stockPrice = stockPrice;

        System.out.println("\nStock Updated");
        System.out.println("Stock : " + stockName);
        System.out.println("Price : ₹" + stockPrice);

        notifyObservers();
    }
}

class MobileApp implements Observer {

    @Override
    public void update(String stockName, double stockPrice) {
        System.out.println("Mobile App Notification -> " + stockName + " : ₹" + stockPrice);
    }
}

class WebApp implements Observer {

    @Override
    public void update(String stockName, double stockPrice) {
        System.out.println("Web App Notification -> " + stockName + " : ₹" + stockPrice);
    }
}

public class Implementing_the_Observer_Pattern {

    public static void main(String[] args) {

        StockMarket stockMarket = new StockMarket();

        Observer mobileApp = new MobileApp();
        Observer webApp = new WebApp();

        stockMarket.registerObserver(mobileApp);
        stockMarket.registerObserver(webApp);

        stockMarket.setStock("TCS", 4250.50);

        stockMarket.setStock("Infosys", 1680.75);

        stockMarket.deregisterObserver(webApp);

        System.out.println("\nWeb App Unregistered");

        stockMarket.setStock("Reliance", 2985.20);
    }
}