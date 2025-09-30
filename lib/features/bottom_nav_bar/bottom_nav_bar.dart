import 'package:flutter/material.dart';

import 'package:glow_up_app/core/routes/app_route.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/features/bottom_nav_bar/widget/nav_bar_icon.dart';
import 'package:glow_up_app/features/muscles/presentation/muscles_screen.dart';
import 'package:glow_up_app/features/workout/presentation/workout_screen.dart';
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
    HomeScreen(),      // index 0
    MusclesScreen(),     // index 1
    SearchScreen(),    // index 2
    NutritionScreen(),    // index 3
    ProfileScreen(),   // index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context,AppRoutes.search);
          },
          child: Icon(
            Icons.search,
            color: _currentIndex == 2 ? ColorsApp.p : Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin: 12,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarIcon(
              isActive: _currentIndex == 0,
              label: "Home",
              icon: Icons.home,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            BottomNavBarIcon(
              isActive: _currentIndex == 1,
              label: "Workout",
              icon: Icons.sports_gymnastics,
              onTap: () => setState(() => _currentIndex = 1),
            ),
            const SizedBox(width: 3),
            BottomNavBarIcon(
              isActive: _currentIndex == 3,
              label: "Nutrition",
              icon: Icons.health_and_safety_rounded,
              onTap: () => setState(() => _currentIndex = 3),
            ),
            BottomNavBarIcon(
              isActive: _currentIndex == 4,
              label: "Me",
              icon: Icons.person,
              onTap: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
    );
  }
}
