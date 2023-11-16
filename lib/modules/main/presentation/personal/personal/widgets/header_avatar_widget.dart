import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/presentation/personal/personal/bloc/bloc.dart';

class HeaderAvatarWidget extends StatefulWidget {
  const HeaderAvatarWidget({super.key});

  @override
  State<HeaderAvatarWidget> createState() => _HeaderAvatarWidgetState();
}

class _HeaderAvatarWidgetState extends State<HeaderAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalBloc, PersonalState>(
      buildWhen: (previous, current) =>
          previous.userEntity != current.userEntity || previous.isLoading != current.isLoading,
      builder: (context, state) {
        final UserEntity userEntity = state.userEntity;
        return SliverPadding(
          padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 260,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: userEntity.background == '' ? 'https://picsum.photos/200' : userEntity.background,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          filterQuality: FilterQuality.high,
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                          userEntity.avatar == '' ? 'https://picsum.photos/200' : userEntity.avatar,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
