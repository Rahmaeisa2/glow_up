import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/helper/avtivity_level_helper.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/widget/container_for_question_screen.dart';
import 'levels.dart';

class ActivityLevelWidget extends StatefulWidget {
  const ActivityLevelWidget({super.key});

  @override
  State<ActivityLevelWidget> createState() => _ActivityLevelWidgetState();
}

class _ActivityLevelWidgetState extends State<ActivityLevelWidget> {
  int _selectedActivityLevelIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load previously selected activity level if exists
    _loadPreviousSelection();
  }

  void _updateActivityLevel(int index) {
    ActivityLevel selectedLevel = ActivityLevelHelper.getActivityLevelFromIndex(index);

    // Update UserAnswer with activity level value
    UserAnswer.activityLevel = selectedLevel.toMap();

    print('✅ Activity Level Updated:');
    print('  - Name: ${selectedLevel.name}');
    print('  - Display: ${selectedLevel.displayName}');
    print('  - Multiplier: ${selectedLevel.multiplier}');
    print('  - UserAnswer.activityLevel: ${UserAnswer.activityLevel}');
  }
  void _loadPreviousSelection() {
    // إذا كان فيه activity level محفوظ مسبقاً في UserAnswer
    if (UserAnswer.activityLevel != null) {
      String savedActivityName = UserAnswer.activityLevel!['name'];
      int savedIndex = ActivityLevel.values.indexWhere(
            (level) => level.name == savedActivityName,
      );
      if (savedIndex != -1) {
        setState(() {

          _selectedActivityLevelIndex = savedIndex;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child: Column(
            children: [
            // Progress indicator (optional)
            LinearProgressIndicator(
            value: 0.8, // Adjust based on your progress
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
          ),
          SizedBox(height: 30),

          // Title and description
          Text(
            'What is your daily activity level?',
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),

          // Activity levels
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: ActivityLevel.values.asMap().entries.map((entry) {
                  int index = entry.key;
                  ActivityLevel level = entry.value;
                  bool isSelected = _selectedActivityLevelIndex == index;

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.indigo[100] : Colors.grey[100],
                      border: Border.all(
                        color: isSelected ? Colors.indigo : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: RadioListTile<int>(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        level.displayName,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? ColorsApp.p : Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text(
                            'معامل النشاط: ${level.multiplier}',
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      value: index,
                      groupValue: _selectedActivityLevelIndex,
                      activeColor: ColorsApp.p,
                      onChanged: (value) {
                        setState(() {
                          _selectedActivityLevelIndex = value!;
                        });
                        _updateActivityLevel(index);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
            ]
        )
        )
    );
  }
}