


import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
class Camera extends StatefulWidget{
  const Camera({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateCamera();
  }


}

//Đang lỗi
class _StateCamera extends State<Camera>{
  late List<CameraDescription> _cameras;
  late CameraController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            requestPermissions();
            break;
          default:
          // Handle other errors here.
            break;
        }
      }});
  }
  FutureOr<void> init() async{
    _cameras = await availableCameras();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  FutureOr<void> requestPermissions() async {
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
  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return SafeArea(
      child: CameraPreview(controller),
    );
  }

}