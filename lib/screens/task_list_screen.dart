import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../services/auth_service.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future
    _tasksFuture = _fetchTasks();
  }

  Future<List<Task>> _fetchTasks() {
    final taskRepo = Provider.of<TaskRepository>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    return taskRepo.getTasks(authService.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final taskRepo = Provider.of<TaskRepository>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Your Tasks',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
        elevation: 0,
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          if (snapshot.hasData) {
            final tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inbox, size: 72, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'No tasks available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create a task to get started!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final isOverdue = task.dueDate.isBefore(DateTime.now());

                Color getStatusColor(String status) {
                  switch (status) {
                    case 'Completed':
                      return Colors.green;
                    case 'In Progress':
                      return Colors.blue;
                    case 'To Do':
                    default:
                      return Colors.grey;
                  }
                }

                Color getPriorityColor(String priority) {
                  switch (priority) {
                    case 'High':
                      return Colors.red;
                    case 'Medium':
                      return Colors.orange;
                    case 'Low':
                    default:
                      return Colors.green;
                  }
                }

                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskFormScreen(task: task),
                      ),
                    );
                    if (result == true) {
                      // Refresh tasks after editing
                      setState(() {
                        _tasksFuture = _fetchTasks();
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isOverdue ? Colors.red.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(
                                  task.status,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                task.status,
                                style: TextStyle(
                                  color: getStatusColor(task.status),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          task.description.isEmpty
                              ? 'No description'
                              : task.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 16,
                                  color: getPriorityColor(task.priority),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.priority,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.blue.shade600,
                                ),
                                const SizedBox(width: 4),
                                Row(
                                  children: [
                                    Text(
                                      '${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            isOverdue
                                                ? Colors.red.shade400
                                                : Colors.grey.shade700,
                                        fontWeight:
                                            isOverdue
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                    if (isOverdue) ...[
                                      const SizedBox(width: 6),
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        size: 16,
                                        color: Colors.red.shade400,
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: Text(
              'Error loading tasks',
              style: TextStyle(color: Colors.red.shade400),
            ),
          );
        },
      ),
    );
  }
}
