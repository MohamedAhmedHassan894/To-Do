import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/data/models/task_model.dart';
import 'package:to_do/data/repositories/task_repository_impl.dart';

void main() {
  late TaskRepositoryImpl taskRepository;

  setUp(() async {
    // Mock SharedPreferences with initial values
    SharedPreferences.setMockInitialValues({});

    // Initialize TaskRepositoryImpl with the awaited SharedPreferences instance
    final sharedPreferences = await SharedPreferences.getInstance();
    taskRepository = TaskRepositoryImpl(sharedPreferences: sharedPreferences);
  });

  group('TaskRepositoryImpl', () {
    test('should add a task and retrieve it', () async {
      final task = TaskModel(title: 'Test Task');

      await taskRepository.addTask(task);
      final tasks = await taskRepository.getTasks();

      // Then
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Test Task');
      expect(tasks.first.isCompleted, false);
    });

    test('should mark a task as completed', () async {
      /// Add the task first before marking it as completed
      final task = TaskModel(title: 'Test Task');
      await taskRepository.addTask(task);

      /// Verify that the task is initially not completed
      var tasks = await taskRepository.getTasks();
      expect(tasks.length, 1);
      expect(tasks.first.isCompleted, false);

      // When: Now mark the task as completed
      task.isCompleted = true;
      await taskRepository.updateTask(task);

      // Then: Retrieve the tasks again and verify the task is completed
      tasks = await taskRepository.getTasks();
      expect(tasks.length, 1);
      expect(tasks.first.isCompleted, true);
    });


    test('should retrieve an empty list if no tasks exist', () async {
      // When
      final tasks = await taskRepository.getTasks();

      // Then
      expect(tasks, isEmpty);
    });
  });
}
