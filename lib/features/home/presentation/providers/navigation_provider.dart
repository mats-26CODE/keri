import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for managing bottom navigation tab index
class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void reset() {
    state = 0;
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});

