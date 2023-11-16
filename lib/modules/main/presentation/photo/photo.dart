import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/photo/component/detail_page.dart';

import 'bloc/event.dart';
import 'component/image_item_widget.dart';
import 'component/send_photo.dart';

class PhotoScreen extends StatefulWidget {
  final ArgumentsPhoto argumentsPhoto;
  const PhotoScreen({Key? key, required this.argumentsPhoto}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  /// Customize your own filter options.

  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;

  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  Future<void> _requestAssets() async {
    setState(() {
      _isLoading = true;
    });
    // Request permissions.
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!mounted) {
      return;
    }
    // Further requests can be only proceed with authorized or limited.
    if (!ps.hasAccess) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // Obtain assets using the path entity.
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: widget.argumentsPhoto.onlyImage ? RequestType.image : RequestType.common,
      filterOption: _filterOptionGroup,
    );
    if (!mounted) {
      return;
    }
    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _path = paths.first;
    });
    _totalEntitiesCount = await _path!.assetCountAsync;
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _requestAssets();
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (_path == null) {
      return const Center(child: Text('Request paths first.'));
    }
    if (_entities?.isNotEmpty != true) {
      return const Center(child: Text('No assets found on this device.'));
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == _entities!.length - 8 && !_isLoadingMore && _hasMoreToLoad) {
            _loadMoreAsset();
          }
          final AssetEntity entity = _entities![index];
          return ImageItemWidget(
            key: ValueKey<int>(index),
            entity: entity,
            onTap: () {
              if (widget.argumentsPhoto.multiple) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(entity: entity)));
              } else {
                context.read<PhotoBloc>().add(SendPhotoEvent(entity: entity));
              }
            },
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
          );
        },
        childCount: _entities!.length,
        findChildIndexCallback: (Key key) {
          // Re-use elements.
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (context) => PhotoBloc()..add(OnSelectMultipleEvent(multiple: widget.argumentsPhoto.multiple)),
      child: CommonScaffold(
          appBar: AppHeader(text: 'Chọn ảnh', actions: [
            Builder(
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.only(right: 10, top: 4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      _getImageFromCamera(context: context);
                    },
                    child: Ink(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.camera,
                          color: Colors.white,
                        )),
                  ),
                );
              },
            )
          ]),
          body: Column(
            children: [
              Expanded(child: _buildBody(context)),
            ],
          ),
          floatingActionButton: const SendPhoto()),
    );
  }

  _getImageFromCamera({required BuildContext context}) async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result == null) return;
    File file = File(result.path);
    if (!widget.argumentsPhoto.multiple && context.mounted) {
      BlocProvider.of<PhotoBloc>(context).add(SendPhotoFromCameraEvent(file: file));
    } else if (widget.argumentsPhoto.multiple && context.mounted) {
      BlocProvider.of<PhotoBloc>(context).add(SendPhotosFromCameraEvent(files: [file]));
    }
  }
}
