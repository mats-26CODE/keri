import 'package:flutter/material.dart';

/// Wrapper that provides smooth animated transitions when theme changes
class AnimatedThemeWrapper extends StatefulWidget {
  final Widget child;
  final ThemeData theme;
  final Duration duration;
  final Curve curve;

  const AnimatedThemeWrapper({
    super.key,
    required this.child,
    required this.theme,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeInOutCubic,
  });

  @override
  State<AnimatedThemeWrapper> createState() => _AnimatedThemeWrapperState();
}

class _AnimatedThemeWrapperState extends State<AnimatedThemeWrapper>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _colorController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  ThemeData? _previousTheme;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(
        milliseconds: (widget.duration.inMilliseconds * 0.8).round(),
      ),
      vsync: this,
    );

    _colorController = AnimationController(
      duration: Duration(
        milliseconds: (widget.duration.inMilliseconds * 1.2).round(),
      ),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: widget.curve));

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _colorAnimation = ColorTween(
      begin: _previousTheme?.primaryColor,
      end: widget.theme.primaryColor,
    ).animate(CurvedAnimation(parent: _colorController, curve: widget.curve));

    // Set initial state without animation
    _fadeController.value = 1.0;
    _scaleController.value = 1.0;
    _colorController.value = 1.0;

    _isInitialized = true;
  }

  @override
  void didUpdateWidget(AnimatedThemeWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only animate if there's an actual theme change and we're initialized
    if (_isInitialized && oldWidget.theme != widget.theme) {
      _previousTheme = oldWidget.theme;

      // Update color animation
      _colorAnimation = ColorTween(
        begin: _previousTheme?.primaryColor,
        end: widget.theme.primaryColor,
      ).animate(CurvedAnimation(parent: _colorController, curve: widget.curve));

      _startAnimation();
    }
  }

  void _startAnimation() {
    // Reset and start animations
    _fadeController.reset();
    _scaleController.reset();
    _colorController.reset();

    // Stagger the animations for a cool effect
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _colorController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _fadeAnimation,
        _scaleAnimation,
        _colorAnimation,
      ]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _colorAnimation.value?.withOpacity(0.1) ?? Colors.transparent,
                _colorAnimation.value?.withOpacity(0.05) ?? Colors.transparent,
              ],
            ),
          ),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Theme(data: widget.theme, child: widget.child),
            ),
          ),
        );
      },
    );
  }
}
