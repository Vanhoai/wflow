import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/event.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/state.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({
    Key? key,
    required this.entity,
    required this.option,
    this.onTap,
  }) : super(key: key);

  final AssetEntity entity;
  final ThumbnailOption option;
  final GestureTapCallback? onTap;

  Widget buildContent(BuildContext context) {
    if (entity.type == AssetType.audio) {
      return const Center(
        child: Icon(Icons.audiotrack, size: 30),
      );
    }
    return _buildImageWidget(context, entity, option);
  }

  Widget _buildImageWidget(
    BuildContext context,
    AssetEntity entity,
    ThumbnailOption option,
  ) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (BuildContext context, state) {
        bool select = false;
        if (state is PhotoMultipleState) {
          select = state.entities.indexWhere((element) => element.id == entity.id) != -1 ? true : false;
        }
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: AssetEntityImage(
                entity,
                isOriginal: false,
                thumbnailSize: option.size,
                thumbnailFormat: option.format,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              bottom: 4,
              start: 0,
              end: 0,
              child: Row(
                children: [
                  if (entity.isFavorite)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 16,
                      ),
                    ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (entity.isLivePhoto)
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: Theme.of(context).cardColor,
                            ),
                            child: const Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                        Icon(
                          () {
                            switch (entity.type) {
                              case AssetType.other:
                                return Icons.abc;
                              case AssetType.image:
                                return Icons.image;
                              case AssetType.video:
                                return Icons.play_circle;
                              case AssetType.audio:
                                return Icons.audiotrack;
                            }
                          }(),
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (state is PhotoMultipleState) {
                    return GestureDetector(
                      onTap: () {
                        if (!select) {
                          context.read<PhotoBloc>().add(SelectPhotoEvent(entity: entity));
                        } else {
                          context.read<PhotoBloc>().add(UnSelectPhotoEvent(entity: entity));
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(9),
                        child: Container(
                          decoration: BoxDecoration(
                              color: select ? AppColors.primary : Colors.black12,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5)),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: buildContent(context),
    );
  }
}
