
import '../../features/question/presentation/widget/levels.dart';

class ActivityLevelHelper {
  static ActivityLevel getActivityLevelFromIndex(int index) {
    return ActivityLevel.values[index];
  }

  static List<String> getActivityLevelDisplayNames() {
    return ActivityLevel.values.map((level) => level.displayName).toList();
  }

  static ActivityLevel getActivityLevelFromName(String name) {
    return ActivityLevel.values.firstWhere(
          (level) => level.name == name,
      orElse: () => ActivityLevel.sedentary,
    );
  }
}