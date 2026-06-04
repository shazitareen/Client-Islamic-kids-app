// lib/screens/daily_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_tile.dart';

/// The 'Daily Tasks' screen showing 3 simple habits for the day.
class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key});

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TasksProvider>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Daily Tasks'),
            backgroundColor: AppTheme.softPurple,
          ),
          body: !provider.isLoaded
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF3E5F5), AppTheme.bgCream],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            const Text(
                              'Complete 3 simple habits today!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ...provider.todaysTasks.map((task) {
                              return TaskTile(
                                task: task,
                                isCompleted: provider.isTaskCompleted(task.id),
                                onToggle: () => provider.toggleTask(task.id),
                              );
                            }),
                            const SizedBox(height: 32),
                            if (provider.areAllTasksCompleted)
                              const Column(
                                children: [
                                  Text(
                                    '🌟 MashaAllah! 🌟',
                                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.correctGreen),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'You completed all tasks today!',
                                    style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
