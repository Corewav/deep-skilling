class Computer {

    private String cpu;
    private String ram;
    private String storage;
    private String graphicsCard;
    private String operatingSystem;

    private Computer(Builder builder) {
        this.cpu = builder.cpu;
        this.ram = builder.ram;
        this.storage = builder.storage;
        this.graphicsCard = builder.graphicsCard;
        this.operatingSystem = builder.operatingSystem;
    }

    public void displayConfiguration() {
        System.out.println("CPU : " + cpu);
        System.out.println("RAM : " + ram);
        System.out.println("Storage : " + storage);
        System.out.println("Graphics Card : " + graphicsCard);
        System.out.println("Operating System : " + operatingSystem);
        System.out.println("--------------------------------");
    }

    static class Builder {

        private String cpu;
        private String ram;
        private String storage;
        private String graphicsCard;
        private String operatingSystem;

        public Builder setCPU(String cpu) {
            this.cpu = cpu;
            return this;
        }

        public Builder setRAM(String ram) {
            this.ram = ram;
            return this;
        }

        public Builder setStorage(String storage) {
            this.storage = storage;
            return this;
        }

        public Builder setGraphicsCard(String graphicsCard) {
            this.graphicsCard = graphicsCard;
            return this;
        }

        public Builder setOperatingSystem(String operatingSystem) {
            this.operatingSystem = operatingSystem;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }
}

public class Implementing_the_Builder_Pattern {

    public static void main(String[] args) {

        Computer gamingComputer = new Computer.Builder()
                .setCPU("Intel Core i9")
                .setRAM("32 GB")
                .setStorage("1 TB SSD")
                .setGraphicsCard("NVIDIA RTX 4090")
                .setOperatingSystem("Windows 11")
                .build();

        Computer officeComputer = new Computer.Builder()
                .setCPU("Intel Core i5")
                .setRAM("16 GB")
                .setStorage("512 GB SSD")
                .setOperatingSystem("Windows 11")
                .build();

        System.out.println("===== Gaming Computer =====");
        gamingComputer.displayConfiguration();

        System.out.println("===== Office Computer =====");
        officeComputer.displayConfiguration();
    }
}