import 'package:flutter/material.dart';

class ItemNotification extends StatefulWidget {
  const ItemNotification({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  State<ItemNotification> createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<ItemNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ((MediaQuery.sizeOf(context).height) / 100) * 1.95,
        bottom: ((MediaQuery.sizeOf(context).height) / 100) * 1.95,
        left: ((MediaQuery.sizeOf(context).width) / 100) * 5.08,
        right: ((MediaQuery.sizeOf(context).width) / 100) * 5.08,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ((MediaQuery.sizeOf(context).width) / 100) * 10.17,
            height: ((MediaQuery.sizeOf(context).width) / 100) * 10.17,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(999),
                ),
              ),
              child: Icon(
                Icons.notifications,
                size: ((MediaQuery.sizeOf(context).width) / 100) * 8.14,
                color: const Color(0XFF0078E1),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0XFF000000),
                ),
              ),
              Text(
                widget.content,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0XFF555555),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
