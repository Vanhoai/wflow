import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

class CompanyJobPostWidget extends StatefulWidget {
  const CompanyJobPostWidget({super.key});

  @override
  State<CompanyJobPostWidget> createState() => _CompanyJobPostWidgetState();
}

class _CompanyJobPostWidgetState extends State<CompanyJobPostWidget> {
  int page = 1;
  int pageSize = 10;

  void fetchPost({int? page, int? pageSize}) {
    context.read<MyCompanyBloc>().add(
          GetMyPostCompanyEvent(
            isLoading: true,
            message: 'Start load post',
            page: page ?? 1,
            pageSize: pageSize ?? 10,
          ),
        );
  }

  void pressCard(num work) {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen, arguments: work);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 280),
      child: BlocBuilder<MyCompanyBloc, MyCompanyState>(
        buildWhen: (previous, current) =>
            previous.isLoadingPost != current.isLoadingPost || previous.listPost != current.listPost,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => fetchPost(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Visibility(
                  visible: !state.isLoadingPost,
                  replacement: ShimmerWork(
                    physics: const NeverScrollableScrollPhysics(),
                    height: 280,
                    width: double.infinity,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.only(bottom: 10, left: 20.w, right: 20.w, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: themeData.colorScheme.onBackground.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 12.verticalSpace,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.listPost.length,
                    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h, bottom: 20.h),
                    itemBuilder: (context, index) {
                      final job = state.listPost[index];

                      return Container(
                        constraints: const BoxConstraints(maxHeight: 270),
                        child: JobCard(
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
                          cardPressed: () => pressCard(job.id),
                          padding: EdgeInsets.all(12.r),
                          header: Header(
                            leadingPhotoUrl: job.companyLogo,
                            title: Text(
                              job.position,
                              style: themeData.textTheme.displayLarge!.merge(
                                TextStyle(
                                  fontSize: 18.sp,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              job.companyName,
                              style: themeData.textTheme.displayMedium!.merge(
                                TextStyle(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            onTapLeading: () {},
                            leadingSize: 30,
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
                            style: themeData.textTheme.displayMedium!.merge(
                              TextStyle(
                                color: themeData.colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
