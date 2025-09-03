
import '../../question/presentation/widget/levels.dart';

class ActivityLevelHelper {
  // Get activity level from UI selection
  static ActivityLevel getActivityLevelFromIndex(int index) {
    return ActivityLevel.values[index];
  }

  // Get all activity levels for UI dropdown
  static List<String> getActivityLevelDisplayNames() {
    return ActivityLevel.values.map((level) => level.displayName).toList();
  }

  // Get activity level from string name
  static ActivityLevel getActivityLevelFromName(String name) {
    return ActivityLevel.values.firstWhere(
          (level) => level.name == name,
      orElse: () => ActivityLevel.sedentary,
    );
  }
}