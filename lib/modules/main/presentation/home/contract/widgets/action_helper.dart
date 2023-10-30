import 'package:flutter/material.dart';

class ActionHelper extends StatelessWidget {
  const ActionHelper({super.key, required this.onUpload, required this.onWatchVideo});

  final Function() onUpload;
  final Function() onWatchVideo;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4),
          highlightColor: themeData.colorScheme.background.withOpacity(0.5),
          child: Ink(
            width: 90,
            height: 30,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(27, 118, 255, 1),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              width: 90,
              height: 30,
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Upload',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.upload_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4),
          highlightColor: themeData.colorScheme.background.withOpacity(0.5),
          child: Ink(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Watch Video',
                    style: themeData.textTheme.displayMedium!.merge(
                      const TextStyle(
                        color: Color.fromRGBO(27, 118, 255, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
