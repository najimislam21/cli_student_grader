import 'dart:io';

// App Setup
const String appTitle = "Student Grader v1.0";
final Set<String> availableSubjects = {"Math", "English", "Science", "ICT"};

// Add Student
void main() {
  var students = <Map<String, dynamic>>[];
  var running = true;

  do {
    print("""
===== $appTitle =====

1. Add Student


Choose an option:
""");

var choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        addStudent(students);
        break;

      case "2":
        running = false;
        print("Exiting...");
        break;

      default:
        print("Invalid option");
    }
  } while (running);
}
//3. Add Student Function
void addStudent(List<Map<String, dynamic>> students) {
  stdout.write("Enter student name: ");
  String? name = stdin.readLineSync();

  if (name == null || name.isEmpty) {
    print("Name cannot be empty!");
    return;
  }

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects},
    "bonus": null,
    "comment": null,
  };
  students.add(student);

  print("Student '$name' added successfully!");
 
}



