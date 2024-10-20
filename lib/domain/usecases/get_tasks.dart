import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../../core/usecase.dart';

class GetTasks implements UseCase<List<Task>, NoParams> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<List<Task>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
