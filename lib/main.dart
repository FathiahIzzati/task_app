import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_screen.dart';
import 'task_provider.dart'; // Import the TaskProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const ABCUniTasksApp(),
    ),
  );
}

class ABCUniTasksApp extends StatelessWidget {
  const ABCUniTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCUniTasks',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: DashboardScreen(),
    );
  }
}
