import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
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
            const SizedBox(width: AppSize.paddingLarge),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.sizeOf(context).width),
        ),
      ),
      child: const Icon(
        Icons.notifications,
        size: 24,
        color: AppColors.primary,
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
            color: Color.fromARGB(255, 138, 138, 138),
          ),
        ),
      ],
    );
  }
}
