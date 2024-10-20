import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ToggleTaskCompletion {
  final TaskRepository repository;

  ToggleTaskCompletion(this.repository);

  Future<void> call(Task task) async {
    /// Toggle the completion status
    final updatedTask = Task(title: task.title, isCompleted: !task.isCompleted);

    await repository.updateTask(updatedTask);
  }
}
