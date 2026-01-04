import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

enum VibrationLevel { short, medium, long, custom, preset }

class AppVibration {
  static Future<void> vibrate({
    VibrationLevel level = VibrationLevel.short,
    List<int>? pattern,
    VibrationPreset? preset,
  }) async {
    if (await Vibration.hasVibrator()) {
      switch (level) {
        case VibrationLevel.short:
          Vibration.vibrate(duration: 50);
          break;
        case VibrationLevel.medium:
          Vibration.vibrate(duration: 200);
          break;
        case VibrationLevel.long:
          Vibration.vibrate(duration: 400);
          break;
        case VibrationLevel.custom:
          if (pattern != null) {
            Vibration.vibrate(pattern: pattern);
          }
          break;
        case VibrationLevel.preset:
          if (preset != null) {
            Vibration.vibrate(preset: preset);
          }
          break;
      }
    }
  }
}
