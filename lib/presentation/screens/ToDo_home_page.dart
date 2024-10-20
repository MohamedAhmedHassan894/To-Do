import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/domain/entities/task.dart';
import 'package:to_do/presentation/screens/widgets/task_item.dart';
import '../controllers/task_controller.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();
  final TaskController taskController = Get.find<TaskController>();

  TodoHomePage({super.key}); // Inject TaskController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Task Input Field and Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      taskController.addNewTask(_taskController.text);
                      _taskController.clear(); // Clear input after adding task
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),

          // Task List Display
          Expanded(
            child: Obx(() {
              if (taskController.tasks.isEmpty) {
                return const Center(
                  child: Text(
                    'No Tasks Available!',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return TaskItem(
                      task: task,
                      onToggle: () => taskController.toggleTask(task),
                      onLongPress: () => _showEditTaskDialog(context, task),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  // Edit Task Dialog
  void _showEditTaskDialog(BuildContext context, Task task) {
    TextEditingController editController = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              labelText: 'Edit Task Title',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  // taskController.editTask(task, editController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
