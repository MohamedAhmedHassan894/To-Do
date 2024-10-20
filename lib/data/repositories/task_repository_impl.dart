import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/task.dart';
import '../models/task_model.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SharedPreferences sharedPreferences;

  TaskRepositoryImpl({required this.sharedPreferences});

  @override
  Future<void> addTask(Task task) async {
    /// Convert Task entity to TaskModel
    final taskModel = TaskModel(
      title: task.title,
      isCompleted: task.isCompleted,
    );

    /// Now you can add taskModel instead of task
    final tasksList = await getTasks();
    tasksList.add(taskModel);

    await sharedPreferences.setString(
      'tasks',
      TaskModel.encode(tasksList),
    );
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final tasksString = sharedPreferences.getString('tasks');
    if (tasksString != null) {
      return TaskModel.decode(tasksString);
    }
    return [];
  }


  @override
  Future<void> updateTask(Task task) async {
    final tasksList = await getTasks();
    final index = tasksList.indexWhere((element) => element.title == task.title);
    if (index != -1) {
      tasksList[index] = TaskModel(
        title: task.title,
        isCompleted: task.isCompleted,
      );
      await sharedPreferences.setString(
        'tasks',
        TaskModel.encode(tasksList),
      );
    }
  }
}
