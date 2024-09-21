import 'package:flutter/material.dart';
import 'package:flutter_application_1/exercises.dart';

// Import screens for navigation
import 'home.dart'; // Assuming Home screen is defined in home.dart
import 'exercises.dart'; // Add exercises screen in exercises.dart
import 'profile.dart'; // Add profile screen in profile.dart

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  // List of widgets for each tab
  final List<Widget> _screens = [
    Home(),  // Home screen (from home.dart)
    ExercisesScreen(),    // Exercises screen (to be defined in exercises.dart)
    ProfileScreen(),      // Profile screen (to be defined in profile.dart)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the currently selected tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
