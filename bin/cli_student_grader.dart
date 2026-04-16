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
2. Record Score
3. Add Bonus Points
4. Add Comment
5. View All Students
6. View Report Card
7. Class Summary
8. Exit

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
        addBonus(students);
        break;
      case "4":
        addComment(students);
        break;
      case "5":
        viewStudents(students);
        break;
      case "6":
        reportCard(students);
        break;
      case "7":
        classSummary(students);
        break;
      case "8":
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

  if (index < 0 || index >= students.length) {
    print("Invalid index!");
    return;
  }

  print("Available subjects:");
  for (var sub in students[index]["subjects"]) {
    print("- $sub");
  }

  stdout.write("Enter score (0-100): ");
  int score = int.parse(stdin.readLineSync()!);

  while (score < 0 || score > 100) {
    stdout.write("Invalid! Enter again: ");
    score = int.parse(stdin.readLineSync()!);
  }

  (students[index]["scores"] as List<int>).add(score);

  print("Score added successfully!");
}

// 5. Bonus
void addBonus(List<Map<String, dynamic>> students) {
  stdout.write("Select student index: ");
  int i = int.parse(stdin.readLineSync()!);

  stdout.write("Enter bonus (1-10): ");
  int bonus = int.parse(stdin.readLineSync()!);

  if (students[i]["bonus"] == null) {
    students[i]["bonus"] ??= bonus;
    print("Bonus added!");
  } else {
    print("Bonus already exists!");
  }
}

// 6. Comment
void addComment(List<Map<String, dynamic>> students) {
  stdout.write("Select student index: ");
  int i = int.parse(stdin.readLineSync()!);

  stdout.write("Enter comment: ");
  students[i]["comment"] = stdin.readLineSync();
}

// 7. View Student
void viewStudents(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students found!");
    return;
  }

  for (var s in students) {
    var tags = [
      s["name"],
      "${(s["scores"] as List).length} scores",
      if (s["bonus"] != null) "Bonus",
    ];

    print(tags.join(" | "));
  }
}

// 8. View Report Card
void reportCard(List<Map<String, dynamic>> students) {
  stdout.write("Select student index: ");
  int i = int.parse(stdin.readLineSync()!);

  if (i < 0 || i >= students.length) {
    print("Invalid index!");
    return;
  }

  var s = students[i];
  List<int> scores = List<int>.from(s["scores"]);

  if (scores.isEmpty) {
    print("No scores available!");
    return;
  }

  int sum = 0;
  for (var sc in scores) {
    sum += sc;
  }

  double avg = sum / scores.length;
  double finalAvg = avg + (s["bonus"] ?? 0);
  if (finalAvg > 100) finalAvg = 100;

  String grade;
  if (finalAvg >= 90) {
    grade = "A";
  } else if (finalAvg >= 80) {
    grade = "B";
  } else if (finalAvg >= 70) {
    grade = "C";
  } else if (finalAvg >= 60) {
    grade = "D";
  } else {
    grade = "F";
  }

  String feedback = switch (grade) {
    "A" => "Outstanding!",
    "B" => "Good work!",
    "C" => "Improve more",
    "D" => "Needs work",
    "F" => "Failing",
    _ => "Unknown",
  };

  String comment = s["comment"]?.toUpperCase() ?? "No comment provided";

  print("""
╔══════════════════════════════╗
║       REPORT CARD            ║
╠══════════════════════════════╝
║ Name: ${s["name"]}
║ Scores: $scores
║ Bonus: ${s["bonus"] != null ? "+${s["bonus"]}" : "None"}
║ Average: ${finalAvg.toStringAsFixed(2)}
║ Grade: $grade
║ Comment: $comment
║ Feedback: $feedback
╚══════════════════════════════╝
""");
}

//  9. Class Summary
void classSummary(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available");
    return;
  }

  double total = 0;
  int count = 0;
  double highest = 0;
  double lowest = double.infinity;

  var grades = <String>{};
  int passCount = 0;

  for (var s in students) {
    List<int> scores = List<int>.from(s["scores"]);

    if (scores.isEmpty) continue;

    int sum = scores.reduce((a, b) => a + b);
    double avg = sum / scores.length;
    avg += (s["bonus"] ?? 0);

    if (avg > 100) avg = 100;

    total += avg;
    count++;

    if (avg > highest) highest = avg;
    if (avg < lowest) lowest = avg;

    if (scores.isNotEmpty && avg >= 60) {
      passCount++;
    }

    if (avg >= 90)
      grades.add("A");
    else if (avg >= 80)
      grades.add("B");
    else if (avg >= 70)
      grades.add("C");
    else if (avg >= 60)
      grades.add("D");
    else
      grades.add("F");
  }

  if (count == 0) {
    print("No valid scores found");
    return;
  }

  var summaryLines = [
    for (var s in students)
      "${s["name"]}: ${(s["scores"] as List).length} scores",
  ];

  print("\nStudent Summary:");
  for (var line in summaryLines) {
    print(line);
  }

  print("Total Students: ${students.length}");
  print("Students with scores: $count");
  print("Class Average: ${total / count}");
  print("Highest: $highest");
  print("Lowest: $lowest");
  print("Pass Count: $passCount");
  print("Grades: $grades");
}
