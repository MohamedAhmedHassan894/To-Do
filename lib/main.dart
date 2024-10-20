import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'injection_container.dart' as di;
import 'presentation/controllers/task_controller.dart';
import 'presentation/screens/ToDo_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  /// Initialize GetIt and inject dependencies
  await di.init();

  /// Inject TaskController using Get.put or Get.lazyPut
  Get.put(TaskController(
    getTasks: GetIt.instance(),
    addTask: GetIt.instance(),
    toggleTaskCompletion: GetIt.instance(),
  ));

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoHomePage(), // Initial page
    );
  }
}
