// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/videocall/bloc/bloc.dart';
import 'package:wflow/common/videocall/bloc/event.dart';
import 'package:wflow/common/videocall/bloc/state.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/arguments_model/arguments_call.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/home.dart';
import 'package:wflow/modules/main/presentation/message/rooms/rooms.dart';
import 'package:wflow/modules/main/presentation/personal/personal/personal.dart';
import 'package:wflow/modules/main/presentation/work/work/work.dart';

import 'message/videocall/call.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _animationController;

  Widget _bottomTabBar(String icon, bool isActive) {
    return SvgPicture.asset(
      icon,
      color: isActive ? Colors.blueAccent : Colors.blueGrey,
      height: 24,
      width: 24,
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          type: BottomNavigationBarType.fixed,
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
    );
  }

  void call(StringeeCall2 call) {
    ArgumentsCall argumentsCall = ArgumentsCall(
        client: instance.get<StringeeClient>(),
        toUserId: call.to!,
        fromUserId: call.from!,
        callType: StringeeObjectEventType.call2,
        showIncomingUi: true,
        isVideoCall: call.isVideoCall,
        stringeeCall2: call);
    Navigator.of(context)
        .pushNamed(RouteKeys.callScreen, arguments: argumentsCall);
  }

  FutureOr<void> _requestPermissions() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfoPlugin.androidInfo.then((value) async {
      if (value.version.sdkInt >= 31) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.microphone,
          Permission.bluetoothConnect,
        ].request();
        print(statuses);
      } else {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.microphone,
        ].request();
        print(statuses);
      }
    });
  }
}
