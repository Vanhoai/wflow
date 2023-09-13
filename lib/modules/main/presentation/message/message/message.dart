import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

class MessageScreen extends StatefulWidget {


  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Chị HR tuyển dụng",
            style: TextTitle(fontWeight: FontWeight.w500,size: 18),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(AppConstants.backArrow, height: 24, width: 24,),
              ),
            ),
          ),
          actions: [

          ],
        ),
      ),
    );
  }
}
