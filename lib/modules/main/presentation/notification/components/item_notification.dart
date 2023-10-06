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
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
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
