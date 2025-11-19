import 'package:flutter/material.dart';

class AnimatedTap extends StatefulWidget {
  const AnimatedTap({
    super.key,
    required this.child,
    required this.onTap,
    this.scale = 0.95,
    this.duration = const Duration(milliseconds: 100),
    this.pressedColor,
  });

  final Widget child;
  final VoidCallback onTap;
  final double scale;
  final Duration duration;
  final Color? pressedColor;

  @override
  State<AnimatedTap> createState() => _AnimatedTapState();
}

class _AnimatedTapState extends State<AnimatedTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    // Сбрасываем анимацию в начальное состояние перед dispose
    _controller.reset();
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    // Немедленно сбрасываем анимацию в начальное состояние
    // чтобы избежать визуального завершения анимации при возврате
    _controller.reset();
    widget.onTap();
  }

  void _handleTapCancel() {
    // Немедленно сбрасываем анимацию в начальное состояние
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );

    if (widget.pressedColor != null) {
      child = AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.pressedColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        child: child,
      );
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}

