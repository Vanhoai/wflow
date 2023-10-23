import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wflow/configuration/constants.dart';

import 'common_util.dart';
import 'live_photos_widget.dart';
import 'video_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.entity}) : super(key: key);

  final AssetEntity entity;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool? useOrigin = true;
  bool? useMediaUrl = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.titleLarge,
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
              child: SvgPicture.asset(
                AppConstants.backArrow,
                height: 19,
                width: 19,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _showInfo,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (widget.entity.isLivePhoto) {
      return LivePhotosWidget(
        entity: widget.entity,
        useOrigin: useOrigin == true,
      );
    }
    if (widget.entity.type == AssetType.video || widget.entity.type == AssetType.audio || widget.entity.isLivePhoto) {
      return buildVideo();
    }
    return buildImage();
  }

  Widget buildImage() {
    return AssetEntityImage(
      widget.entity,
      isOriginal: useOrigin == true,
      fit: BoxFit.fill,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? progress,
      ) {
        if (progress == null) {
          return child;
        }
        final double? value;
        if (progress.expectedTotalBytes != null) {
          value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
        } else {
          value = null;
        }
        return Center(
          child: SizedBox.fromSize(
            size: const Size.square(30),
            child: CircularProgressIndicator(value: value),
          ),
        );
      },
    );
  }

  Widget buildVideo() {
    return VideoWidget(
      entity: widget.entity,
      usingMediaUrl: useMediaUrl ?? true,
    );
  }

  Future<void> _showInfo() {
    return CommonUtil.showInfoDialog(context, widget.entity);
  }

  Widget buildAudio() {
    return const Center(child: Icon(Icons.audiotrack));
  }
}
