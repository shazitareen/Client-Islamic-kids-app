// lib/widgets/task_tile.dart
import 'package:flutter/material.dart';
import '../models/daily_task.dart';
import '../app_theme.dart';

/// A heavily rounded, beautifully styled tile for a Daily Islamic task.
class TaskTile extends StatefulWidget {
  final DailyTask task;
  final bool isCompleted;
  final VoidCallback onToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onToggle();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.isCompleted
                ? AppTheme.correctGreen.withAlpha(200)
                : Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: widget.isCompleted ? AppTheme.correctGreen : Colors.black12,
              width: 3,
            ),
            boxShadow: [
              if (!widget.isCompleted)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              // Massive Emoji Background/Circle
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: widget.isCompleted ? Colors.white.withAlpha(50) : AppTheme.bgCream,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(widget.task.emoji, style: const TextStyle(fontSize: 40)),
                ),
              ),
              const SizedBox(width: 20),
              
              // Text Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: widget.isCompleted ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.task.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: widget.isCompleted ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Massive Checkbox
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.isCompleted ? Colors.white : Colors.grey.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.isCompleted ? Colors.transparent : Colors.grey.shade300, width: 2),
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: widget.isCompleted ? AppTheme.correctGreen : Colors.transparent,
                  size: 36,
                  weight: 900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
