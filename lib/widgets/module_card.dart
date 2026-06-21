// lib/widgets/module_card.dart
import 'package:flutter/material.dart';

/// A large, visually prominent card for the home screen module buttons.
/// Uses a playful spring press animation.
class ModuleCard extends StatefulWidget {
  final String title;
  final String iconPath;
  final List<Color> gradient;
  final VoidCallback onTap;
  /// Optional emoji shown instead of the image asset (use while awaiting a proper icon)
  final String? emoji;

  const ModuleCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.gradient,
    required this.onTap,
    this.emoji,
  });



  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              if (!_isPressed)
                BoxShadow(
                  color: widget.gradient.last.withValues(alpha: 0.6),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Stack(
            children: [
              // Subtle glass shine
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    // Graphic icon
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: widget.emoji != null
                          ? Center(
                              child: Text(
                                widget.emoji!,
                                style: const TextStyle(fontSize: 38),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image.asset(
                                widget.iconPath,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported_rounded,
                                        size: 40, color: Colors.black26),
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    // Text column
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black38,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
