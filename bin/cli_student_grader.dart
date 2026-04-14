import 'dart:io';

// App Setup
const String appTitle = "Student Grader v1.0";
final Set<String> availableSubjects = {"Math", "English", "Science", "ICT"};

// Add Student
void addStudent(List<Map<String, dynamic>> students) {
  stdout.write("Enter name: ");
  var name = stdin.readLineSync();

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects},
    "bonus": null,
    "comment": null,
  };

  students.add(student);
  print("Student $name added!");
}

void main() {
  print(appTitle);
  print(availableSubjects);

  var students = <Map<String, dynamic>>[];

  addStudent(students); // call function

  print(students);
}
