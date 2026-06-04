// lib/widgets/answer_button.dart
import 'package:flutter/material.dart';
import '../app_theme.dart';

/// A colorful multiple-choice answer button used in both quiz modules.
/// Uses a playful spring press animation. Supports Square (Qaidah) or Pill (Islamic).
class AnswerButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isEnabled;
  final bool isSquare;
  final VoidCallback? onTap;
  final int index;
  final String? emojiOrIllustration;

  const AnswerButton({
    super.key,
    required this.text,
    required this.index,
    this.isSelected = false,
    this.isCorrect = false,
    this.isWrong = false,
    this.isEnabled = true,
    this.isSquare = false,
    this.emojiOrIllustration,
    this.onTap,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool _isPressed = false;

  Color get _backgroundColor {
    if (widget.isCorrect) return AppTheme.correctGreen;
    if (widget.isWrong) return AppTheme.wrongRed; // which is dull grey
    if (widget.isSelected) return AppTheme.selectedBlue;
    return Colors.white;
  }

  Color get _textColor {
    if (widget.isCorrect || widget.isSelected) return Colors.white;
    if (widget.isWrong) return Colors.white;
    return Colors.black87;
  }

  Color get _borderColor {
    if (widget.isCorrect) return AppTheme.correctGreen;
    if (widget.isWrong) return AppTheme.wrongRed;
    return Colors.black12;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.isEnabled) setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        if (widget.isEnabled) {
          setState(() => _isPressed = false);
          widget.onTap?.call();
        }
      },
      onTapCancel: () {
        if (widget.isEnabled) setState(() => _isPressed = false);
      },
      child: AnimatedScale(
        scale: _isPressed || widget.isWrong ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(
            vertical: widget.isSquare ? 0 : 8,
            horizontal: widget.isSquare ? 0 : 0,
          ),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(widget.isSquare ? 24 : 60),
            border: Border.all(color: _borderColor, width: widget.isSquare ? 4 : 3),
            boxShadow: [
              if (!_isPressed && !widget.isWrong)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: widget.isSquare ? _buildSquareLayout() : _buildPillLayout(),
        ),
      ),
    );
  }

  Widget _buildSquareLayout() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.emojiOrIllustration != null) ...[
            Text(widget.emojiOrIllustration!, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
          ],
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 24,
              color: _textColor,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPillLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 22,
                color: _textColor,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (widget.isCorrect)
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 32)
          else if (widget.isWrong && widget.isSelected)
            const Icon(Icons.cancel_rounded, color: Colors.white70, size: 32),
        ],
      ),
    );
  }
}
