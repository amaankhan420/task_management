import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/task.dart';
import 'repositories/task_repository.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => TaskRepository()),
      ],
      child: MaterialApp(
        title: 'Task Management',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {'/login': (context) => LoginScreen()},
        home: Consumer<AuthService>(
          builder: (context, auth, _) {
            return auth.currentUser != null ? DashboardScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}
