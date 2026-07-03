class Employee {
    int employeeId;
    String name;
    String position;
    double salary;

    Employee(int employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }

    public void displayEmployee() {
        System.out.println("Employee ID : " + employeeId);
        System.out.println("Name : " + name);
        System.out.println("Position : " + position);
        System.out.println("Salary : ₹" + salary);
        System.out.println("----------------------------");
    }
}

class EmployeeService {

    Employee[] employees;
    int size;

    EmployeeService(int capacity) {
        employees = new Employee[capacity];
        size = 0;
    }

    public void addEmployee(Employee employee) {

        if (size == employees.length) {
            System.out.println("Employee array is full.");
            return;
        }

        employees[size] = employee;
        size++;

        System.out.println("Employee added successfully.");
    }

    public Employee searchEmployee(int employeeId) {

        for (int i = 0; i < size; i++) {

            if (employees[i].employeeId == employeeId) {
                return employees[i];
            }
        }

        return null;
    }

    public void traverseEmployees() {

        if (size == 0) {
            System.out.println("No employee records found.");
            return;
        }

        for (int i = 0; i < size; i++) {
            employees[i].displayEmployee();
        }
    }

    public void deleteEmployee(int employeeId) {

        int index = -1;

        for (int i = 0; i < size; i++) {

            if (employees[i].employeeId == employeeId) {
                index = i;
                break;
            }
        }

        if (index == -1) {
            System.out.println("Employee not found.");
            return;
        }

        for (int i = index; i < size - 1; i++) {
            employees[i] = employees[i + 1];
        }

        employees[size - 1] = null;
        size--;

        System.out.println("Employee deleted successfully.");
    }
}

public class Employee_Management_System {

    public static void main(String[] args) {

        EmployeeService employeeService = new EmployeeService(5);

        employeeService.addEmployee(new Employee(101, "Mihir", "Software Engineer", 65000));
        employeeService.addEmployee(new Employee(102, "Aman", "Backend Developer", 72000));
        employeeService.addEmployee(new Employee(103, "Priya", "UI Designer", 58000));
        employeeService.addEmployee(new Employee(104, "Rahul", "QA Engineer", 55000));

        System.out.println("\n===== Employee Records =====");
        employeeService.traverseEmployees();

        System.out.println("\n===== Search Employee =====");

        Employee employee = employeeService.searchEmployee(103);

        if (employee != null) {
            employee.displayEmployee();
        } else {
            System.out.println("Employee not found.");
        }

        System.out.println("\n===== Delete Employee =====");

        employeeService.deleteEmployee(102);

        System.out.println("\n===== Employee Records After Deletion =====");
        employeeService.traverseEmployees();
    }
}