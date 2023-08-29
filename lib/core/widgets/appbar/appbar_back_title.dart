import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

class Header extends StatelessWidget implements PreferredSizeWidget{

  const Header({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: TextTitle(fontWeight: FontWeight.w500,size: 18),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SvgPicture.asset(AppConstants.backArrow, height: 24, width: 24,),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);

}