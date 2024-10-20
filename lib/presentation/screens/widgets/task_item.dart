import 'package:flutter/material.dart';
import 'package:to_do/domain/entities/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onLongPress;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          onToggle();
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
