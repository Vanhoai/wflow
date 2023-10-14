import 'package:flutter/material.dart';
import 'package:wflow/core/theme/size.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  State<NotificationCard> createState() => NotificationStateCard();
}

class NotificationStateCard extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Ink(
        padding: const EdgeInsets.only(
          left: AppSize.paddingScreenDefault,
          right: AppSize.paddingScreenDefault,
          top: AppSize.paddingMedium * 2,
          bottom: AppSize.paddingMedium * 2,
        ),
        child: Row(
          children: <Widget>[
            _buildIcon(),
            const SizedBox(
              width: AppSize.paddingLarge,
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 10.17,
      height: ((MediaQuery.sizeOf(context).width) / 100) * 10.17,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.sizeOf(context).width),
        ),
      ),
      child: Icon(
        Icons.notifications,
        size: ((MediaQuery.sizeOf(context).width) / 100) * 8.14,
        color: const Color(0XFF0078E1),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
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
    );
  }
}
