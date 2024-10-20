import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/domain/usecases/toggle_task_completion.dart';
import 'data/datasources/task_local_datasource.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/repositories/task_repository.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/get_tasks.dart';
import 'presentation/controllers/task_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => ToggleTaskCompletion(sl()));

  sl.registerFactory(() => TaskController(getTasks: sl(), addTask: sl(), toggleTaskCompletion: sl()));
}
