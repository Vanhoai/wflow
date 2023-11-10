import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/widgets/custom/circular_avatar_touch/circular_avatar_touch.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/company_about/company_information.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/company_about/company_new_job.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/company_about/company_top_candidate.dart';

class CompanyAboutWidget extends StatefulWidget {
  final TabController tabController;

  const CompanyAboutWidget({super.key, required this.tabController});

  @override
  State<CompanyAboutWidget> createState() => _CompanyAboutWidgetState();
}

class _CompanyAboutWidgetState extends State<CompanyAboutWidget> {
  late final ScrollController scrollController;
  late final ScrollController newJobController;
  late final ScrollController topJobController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0);
    newJobController = ScrollController(initialScrollOffset: 0);
    topJobController = ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    newJobController.dispose();
    scrollController.dispose();
    topJobController.dispose();
    super.dispose();
  }

  _refreshListener(BuildContext context) {
    context.read<MyCompanyBloc>().add(const GetMyCompanyEvent(isLoading: true, message: 'Start load company'));
  }

  Widget _buildVisible() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: CupertinoActivityIndicator(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      buildWhen: (previous, current) =>
          previous.isLoadingCompany != current.isLoadingCompany || previous.companyEntity != current.companyEntity,
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;
        return Visibility(
          visible: !state.isLoadingCompany,
          replacement: _buildVisible(),
          child: RefreshIndicator(
            onRefresh: () async => _refreshListener(context),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 20.h),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    padding: EdgeInsets.all(10.r),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                            imageUrl:
                                'https://t4.ftcdn.net/jpg/05/49/86/39/360_F_549863991_6yPKI08MG7JiZX83tMHlhDtd6XLFAMce.jpg',
                            placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) => const Center(child: CupertinoActivityIndicator()),
                            filterQuality: FilterQuality.high,
                            fadeInCurve: Curves.easeIn,
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeOutCurve: Curves.easeOut,
                            fadeOutDuration: const Duration(milliseconds: 500),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 150.h,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: double.infinity,
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                          bottom: 0,
                          left: 10.w,
                          child: CircularAvatarTouch(
                            height: 60.h,
                            width: 60.h,
                            onTap: () {},
                            imageUrl: companyEntity.logo == '' ? null : companyEntity.logo,
                          ),
                        )
                      ],
                    ),
                  ),
                  CompanyInformationWidget(companyEntity: companyEntity, tabController: widget.tabController),
                  CompanyNewJobWidget(scrollController: newJobController, tabController: widget.tabController),
                  CompanyTopCandidate(scrollController: topJobController, tabController: widget.tabController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
