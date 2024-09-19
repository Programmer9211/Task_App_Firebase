import 'package:task_app/const/app_const/app_keys.dart';
import 'package:uuid/uuid.dart';

class TaskModel {
  late String id;
  late String title;
  late String description;
  late bool isCompleted;
  late int createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json[AppKeys.id];
    title = json[AppKeys.title];
    description = json[AppKeys.description];
    isCompleted = json[AppKeys.isCompleted];
    createdAt = json[AppKeys.createdAt];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[AppKeys.id] = this.id;
    data[AppKeys.title] = this.title;
    data[AppKeys.description] = this.description;
    data[AppKeys.isCompleted] = this.isCompleted;
    data[AppKeys.createdAt] = DateTime.now().millisecondsSinceEpoch;
    return data;
  }
}
