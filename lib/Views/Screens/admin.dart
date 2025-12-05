import 'package:flutter/material.dart';
import 'package:smart_school_system/Services/database_service.dart';
import 'package:smart_school_system/Views/Screens/display_users.dart';
import 'package:smart_school_system/Views/Screens/options.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int currentIndex = 0;
  final List<Widget> screens = [Options(), DisplayUsers()];
  @override
  void initState() {
    super.initState();
    DatabaseService().fetchInstructors();
    DatabaseService().fetchStudents();
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(255, 56, 110, 238),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,

        selectedLabelStyle: TextStyle(color: Colors.red),
        items: [
          BottomNavigationBarItem(
            icon: navIcon(Icons.manage_accounts, false),
            activeIcon: navIcon(Icons.manage_accounts, true),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: navIcon(Icons.assignment, false),
            activeIcon: navIcon(Icons.assignment, true),
            label: 'Community',
          ),
        ],
      ),
    );
  }

  Widget navIcon(IconData icon, bool selected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 24,
        color: selected ? Color.fromARGB(255, 56, 110, 238) : Colors.white,
      ),
    );
  }
}
