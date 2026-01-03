import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_sizes.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../shared/widgets/buttons/app_button.dart';
import '../../../../shared/widgets/toggles/theme_toggle_icon.dart';
import '../../../../shared/widgets/toggles/language_toggle.dart';
import '../../../../shared/widgets/animations/fade_in_text.dart';
import '../../../../shared/widgets/mascot/app_mascot.dart';
import '../providers/onboarding_provider.dart';
import '../models/onboarding_slide.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToSignIn();
    }
  }

  void _navigateToSignIn() {
    Navigator.of(context).pushReplacementNamed('/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final slides = ref.watch(onboardingSlidesProvider);

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.dark.background
          : AppColors.light.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return _OnboardingSlideWidget(
                        slide: slides[index],
                        isDarkMode: isDarkMode,
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSizes.spacingLarge),
                // Page Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => _PageIndicator(
                      isActive: index == _currentPage,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.spacingMedium),
                // Action Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.screenPaddingX,
                    vertical: AppSizes.spacingMedium,
                  ),
                  child: AppButton(
                    text: _currentPage == slides.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: _nextPage,
                  ),
                ),
                SizedBox(height: AppSizes.spacingSmall),
              ],
            ),
            // Top toggles
            Positioned(
              top: AppSizes.spacingMedium,
              right: AppSizes.screenPaddingX,
              child: Row(
                children: const [
                  LanguageToggle(),
                  SizedBox(width: AppSizes.spacingSmall),
                  ThemeToggleIcon(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlide slide;
  final bool isDarkMode;

  const _OnboardingSlideWidget({required this.slide, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingX),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Mascot with slide animation
          AppMascot(
            // lottiePath: 'assets/lottie/delivery.json', // Uncomment when you add lottie files
            size: 200,
            enableSlideAnimation: true,
            slideDuration: const Duration(milliseconds: 500),
            slideDelay: const Duration(milliseconds: 100),
            slideOffset: const Offset(0.8, 0), // Slide from right
            slideCurve: Curves.easeOut,
          ),
          SizedBox(height: AppSizes.spacingXXLarge),
          // Title with fade-in animation
          FadeInText.title(
            text: slide.title,
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeTitleXLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
          SizedBox(height: AppSizes.spacingSmall),
          // Description with fade-in animation
          FadeInText.body(
            text: slide.description,
            textAlign: TextAlign.center,
            fontSize: AppSizes.fontSizeLarge,
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;
  final bool isDarkMode;

  const _PageIndicator({required this.isActive, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.spacingSmall / 4),
      width: isActive
          ? AppSizes.indicatorActiveWidth
          : AppSizes.indicatorInactiveWidth,
      height: AppSizes.indicatorHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.indicatorHeight / 2),
        color: isActive
            ? AppColors.light.primaryColor.withAlpha(140)
            : (isDarkMode
                  ? AppColors.dark.darkSurfaceGrayColor
                  : AppColors.light.lightGrayColor),
      ),
    );
  }
}
