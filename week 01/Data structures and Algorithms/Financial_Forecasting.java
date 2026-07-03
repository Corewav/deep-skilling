class ForecastService {

    public double calculateFutureValue(double currentValue, double growthRate, int years) {

        if (years == 0) {
            return currentValue;
        }

        return calculateFutureValue(currentValue, growthRate, years - 1) * (1 + growthRate);
    }
}

public class Financial_Forecasting {

    public static void main(String[] args) {

        ForecastService forecastService = new ForecastService();

        double currentValue = 10000;
        double growthRate = 0.08;
        int years = 5;

        double futureValue = forecastService.calculateFutureValue(currentValue, growthRate, years);

        System.out.println("Current Value : " + currentValue);
        System.out.println("Growth Rate : " + (growthRate * 100) + "%");
        System.out.println("Years : " + years);
        System.out.println("Predicted Future Value : " + futureValue);
    }
}