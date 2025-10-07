import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../features/bottom_nav_bar/widget/nav_bar_icon.dart';
import '../../../features/muscles/presentation/muscles_screen.dart';
import '../../../features/workout/presentation/workout_screen.dart';

import '../../core/routes/app_route.dart';
import '../../core/theming/theming_provider.dart';
import '../Home/home_screen.dart';
import '../Nutrition/presentation/nutrition_screen.dart';
import '../profile/presentation/profile_screen.dart';
import '../search/presentation/search_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), // index 0
     MusclesScreen(), // index 1
    const SearchScreen(), // index 2
    const NutritionScreen(), // index 3
    const ProfileScreen(), // index 4
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.search,
          color: _currentIndex == 2
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.surface,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: Row(
                children: [
                  Expanded(
                    child: BottomNavBarIcon(
                      isActive: _currentIndex == 0,
                      label: "Home",
                      icon: Icons.home,
                      onTap: () => setState(() => _currentIndex = 0),
                    ),
                  ),
                  Expanded(
                    child: BottomNavBarIcon(
                      isActive: _currentIndex == 1,
                      label: "Workout",
                      icon: Icons.sports_gymnastics,
                      onTap: () => setState(() => _currentIndex = 1),
                    ),
                  ),
                  const SizedBox(width: 48), // مكان الـ FAB
                  Expanded(
                    child: BottomNavBarIcon(
                      isActive: _currentIndex == 3,
                      label: "Nutrition",
                      icon: Icons.health_and_safety_rounded,
                      onTap: () => setState(() => _currentIndex = 3),
                    ),
                  ),
                  Expanded(
                    child: BottomNavBarIcon(
                      isActive: _currentIndex == 4,
                      label: "Me",
                      icon: Icons.person,
                      onTap: () => setState(() => _currentIndex = 4),
                    ),
                  ),
                ],
              ),
            ),


    );


  }
}