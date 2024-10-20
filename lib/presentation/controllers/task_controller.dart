import 'package:get/get.dart';
import 'package:to_do/core/usecase.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/toggle_task_completion.dart';

class TaskController extends GetxController {
  final GetTasks getTasks;
  final AddTask addTask;
  final ToggleTaskCompletion toggleTaskCompletion;

  var tasks = <Task>[].obs;

  TaskController({
    required this.getTasks,
    required this.addTask,
    required this.toggleTaskCompletion,
  });

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    final fetchedTasks = await getTasks(NoParams());
    tasks.assignAll(fetchedTasks);
  }

  void addNewTask(String title) {
    final task = Task(title: title);
    addTask(task);
    tasks.add(task);
  }

  void toggleTask(Task task) {
    toggleTaskCompletion(task);
    task.isCompleted = !task.isCompleted;
    tasks.refresh();
  }

}
