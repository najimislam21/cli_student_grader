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
          recordScore(students);
          break;
        case "3":
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
  // 2. Record Score
  void recordScore(List<Map<String, dynamic>> students) {
    if (students.isEmpty) {
      print("No students available!");
      return;
    }

    for (int i = 0; i < students.length; i++) {
      print("$i. ${students[i]["name"]}");
    }

    stdout.write("Select student index: ");
    int index = int.parse(stdin.readLineSync()!);

    stdout.write("Enter score (0-100): ");
    int score = int.parse(stdin.readLineSync()!);

    while (score < 0 || score > 100) {
      stdout.write("Invalid! Enter again: ");
      score = int.parse(stdin.readLineSync()!);
    }

    (students[index]["scores"] as List<int>).add(score);

    print("Score added successfully!");
  }
  

