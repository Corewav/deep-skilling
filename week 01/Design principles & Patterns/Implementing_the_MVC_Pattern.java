class Student {
    private int id;
    private String name;
    private String grade;

    Student(int id, String name, String grade) {
        this.id = id;
        this.name = name;
        this.grade = grade;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}

class StudentView {

    public void displayStudentDetails(int id, String name, String grade) {
        System.out.println("Student Details");
        System.out.println("Student ID : " + id);
        System.out.println("Student Name : " + name);
        System.out.println("Student Grade : " + grade);
        System.out.println("----------------------------");
    }
}

class StudentController {

    private Student student;
    private StudentView studentView;

    StudentController(Student student, StudentView studentView) {
        this.student = student;
        this.studentView = studentView;
    }

    public void setStudentName(String name) {
        student.setName(name);
    }

    public String getStudentName() {
        return student.getName();
    }

    public void setStudentId(int id) {
        student.setId(id);
    }

    public int getStudentId() {
        return student.getId();
    }

    public void setStudentGrade(String grade) {
        student.setGrade(grade);
    }

    public String getStudentGrade() {
        return student.getGrade();
    }

    public void updateView() {
        studentView.displayStudentDetails(
                student.getId(),
                student.getName(),
                student.getGrade()
        );
    }
}

public class Implementing_the_MVC_Pattern {

    public static void main(String[] args) {

        Student student = new Student(101, "Mihir", "A");

        StudentView studentView = new StudentView();

        StudentController studentController =
                new StudentController(student, studentView);

        System.out.println("===== Initial Student Record =====");
        studentController.updateView();

        studentController.setStudentName("Mihir Bansal");
        studentController.setStudentGrade("A+");

        System.out.println("===== Updated Student Record =====");
        studentController.updateView();
    }
}