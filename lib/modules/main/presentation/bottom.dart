import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/common/videocall/bloc/bloc.dart';
import 'package:wflow/common/videocall/bloc/event.dart';
import 'package:wflow/common/videocall/bloc/state.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/arguments_model/arguments_call.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/home.dart';
import 'package:wflow/modules/main/presentation/message/rooms/rooms.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/add_business_screen.dart';
import 'package:wflow/modules/main/presentation/personal/personal/personal.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/remove_collaborator_screen.dart';
import 'package:wflow/modules/main/presentation/work/work/work.dart';

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
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isActive ? AppColors.primary : AppColors.fadeText,
        BlendMode.srcIn,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animationController.repeat(min: 0, max: 1, reverse: true);

    instance.get<VideoCallBloc>().add(const VideoCallConnectEvent());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> redirectFlash() async {
      int role = instance.get<AppBloc>().state.role.toInt();
      if (role == 2) {
        instance.get<NavigationService>().pushNamed(RouteKeys.upPostScreen);
      } else {
        instance.get<NavigationService>().pushNamed(RouteKeys.contractScreen);
      }
    }

    return BlocListener(
      listener: (context, state) {
        if (state is CallInComing) {
          call(state.call);
        }
      },
      bloc: instance.get<VideoCallBloc>(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  height: 68,
                  width: 68,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(34),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, _animationController.value * 10),
                      ),
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, _animationController.value * -4),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    isExtended: true,
                    onPressed: redirectFlash,
                    child: SvgPicture.asset(
                      AppConstants.flash,
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            onTap: _onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: _bottomTabBar(AppConstants.bottomHome, false),
                activeIcon: _bottomTabBar(AppConstants.bottomHome, true),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _bottomTabBar(AppConstants.bottomWork, false),
                activeIcon: _bottomTabBar(AppConstants.bottomWork, true),
                label: 'Works',
              ),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                activeIcon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _bottomTabBar(AppConstants.bottomMessage, false),
                activeIcon: _bottomTabBar(AppConstants.bottomMessage, true),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: _bottomTabBar(AppConstants.bottomExtended, false),
                activeIcon: _bottomTabBar(AppConstants.bottomExtended, true),
                label: 'Personal',
              ),
            ],
          ),
        ),
        body: LazyLoadIndexedStack(
          index: currentIndex,
          children: [
            const AddBusinessScreen(),
            const RemoveCollaboratorScreen(),
            Container(),
            const RoomsScreen(),
            const PersonalScreen(),
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
