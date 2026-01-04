import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'dart:ui';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../providers/navigation_provider.dart';
import 'home_page.dart';
import 'orders_page.dart';
import 'profile_page.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final currentIndex = ref.watch(navigationProvider);

    final List<Widget> pages = [
      const HomePage(),
      const OrdersPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.dark.darkSurfaceGrayColor.withOpacity(0.8)
                  : AppColors.light.pureWhiteColor.withOpacity(0.8),
              border: Border(
                top: BorderSide(
                  color: isDarkMode
                      ? AppColors.dark.grayishBorderColor.withOpacity(0.3)
                      : AppColors.light.grayishBorderColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPaddingX,
                  vertical: AppSizes.paddingSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedDeliveryBox01,
                        size: 20,
                      ),
                      label: "Delivery",
                      index: 0,
                      currentIndex: currentIndex,
                      onTap: () =>
                          ref.read(navigationProvider.notifier).setIndex(0),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedClock03,
                        size: 20,
                      ),
                      label: "Orders",
                      index: 1,
                      currentIndex: currentIndex,
                      onTap: () =>
                          ref.read(navigationProvider.notifier).setIndex(1),
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedUser,
                        size: 20,
                      ),
                      label: "Profile",
                      index: 2,
                      currentIndex: currentIndex,
                      onTap: () =>
                          ref.read(navigationProvider.notifier).setIndex(2),
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required dynamic icon,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDarkMode
                          ? AppColors.dark.primaryColor.withAlpha(120)
                          : AppColors.light.primaryColor.withAlpha(100))
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: IconTheme(
                data: IconThemeData(
                  color: isSelected
                      ? (isDarkMode
                            ? AppColors.dark.primaryColor
                            : AppColors.light.primaryColor)
                      : (isDarkMode
                            ? AppColors.dark.mediumGrayColor
                            : AppColors.light.mediumGrayColor),
                  size: AppSizes.iconSizeMedium,
                ),
                child: icon,
              ),
            ),
            const SizedBox(height: AppSizes.spacingTiny),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.subtitleStyle(
                isDarkMode: isDarkMode,
                color: isSelected
                    ? (isDarkMode
                          ? AppColors.dark.text
                          : AppColors.light.primaryColor)
                    : (isDarkMode
                          ? AppColors.dark.mediumGrayColor
                          : AppColors.light.mediumGrayColor),
                fontSize: AppSizes.fontSizeSmall,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
