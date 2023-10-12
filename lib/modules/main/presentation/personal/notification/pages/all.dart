import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/notification/components/item_notification.dart';
import 'package:wflow/modules/main/presentation/personal/notification/utils/constants.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: notificatons.length,
        itemBuilder: (context, index) {
          return ItemNotification(
            title: notificatons[index][0],
            content: notificatons[index][1],
          );
        },
      ),
    );
  }
}
