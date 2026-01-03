import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingSpinner({super.key, this.size = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: color != null
            ? AlwaysStoppedAnimation<Color>(color!)
            : null,
      ),
    );
  }
}
