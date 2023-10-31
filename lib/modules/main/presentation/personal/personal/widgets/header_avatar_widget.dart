import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
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
                      child: Image.network(userEntity.avatar == '' ? 'https://picsum.photos/200' : userEntity.avatar,
                          fit: BoxFit.cover),
                    ),
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
                        backgroundImage: NetworkImage(
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
