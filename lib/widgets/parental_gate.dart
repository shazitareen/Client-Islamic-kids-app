// lib/widgets/parental_gate.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../app_theme.dart';

/// A secure verification gate that asks the user to solve a simple math puzzle
/// to verify they are a parent.
class ParentalGate extends StatefulWidget {
  final VoidCallback onPassed;

  const ParentalGate({super.key, required this.onPassed});

  /// Displays the Parental Gate dialog.
  static void show(BuildContext context, VoidCallback onPassed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ParentalGate(onPassed: onPassed),
    );
  }

  @override
  State<ParentalGate> createState() => _ParentalGateState();
}

class _ParentalGateState extends State<ParentalGate> {
  late int _num1;
  late int _num2;
  late int _answer;
  final TextEditingController _controller = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    final random = Random();
    // Generate simple addition puzzle for parents (e.g. 12 + 7 = 19)
    _num1 = random.nextInt(10) + 10; // 10 to 19
    _num2 = random.nextInt(9) + 2;   // 2 to 10
    _answer = _num1 + _num2;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      backgroundColor: AppTheme.bgCream,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.security_rounded, color: Colors.orange, size: 28),
          SizedBox(width: 8),
          Text(
            'Parental Control 🧑‍💼',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please solve this simple math puzzle to verify you are a parent:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                '$_num1 + $_num2 = ?',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primaryGreen,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Enter answer',
                errorText: _error,
                errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: AppTheme.primaryGreen, width: 3),
                ),
              ),
              onSubmitted: (_) => _verify(),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
          ),
          onPressed: _verify,
          child: const Text(
            'Verify',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _verify() {
    final userAnswer = int.tryParse(_controller.text.trim());
    if (userAnswer == _answer) {
      Navigator.pop(context);
      widget.onPassed();
    } else {
      setState(() {
        _controller.clear();
        _error = 'Incorrect answer. Try again!';
      });
    }
  }
}
