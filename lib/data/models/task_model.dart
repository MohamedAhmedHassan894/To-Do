import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/task.dart';
part 'task_model.g.dart'; // Generated file

@JsonSerializable()
class TaskModel extends Task {
  TaskModel({
    required String title,
    bool isCompleted = false,
  }) : super(
    title: title,
    isCompleted: isCompleted,
  );

  // Factory constructor to generate a TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  // Method to convert TaskModel to JSON
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  // Static methods for encoding/decoding a list of TaskModels
  static String encode(List<TaskModel> tasks) {
    return json.encode(
      tasks.map((task) => task.toJson()).toList(),
    );
  }

  static List<TaskModel> decode(String tasks) {
    if (tasks.isEmpty) return []; // Handle empty string case
    return (json.decode(tasks) as List<dynamic>)
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

}
