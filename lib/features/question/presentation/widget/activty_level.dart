import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/helper/avtivity_level_helper.dart';
import '../../../../core/theming/app_color.dart';

import 'levels.dart';

class ActivityLevelWidget extends StatefulWidget {
  const ActivityLevelWidget({super.key});

  @override
  State<ActivityLevelWidget> createState() => _ActivityLevelWidgetState();
}

class _ActivityLevelWidgetState extends State<ActivityLevelWidget> {
  int _selectedActivityLevelIndex = -1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPreviousSelection();
  }

  void _updateActivityLevel (index){
    ActivityLevel selectedLevel = ActivityLevelHelper.getActivityLevelFromIndex(index);
    UserAnswer.activityLevel = selectedLevel.toMap();

print("Activity Level Updated:");
print("Name : ${selectedLevel.name}");
    print("Name : ${selectedLevel.displayName}");
    print("Name : ${selectedLevel.multiplier}");
    print("UserAnswer.activityLevel :${UserAnswer.activityLevel}");

  }
  void _loadPreviousSelection() {
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

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child: Column(
            children: [
              Text(
            'What is your daily activity level?',
            style:  Theme.of(context).textTheme.displaySmall?.copyWith(
              color:
              Theme.of(context).colorScheme.primary
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],

                      color: isSelected ?  Theme.of(context).colorScheme.surfaceContainer: Theme.of(context).colorScheme.surfaceVariant,
                      border: Border.all(
                        color: isSelected? Colors.white24 :Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: RadioListTile<int>(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        level.displayName,
                        style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:
                          Theme.of(context).colorScheme.onSecondaryFixedVariant,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),

                        ],
                      ),
                      value: index,
                      groupValue: _selectedActivityLevelIndex,
                      activeColor: Theme.of(context).primaryColor,
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