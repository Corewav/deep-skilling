class Task {
    int taskId;
    String taskName;
    String status;
    Task next;

    Task(int taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
        this.next = null;
    }

    public void displayTask() {
        System.out.println("Task ID : " + taskId);
        System.out.println("Task Name : " + taskName);
        System.out.println("Status : " + status);
        System.out.println("----------------------------");
    }
}

class TaskService {

    Task head = null;

    public void addTask(int taskId, String taskName, String status) {

        Task newTask = new Task(taskId, taskName, status);

        if (head == null) {
            head = newTask;
        } else {

            Task current = head;

            while (current.next != null) {
                current = current.next;
            }

            current.next = newTask;
        }

        System.out.println("Task added successfully.");
    }

    public Task searchTask(int taskId) {

        Task current = head;

        while (current != null) {

            if (current.taskId == taskId) {
                return current;
            }

            current = current.next;
        }

        return null;
    }

    public void traverseTasks() {

        if (head == null) {
            System.out.println("No tasks available.");
            return;
        }

        Task current = head;

        while (current != null) {
            current.displayTask();
            current = current.next;
        }
    }

    public void deleteTask(int taskId) {

        if (head == null) {
            System.out.println("Task list is empty.");
            return;
        }

        if (head.taskId == taskId) {
            head = head.next;
            System.out.println("Task deleted successfully.");
            return;
        }

        Task current = head;

        while (current.next != null && current.next.taskId != taskId) {
            current = current.next;
        }

        if (current.next == null) {
            System.out.println("Task not found.");
        } else {
            current.next = current.next.next;
            System.out.println("Task deleted successfully.");
        }
    }
}

public class Task_Management_System {

    public static void main(String[] args) {

        TaskService taskService = new TaskService();

        taskService.addTask(101, "Design Database", "Pending");
        taskService.addTask(102, "Develop Login Module", "In Progress");
        taskService.addTask(103, "Test Application", "Pending");
        taskService.addTask(104, "Deploy Project", "Completed");

        System.out.println("\n===== Task List =====");
        taskService.traverseTasks();

        System.out.println("\n===== Search Task =====");

        Task task = taskService.searchTask(103);

        if (task != null) {
            task.displayTask();
        } else {
            System.out.println("Task not found.");
        }

        System.out.println("\n===== Delete Task =====");

        taskService.deleteTask(102);

        System.out.println("\n===== Task List After Deletion =====");
        taskService.traverseTasks();
    }
}