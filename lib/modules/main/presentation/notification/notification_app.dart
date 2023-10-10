import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/notification/components/button_notification.dart';
import 'package:wflow/modules/main/presentation/notification/components/item_notification.dart';
import 'package:wflow/modules/main/presentation/notification/utils/constants.dart';

class NotificatonApp extends StatefulWidget {
  const NotificatonApp({super.key});

  @override
  State<NotificatonApp> createState() => _NotificatonAppState();
}

class _NotificatonAppState extends State<NotificatonApp> {
  int _indexSelected = 1;

  void onChangedItem(int index) {
    setState(() {
      _indexSelected = index;
    });
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
        child: Column(
          children: <Widget>[
            Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                myButtonsDatas.length,
                (index) => ButtonNotification(
                  width: myButtonsDatas[index][0],
                  height: myButtonsDatas[index][1],
                  content: myButtonsDatas[index][2],
                  isActive: _indexSelected == index,
                  onChanged: () => onChangedItem(index),
                ),
              ),
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
