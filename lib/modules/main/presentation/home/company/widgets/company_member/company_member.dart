import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

class CompanyMemberWidget extends StatefulWidget {
  const CompanyMemberWidget({super.key});

  @override
  State<CompanyMemberWidget> createState() => _CompanyMemberWidgetState();
}

class _CompanyMemberWidgetState extends State<CompanyMemberWidget> {
  int page = 1;
  int pageSize = 10;

  void fetchUser({int? page, int? pageSize}) {
    context.read<MyCompanyBloc>().add(
          GetMyMemberCompanyEvent(
            isLoading: true,
            message: 'Start load member',
            page: page ?? 1,
            pageSize: pageSize ?? 10,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      buildWhen: (previous, current) =>
          previous.isLoadingMember != current.isLoadingMember || previous.listUser != current.listUser,
      builder: (context, state) {
        return Visibility(
          visible: !state.isLoadingMember,
          replacement: Shimmer.fromColors(
            baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
            highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 4.h),
                  child: Header(
                    title: Flexible(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 20.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                    subtitle: Container(
                      height: 20.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    onTapLeading: () {},
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
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              fetchUser();
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final UserEntity userEntity = state.listUser[index];
                return Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 4.h),
                  child: Header(
                    title: Text(
                      userEntity.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: themeData.textTheme.displayMedium!,
                    ),
                    subtitle: Text(userEntity.email.toString()),
                    onTapLeading: () {},
                    leadingPhotoUrl: userEntity.avatar.toString(),
                    actions: const [],
                  ),
                );
              },
              itemCount: state.listUser.length,
            ),
          ),
        );
      },
    );
  }
}
