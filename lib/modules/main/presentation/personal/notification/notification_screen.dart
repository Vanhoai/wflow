import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/personal/notification/widgets/category_button.dart';
import 'package:wflow/modules/main/presentation/personal/notification/widgets/notification_card.dart';
import 'package:wflow/modules/main/presentation/personal/notification/utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  late int _itemIndexSelected;

  @override
  void initState() {
    _itemIndexSelected = 1;
    super.initState();
  }

  void onChangedItemIndexSelected(int i) {
    setState(() {
      _itemIndexSelected = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
        ),
      ),
      body: SizedBox(
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
          physics: const BouncingScrollPhysics(),
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
        physics: const BouncingScrollPhysics(),
        itemCount: notifications.length,
        itemBuilder: (context, index) => NotificationCard(
          title: notifications[index]['title'],
          content: notifications[index]['content'],
        ),
      ),
    );
  }
}
