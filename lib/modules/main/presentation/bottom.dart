import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/home.dart';
import 'package:wflow/modules/main/presentation/message/message/message.dart';
import 'package:wflow/modules/main/presentation/personal/personal/personal.dart';
import 'package:wflow/modules/main/presentation/work/work/work.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme: IconThemeData(color: Colors.grey.shade400),
        iconSize: 26,
        selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) => setState(() => currentIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Freelance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Personal',
          ),
        ],
      ),
      // LazyLoadIndexedStack is a custom widget that I created to solve the problem of rebuilding the widget when switching tabs.
      body: LazyLoadIndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          WorkScreen(),
          MessageScreen(),
          PersonalScreen(),
        ],
      ),
    );
  }
}
