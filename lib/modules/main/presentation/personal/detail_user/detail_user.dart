import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/bloc/state.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/widget/menu.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/shimmer_user.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen({super.key, required this.id});
  final num id;
  @override
  State<StatefulWidget> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailUserBloc(userUseCase: instance.get<UserUseCase>())..add(GetUserInfo(id: widget.id)),
      child: BlocBuilder<DetailUserBloc, DetailUserState>(
        builder: (context, state) {
          return CommonScaffold(
            hideKeyboardWhenTouchOutside: true,
            isSafe: true,
            appBar: const AppHeader(
              text: 'Profile',
            ),
            body: Visibility(
              visible: (state is GetDetailUserSuccess),
              replacement: const ShimmerUser(),
              child: RefreshIndicator(
                onRefresh: () async => context.read<DetailUserBloc>().add(GetUserInfo(id: widget.id)),
                child: Builder(
                  builder: (context) {
                    if (state is GetDetailUserSuccess) {
                      return UserMenu(
                        userID: state.userEntity.id,
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.only(top: 0.h, left: 20.w, right: 20.w),
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
                                              imageUrl: state.userEntity.background == ''
                                                  ? 'https://picsum.photos/200'
                                                  : state.userEntity.background,
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
                                              state.userEntity.avatar == ''
                                                  ? 'https://picsum.photos/200'
                                                  : state.userEntity.avatar,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 60.h),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.userEntity.name,
                                      style: themeData.textTheme.displayLarge!
                                          .copyWith(color: Theme.of(context).colorScheme.onBackground),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    8.verticalSpace,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.userEntity.email,
                                          style: themeData.textTheme.displayMedium!.copyWith(
                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Builder(
                                          builder: (context) {
                                            if (state.userEntity.business != 0) {
                                              return Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '|',
                                                    style: themeData.textTheme.displayMedium!.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground
                                                            .withOpacity(0.5)),
                                                  ),
                                                  InkWell(
                                                    borderRadius: BorderRadius.circular(4),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      child: Text(
                                                        'Company',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium!
                                                            .copyWith(color: AppColors.primary),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context).pushNamed(RouteKeys.companyScreen,
                                                          arguments: '${state.userEntity.business}');
                                                    },
                                                  ),
                                                ],
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        )
                                      ],
                                    ),
                                    24.verticalSpace,
                                    Text(
                                      state.userEntity.bio,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      style: themeData.textTheme.displayMedium!
                                          .copyWith(color: Theme.of(context).colorScheme.onBackground),
                                    ),
                                    20.verticalSpace,
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Reputation',
                                                style: themeData.textTheme.displayMedium!
                                                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
                                              ),
                                              4.verticalSpace,
                                              Text(
                                                state.userEntity.reputation.toString(),
                                                style: themeData.textTheme.displayLarge!.copyWith(
                                                    color: Theme.of(context).colorScheme.onBackground, fontSize: 22.sp),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                                            child: const VerticalDivider(
                                              color: Colors.grey,
                                              thickness: 1,
                                              indent: 5,
                                              endIndent: 5,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Worked',
                                                style: themeData.textTheme.displayMedium!
                                                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
                                              ),
                                              4.verticalSpace,
                                              Text(
                                                state.userEntity.workDone.toString(),
                                                style: themeData.textTheme.displayLarge!.copyWith(
                                                    color: Theme.of(context).colorScheme.onBackground, fontSize: 22.sp),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    24.verticalSpace,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('No infomation', style: themeData.textTheme.bodyLarge),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
