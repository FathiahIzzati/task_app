import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/dashboard_screen.dart';
import 'task_provider.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TasksScreen> {
  TextEditingController _taskController = TextEditingController();
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'ABCUniTasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Tasks'),
              leading: Icon(Icons.note),
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => TasksScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(taskProvider.tasks[index].title),
                subtitle: Text(
                  'Due Date: ${taskProvider.tasks[index].dueDate.toString().split(' ')[0]}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      taskProvider.deleteTask(index);
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTaskDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _taskController,
                decoration: InputDecoration(hintText: 'Enter task'),
              ),
              SizedBox(height: 16),
              ListTile(
                title:
                    Text('Due Date: ${selectedDate.toString().split(' ')[0]}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).addTask(Task(
                  title: _taskController.text,
                  dueDate: selectedDate!,
                ));
                Navigator.of(context).pop();
                _taskController.clear();
                setState(() {
                  selectedDate = DateTime.now();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
