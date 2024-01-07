import 'package:flutter/material.dart';

class Task {
  String title;
  DateTime dueDate;

  Task({required this.title, required this.dueDate});
}

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [
    Task(title: 'Task 1', dueDate: DateTime.parse('2023-12-22')),
    Task(title: 'Task 2', dueDate: DateTime.parse('2023-12-23')),
  ]; // List of Task objects

  // Function to add task
  void addTask(Task task) {
    tasks.add(task);
    notifyListeners(); // Notify listeners of the change
  }

  // Function to delete task by index
  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners(); // Notify listeners of the change
  }
}
