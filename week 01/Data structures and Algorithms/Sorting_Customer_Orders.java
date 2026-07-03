class Order {
    int orderId;
    String customerName;
    double totalPrice;

    Order(int orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    public void displayOrder() {
        System.out.println("Order ID : " + orderId);
        System.out.println("Customer Name : " + customerName);
        System.out.println("Total Price : ₹" + totalPrice);
        System.out.println("----------------------------");
    }
}

class SortService {

    public void bubbleSort(Order[] orders) {
        int n = orders.length;

        for (int i = 0; i < n - 1; i++) {
            boolean swapped = false;

            for (int j = 0; j < n - i - 1; j++) {

                if (orders[j].totalPrice > orders[j + 1].totalPrice) {

                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;

                    swapped = true;
                }
            }

            if (!swapped) {
                break;
            }
        }
    }

    public void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(orders, low, high);

            quickSort(orders, low, pivotIndex - 1);
            quickSort(orders, pivotIndex + 1, high);
        }
    }

    private int partition(Order[] orders, int low, int high) {

        double pivot = orders[high].totalPrice;
        int i = low - 1;

        for (int j = low; j < high; j++) {

            if (orders[j].totalPrice < pivot) {

                i++;

                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }
}

public class Sorting_Customer_Orders {

    public static void main(String[] args) {

        Order[] bubbleOrders = {
                new Order(101, "Mihir", 5500),
                new Order(102, "Aman", 2200),
                new Order(103, "Rahul", 8900),
                new Order(104, "Priya", 4100),
                new Order(105, "Neha", 7600)
        };

        Order[] quickOrders = {
                new Order(101, "Mihir", 5500),
                new Order(102, "Aman", 2200),
                new Order(103, "Rahul", 8900),
                new Order(104, "Priya", 4100),
                new Order(105, "Neha", 7600)
        };

        SortService sortService = new SortService();

        System.out.println("===== Bubble Sort =====");

        sortService.bubbleSort(bubbleOrders);

        for (Order order : bubbleOrders) {
            order.displayOrder();
        }

        System.out.println();

        System.out.println("===== Quick Sort =====");

        sortService.quickSort(quickOrders, 0, quickOrders.length - 1);

        for (Order order : quickOrders) {
            order.displayOrder();
        }
    }
}