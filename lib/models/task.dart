import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String priority;
  @HiveField(4)
  final DateTime dueDate;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.status,
    required this.userId,
  });

  factory Task.fromMap(Map<String, dynamic> data, String id) => Task(
    id: id,
    title: data['title'],
    description: data['description'],
    priority: data['priority'],
    dueDate: (data['dueDate'] as Timestamp).toDate(),
    status: data['status'],
    userId: data['userId'],
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'priority': priority,
    'dueDate': Timestamp.fromDate(dueDate),
    'status': status,
    'userId': userId,
  };
}
