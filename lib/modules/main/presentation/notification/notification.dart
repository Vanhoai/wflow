import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/notification/components/button_notification.dart';
import 'package:wflow/modules/main/presentation/notification/utils/constants.dart';

class NotificatonApp extends StatefulWidget {
  const NotificatonApp({super.key});

  @override
  State<NotificatonApp> createState() => _NotificatonAppState();
}

class _NotificatonAppState extends State<NotificatonApp> {
  int _indexSelected = 1;

  void onChangedItem(int index) {
    switch (index) {
      case 0:
        setState(
          () {
            _indexSelected = 0;
          },
        );
        break;
      case 1:
        setState(
          () {
            _indexSelected = 1;
          },
        );
        break;
      case 2:
        setState(
          () {
            _indexSelected = 2;
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification screen',
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonNotification(
                  width: myButtonsDatas[0][0],
                  height: myButtonsDatas[0][1],
                  content: myButtonsDatas[0][2],
                  isActive: _indexSelected == 0,
                  onChanged: () => onChangedItem(0),
                ),
                ButtonNotification(
                  width: myButtonsDatas[1][0],
                  height: myButtonsDatas[1][1],
                  content: myButtonsDatas[1][2],
                  isActive: _indexSelected == 1,
                  onChanged: () => onChangedItem(1),
                ),
                ButtonNotification(
                  width: myButtonsDatas[2][0],
                  height: myButtonsDatas[2][1],
                  content: myButtonsDatas[2][2],
                  isActive: _indexSelected == 2,
                  onChanged: () => onChangedItem(2),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            myButtonsDatas[_indexSelected][3],
          ],
        ),
      ),
    );
  }
}
