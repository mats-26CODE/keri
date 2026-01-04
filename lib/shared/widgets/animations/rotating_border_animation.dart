import 'package:flutter/material.dart';
import 'package:keri/core/values/app_colors.dart';

class RotatingBorderAnimation extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final Color topColor;
  final Color rightColor;
  final Color bottomColor;
  final Color leftColor;
  final Duration duration;
  final bool clockwise;

  const RotatingBorderAnimation({
    super.key,
    required this.child,
    this.borderWidth = 4.0,
    this.topColor = AppColors.primaryColor,
    this.rightColor = AppColors.primaryDeepColor,
    this.bottomColor = AppColors.primaryColor,
    this.leftColor = AppColors.primaryDeepColor,
    this.duration = const Duration(seconds: 3),
    this.clockwise = true,
  });

  @override
  State<RotatingBorderAnimation> createState() =>
      _RotatingBorderAnimationState();
}

class _RotatingBorderAnimationState extends State<RotatingBorderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.clockwise ? 1.0 : -1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RotatingBorderPainter(
            animation: _animation.value,
            borderWidth: widget.borderWidth,
            topColor: widget.topColor,
            rightColor: widget.rightColor,
            bottomColor: widget.bottomColor,
            leftColor: widget.leftColor,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class RotatingBorderPainter extends CustomPainter {
  final double animation;
  final double borderWidth;
  final Color topColor;
  final Color rightColor;
  final Color bottomColor;
  final Color leftColor;

  RotatingBorderPainter({
    required this.animation,
    required this.borderWidth,
    required this.topColor,
    required this.rightColor,
    required this.bottomColor,
    required this.leftColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - borderWidth) / 2;

    // Create a path for the circle
    final circlePath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    // Calculate the rotation angle
    final rotationAngle = animation * 2 * 3.14159; // 2π radians = 360 degrees

    // Create a shader that rotates the colors
    final colors = [topColor, rightColor, bottomColor, leftColor, topColor];
    final stops = [0.0, 0.25, 0.5, 0.75, 1.0];

    final shader = SweepGradient(
      colors: colors,
      stops: stops,
      transform: GradientRotation(rotationAngle),
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Paint the border
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(RotatingBorderPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.topColor != topColor ||
        oldDelegate.rightColor != rightColor ||
        oldDelegate.bottomColor != bottomColor ||
        oldDelegate.leftColor != leftColor;
  }
}
