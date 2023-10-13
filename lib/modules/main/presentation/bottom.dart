// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/videocall/bloc/bloc.dart';
import 'package:wflow/common/videocall/bloc/event.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/home.dart';
import 'package:wflow/modules/main/presentation/message/rooms/rooms.dart';
import 'package:wflow/modules/main/presentation/personal/personal/personal.dart';
import 'package:wflow/modules/main/presentation/work/work/work.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  Widget bottomTabBar(String icon, bool isActive) {
    return SvgPicture.asset(
      icon,
      color: isActive ? Colors.blueAccent : Colors.blueGrey,
      height: 24,
      width: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    instance.get<VideoCallBloc>().add(const VideoCallConnectEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 0,
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          iconSize: 24,
          onTap: (value) => setState(() => currentIndex = value),
          items: [
            BottomNavigationBarItem(
              icon: bottomTabBar(AppConstants.bottomHome, false),
              activeIcon: bottomTabBar(AppConstants.bottomHome, true),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: bottomTabBar(AppConstants.bottomWork, false),
              activeIcon: bottomTabBar(AppConstants.bottomWork, true),
              label: 'Freelance',
            ),
            BottomNavigationBarItem(
              icon: bottomTabBar(AppConstants.bottomMessage, false),
              activeIcon: bottomTabBar(AppConstants.bottomMessage, true),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: bottomTabBar(AppConstants.bottomExtended, false),
              activeIcon: bottomTabBar(AppConstants.bottomExtended, true),
              label: 'Personal',
            ),
          ],
        ),
      ),
      // LazyLoadIndexedStack is a custom widget that I created to solve the problem of rebuilding the widget when switching tabs.
      body: LazyLoadIndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          WorkScreen(),
          RoomsScreen(),
          PersonalScreen(),
        ],
      ),
    );
  }
}
