import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/notification/components/category_button.dart';
import 'package:wflow/modules/main/presentation/personal/notification/components/notification_card.dart';
import 'package:wflow/modules/main/presentation/personal/notification/utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  int _itemIndexSelected = 1;

  void onChangedItemIndexSelected(int i) => setState(() {
        _itemIndexSelected = i;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            _buildCategorySelectionList(),
            const SizedBox(
              height: 32,
            ),
            _buildNotificationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelectionList() {
    return SizedBox(
      height: 33,
      child: Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) => CategoryButton(
            category: categories[index]['category'],
            isActive: _itemIndexSelected == index,
            onChanged: () => onChangedItemIndexSelected(index),
          ),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    final List notifications = categories[_itemIndexSelected]['notifications'];

    return Expanded(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) => NotificationCard(
          title: notifications[index]['title'],
          content: notifications[index]['content'],
        ),
      ),
    );
  }
}
