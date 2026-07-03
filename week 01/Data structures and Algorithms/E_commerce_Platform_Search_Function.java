class Product {
    int productId;
    String productName;
    String category;

    Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    public void displayProduct() {
        System.out.println("Product ID : " + productId);
        System.out.println("Product Name : " + productName);
        System.out.println("Category : " + category);
        System.out.println("----------------------------");
    }
}

class SearchService {

    public Product linearSearch(Product[] products, int targetId) {
        for (Product product : products) {
            if (product.productId == targetId) {
                return product;
            }
        }
        return null;
    }

    public Product binarySearch(Product[] products, int targetId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (products[mid].productId == targetId) {
                return products[mid];
            } else if (products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return null;
    }
}

public class E_commerce_Platform_Search_Function {

    public static void main(String[] args) {

        Product[] products = {
                new Product(101, "Laptop", "Electronics"),
                new Product(102, "Keyboard", "Electronics"),
                new Product(103, "Mouse", "Electronics"),
                new Product(104, "Shoes", "Fashion"),
                new Product(105, "Watch", "Accessories"),
                new Product(106, "Book", "Education"),
                new Product(107, "Phone", "Electronics")
        };

        SearchService searchService = new SearchService();

        int targetId = 105;

        System.out.println("===== Linear Search =====");

        Product linearResult = searchService.linearSearch(products, targetId);

        if (linearResult != null) {
            linearResult.displayProduct();
        } else {
            System.out.println("Product not found.");
        }

        System.out.println();

        System.out.println("===== Binary Search =====");

        Product binaryResult = searchService.binarySearch(products, targetId);

        if (binaryResult != null) {
            binaryResult.displayProduct();
        } else {
            System.out.println("Product not found.");
        }
    }
}
