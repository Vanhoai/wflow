import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

class CompanyTopCandidate extends StatefulWidget {
  final ScrollController scrollController;
  final TabController tabController;
  const CompanyTopCandidate({super.key, required this.scrollController, required this.tabController});

  @override
  State<CompanyTopCandidate> createState() => _CompanyTopCandidateState();
}

class _CompanyTopCandidateState extends State<CompanyTopCandidate> {
  Widget _buildVisible(BoxConstraints constraints, ThemeData themeData) {
    return ShimmerWork(
      height: constraints.maxHeight,
      width: constraints.maxWidth * 0.8,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: themeData.colorScheme.onBackground.withOpacity(0.8),
          width: 2,
        ),
      ),
    );
  }

  void _pressCard(num work) {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen, arguments: work);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(10.r),
          child: Text('Top jobs', style: themeData.textTheme.displayMedium),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 280),
          child: BlocBuilder<MyCompanyBloc, MyCompanyState>(
            buildWhen: (previous, current) => previous.isLoadingPost != current.isLoadingPost,
            builder: (context, state) {
              final List<PostEntity> newPost = state.listPost;
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Visibility(
                    visible: !state.isLoadingPost,
                    replacement: _buildVisible(constraints, themeData),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => 10.horizontalSpace,
                      controller: widget.scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: newPost.length,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      itemBuilder: (context, index) {
                        final PostEntity job = newPost[index];
                        if (index == newPost.length - 1) {
                          return Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () => widget.tabController.animateTo(1),
                              icon: const Icon(Icons.more_horiz),
                            ),
                          );
                        }
                        return Container(
                          width: constraints.maxWidth * 0.8,
                          height: constraints.maxHeight,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: JobCard(
                            isHorizontal: true,
                            boxDecoration: BoxDecoration(
                              color: themeData.colorScheme.background,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            cardPressed: () => _pressCard(job.id),
                            padding: EdgeInsets.all(12.r),
                            header: Header(
                              leadingPhotoUrl: job.companyLogo,
                              title: Text(
                                job.position,
                                style: themeData.textTheme.displayLarge!.copyWith(
                                  fontSize: 18.sp,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                job.companyName,
                                style: themeData.textTheme.displayMedium!.copyWith(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTapLeading: () {},
                              leadingSize: 32.r,
                              actions: [
                                InkWell(
                                  child: SvgPicture.asset(
                                    AppConstants.bookmark,
                                    height: 24.h,
                                    width: 24.h,
                                    colorFilter: ColorFilter.mode(
                                      themeData.colorScheme.onBackground.withOpacity(0.5),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                8.horizontalSpace,
                              ],
                            ),
                            cost: '${job.salary} VND',
                            duration: job.duration,
                            description: TextMore(
                              job.content,
                              trimMode: TrimMode.Hidden,
                              trimHiddenMaxLines: 3,
                              style: themeData.textTheme.displayMedium!
                                  .copyWith(color: themeData.colorScheme.onBackground),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
