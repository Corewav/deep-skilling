interface Command {
    void execute();
}

class Light {

    public void turnOn() {
        System.out.println("Light is ON.");
    }

    public void turnOff() {
        System.out.println("Light is OFF.");
    }
}

class LightOnCommand implements Command {

    private Light light;

    LightOnCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOn();
    }
}

class LightOffCommand implements Command {

    private Light light;

    LightOffCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOff();
    }
}

class RemoteControl {

    private Command command;

    public void setCommand(Command command) {
        this.command = command;
    }

    public void pressButton() {

        if (command != null) {
            command.execute();
        } else {
            System.out.println("No command assigned.");
        }
    }
}

public class Implementing_the_Command_Pattern {

    public static void main(String[] args) {

        Light light = new Light();

        Command lightOn = new LightOnCommand(light);
        Command lightOff = new LightOffCommand(light);

        RemoteControl remote = new RemoteControl();

        System.out.println("Pressing ON Button");
        remote.setCommand(lightOn);
        remote.pressButton();

        System.out.println();

        System.out.println("Pressing OFF Button");
        remote.setCommand(lightOff);
        remote.pressButton();
    }
}