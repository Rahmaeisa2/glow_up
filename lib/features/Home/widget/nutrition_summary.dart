import 'package:flutter/material.dart';

import 'nutrition_card.dart';
class NutritionSummary  extends StatelessWidget {
  final Map<String, dynamic> plan;

  const NutritionSummary ({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NutritionCard(
        title: "Calories",
        value: "${plan['totalCalories'] ?? 'No data'} kcal",
        icon: Icons.local_fire_department,
      ),
      Row(
        children: [
          Expanded(
            child: NutritionCard(
              title: "Protein",
              value: "${plan['protein'] ?? 'No data'} g",
              icon: Icons.fitness_center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NutritionCard(
              title: "Carbs",
              value: "${plan['carbs'] ?? 'No data'} g",
              icon: Icons.grain,
            ),
          ),
        ],
      ),
    ],
    ) ;
  }
}
