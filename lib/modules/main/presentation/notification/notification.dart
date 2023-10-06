import 'package:flutter/material.dart';

class NotificatonApp extends StatefulWidget {
  const NotificatonApp({super.key});

  @override
  State<NotificatonApp> createState() => _NotificatonAppState();
}

class _NotificatonAppState extends State<NotificatonApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          'Notification App',
        ),
      ),
    );
  }
}
