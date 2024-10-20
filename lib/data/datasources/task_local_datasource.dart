import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getCachedTasks();
  Future<void> cacheTasks(List<TaskModel> tasks);
}

const cachedTasks = 'CACHED_TASKS';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TaskModel>> getCachedTasks() {
    final jsonString = sharedPreferences.getString(cachedTasks);
    if (jsonString != null) {
      final List decodedJson = json.decode(jsonString);
      return Future.value(decodedJson.map((json) => TaskModel.fromJson(json)).toList());
    }
    return Future.value([]);
  }

  @override
  Future<void> cacheTasks(List<TaskModel> tasks) {
    final List taskListJson = tasks.map((task) => task.toJson()).toList();
    return sharedPreferences.setString(cachedTasks, json.encode(taskListJson));
  }
}
