import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class CompanyMemberWidget extends StatefulWidget {
  const CompanyMemberWidget({super.key});

  @override
  State<CompanyMemberWidget> createState() => _CompanyMemberWidgetState();
}

const String IMAGE_URL = 'https://res.cloudinary.com/dhwzs1m4l/image/upload/v1697453686/notion-avatar_sxmijk.png';

class _CompanyMemberWidgetState extends State<CompanyMemberWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Header(
              title: Flexible(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Huynh Hong Vy',
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              subtitle: const Text('0396855834'),
              onTapLeading: () {},
              leadingPhotoUrl: IMAGE_URL,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppConstants.more),
                ),
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
