import 'package:hive/hive.dart';

import '../models/task.dart';

class TaskRepository {
  final Box<Task> _tasksBox = Hive.box<Task>('tasks');

  Future<void> addTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  Future<List<Task>> getTasks(String userId) async {
    return _tasksBox.values.where((task) => task.userId == userId).toList();
  }
}
