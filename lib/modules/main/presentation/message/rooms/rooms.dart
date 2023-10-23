import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/headerrooms.dart';
import 'package:wflow/modules/main/presentation/message/rooms/listroom/listroom.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RoomsScreenState();
  }
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            HeaderRooms(),
            Expanded(
              child: ListRoom(),
            )
          ],
        ),
      ),
    );
  }
}
