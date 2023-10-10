import 'package:flutter/material.dart';

class ButtonNotification extends StatefulWidget {
  const ButtonNotification({
    super.key,
    required this.width,
    required this.height,
    required this.content,
    required this.isActive,
    required this.onChanged,
  });

  final double width;
  final double height;
  final String content;
  final bool isActive;
  final Function()? onChanged;

  @override
  State<ButtonNotification> createState() => _ButtonNotificationState();
}

class _ButtonNotificationState extends State<ButtonNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: ((MediaQuery.sizeOf(context).width) / 100) * 2.04,
          right: ((MediaQuery.sizeOf(context).width) / 100) * 2.04),
      child: SizedBox(
        width: ((MediaQuery.sizeOf(context).width) / 100) * widget.width,
        height: ((MediaQuery.sizeOf(context).height) / 100) * widget.height,
        child: OutlinedButton(
          onPressed: widget.onChanged,
          style: OutlinedButton.styleFrom(
            backgroundColor: widget.isActive
                ? const Color(0XFF1E88E5)
                : const Color(0XFFFFFFFF),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            side: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: widget.isActive
                  ? const Color(0XFF1E88E5)
                  : const Color(0XFFD6D6D6),
            ),
          ),
          child: Text(
            widget.content,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: widget.isActive
                  ? const Color(0XFFFFFFFF)
                  : const Color(0XFF606060),
            ),
          ),
        ),
      ),
    );
  }
}
