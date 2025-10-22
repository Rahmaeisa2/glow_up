import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:glow_up_app/features/question/provider/user_onboarding_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  void _updateActivityLevel (index ,UserOnboardingProvider provider){
    ActivityLevel selectedLevel = ActivityLevelHelper.getActivityLevelFromIndex(index);
    provider.updateActivityLevel(selectedLevel.toMap());

print("Activity Level Updated:");
    print("Name: ${selectedLevel.name}");
    print("Display Name: ${selectedLevel.displayName}");
    print("Multiplier: ${selectedLevel.multiplier}");

  }
  void _loadPreviousSelection() {
    final provider = Provider.of<UserOnboardingProvider>(context, listen: false);

    if (provider.user.activityLevel != null) {
      String savedActivityName = provider.user.activityLevel!['name'];
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
    final provider = Provider.of<UserOnboardingProvider>(context);

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
                        _updateActivityLevel(index, provider);
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