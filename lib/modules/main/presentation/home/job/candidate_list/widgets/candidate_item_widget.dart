import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wflow/modules/main/domain/contract/entities/candidate_entity.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/widgets/widgets.dart';

const String IMAGE_PHOTO = 'https://i.pinimg.com/564x/b5/19/65/b5196523468e198c8d6f09dd6320855f.jpg';

class CandidateItemWidget extends StatefulWidget {
  const CandidateItemWidget(
      {super.key,
      this.onTapLeading,
      this.onTapName,
      this.onTapCv,
      this.onTapChat,
      this.onTap,
      required this.candidateEntity});

  final double leadingSize = 50;
  final VoidCallback? onTapLeading;
  final VoidCallback? onTapName;
  final VoidCallback? onTap;
  final VoidCallback? onTapChat;
  final VoidCallback? onTapCv;
  final CandidateEntity candidateEntity;

  @override
  State<CandidateItemWidget> createState() => _CandidateItemWidgetState();
}

class _CandidateItemWidgetState extends State<CandidateItemWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
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
                  child: CachedNetworkImage(
                    imageUrl: widget.candidateEntity.worker.avatar,
                    width: widget.leadingSize,
                    height: widget.leadingSize,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CupertinoActivityIndicator(),
                    filterQuality: FilterQuality.high,
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
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: widget.onTapName,
                    child: Text(
                      widget.candidateEntity.worker.name,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground,
                      )),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CandidateCvItemWidget(
                    cvName: widget.candidateEntity.cv.url,
                    onTap: widget.onTapCv,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
