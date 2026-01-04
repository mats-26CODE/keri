import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.dark.background
          : AppColors.light.background,
      body: const Center(
        child: Text('Orders Page - Coming Soon'),
      ),
    );
  }
}

