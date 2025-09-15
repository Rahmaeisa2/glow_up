enum ActivityLevel {
  sedentary('sedentary', 'Little or no exercise)', 1.2),
  lightlyActive('lightly_active', 'Light exercise/sports 1-3 days/week', 1.375),
  moderatelyActive('moderately_active', 'Moderate exercise/sports 3-5 days/week', 1.55),
  veryActive('very_active', 'Very Active', 1.725),
  extremelyActive('extremely_active', 'Very hard exercise & physical job', 1.9);

  const ActivityLevel(this.name, this.displayName, this.multiplier);

  final String name;
  final String displayName;
  final double multiplier;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'displayName': displayName,
      'multiplier': multiplier,
    };
  }

}


