import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/home/post/candidate_list/widgets/widgets.dart';

const String IMAGE_PHOTO = 'https://i.pinimg.com/564x/b5/19/65/b5196523468e198c8d6f09dd6320855f.jpg';

class CandidateItemWidget extends StatefulWidget {
  const CandidateItemWidget({
    super.key,
    this.onTapLeading,
    this.leadingPhotoUrl = IMAGE_PHOTO,
    this.onTapName,
    this.onTapCv,
    this.onTapChat,
  });

  final double leadingSize = 50;
  final String leadingPhotoUrl;
  final VoidCallback? onTapLeading;
  final VoidCallback? onTapName;
  final VoidCallback? onTapCv;
  final VoidCallback? onTapChat;

  @override
  State<CandidateItemWidget> createState() => _CandidateItemWidgetState();
}

class _CandidateItemWidgetState extends State<CandidateItemWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  widget.leadingPhotoUrl,
                  width: widget.leadingSize,
                  height: widget.leadingSize,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(99),
                  child: InkWell(
                    onTap: widget.onTapLeading,
                    highlightColor: themeData.colorScheme.background.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: widget.onTapName,
                  child: Text(
                    'Tran Van Hoai',
                    style: themeData.textTheme.displayLarge!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground,
                    )),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                CandidateCvItemWidget(
                  cvName: 'React_Native_Developer',
                  onTap: widget.onTapCv,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: widget.onTapChat,
                borderRadius: BorderRadius.circular(4),
                highlightColor: themeData.colorScheme.background.withOpacity(0.5),
                child: Ink(
                  width: 50,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(27, 118, 255, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    width: 50,
                    height: 20,
                    alignment: Alignment.center,
                    child: const Text(
                      'Chat',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {},
                icon: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: themeData.colorScheme.onBackground.withOpacity(0.5),
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
