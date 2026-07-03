interface Image {
    void display();
}

class RealImage implements Image {

    private String fileName;

    RealImage(String fileName) {
        this.fileName = fileName;
        loadImageFromRemoteServer();
    }

    private void loadImageFromRemoteServer() {
        System.out.println("Loading image from remote server : " + fileName);
    }

    @Override
    public void display() {
        System.out.println("Displaying image : " + fileName);
    }
}

class ProxyImage implements Image {

    private String fileName;
    private RealImage realImage;

    ProxyImage(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void display() {

        if (realImage == null) {
            realImage = new RealImage(fileName);
        } else {
            System.out.println("Image loaded from cache : " + fileName);
        }

        realImage.display();
    }
}

public class Implementing_the_Proxy_Pattern {

    public static void main(String[] args) {

        Image image = new ProxyImage("product_image_101.jpg");

        System.out.println("First call:");
        image.display();

        System.out.println();

        System.out.println("Second call:");
        image.display();

        System.out.println();

        System.out.println("Third call:");
        image.display();
    }
}