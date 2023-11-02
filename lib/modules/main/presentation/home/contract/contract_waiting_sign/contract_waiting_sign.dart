import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_waiting_sign/bloc/bloc.dart';

class ContractWaitingSignScreen extends StatefulWidget {
  const ContractWaitingSignScreen({super.key});

  @override
  State<ContractWaitingSignScreen> createState() => _ContractWaitingSignScreenState();
}

class _ContractWaitingSignScreenState extends State<ContractWaitingSignScreen> {
  void onClear() {}

  void onSearch(String value) {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContractWaitingSignBloc(
        contractUseCase: instance.get<ContractUseCase>(),
      )..add(ContractWaitingSignEventFetch()),
      child: CommonScaffold(
        hideKeyboardWhenTouchOutside: true,
        appBar: const AppHeader(text: 'Contract Waiting Sign'),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SharedSearchBar(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                onClear: onClear,
                onSearch: onSearch,
              ),
              Expanded(
                child: Container(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: 40,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: themeData.colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(48.r),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://picsum.photos/200',
                                    placeholder: (context, url) =>
                                        const Center(child: CupertinoActivityIndicator(radius: 16)),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    fadeInCurve: Curves.easeIn,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    height: 48.w,
                                    width: 48.w,
                                  ),
                                ),
                                12.horizontalSpace,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Flutter Developer', style: themeData.textTheme.labelLarge),
                                      Text('Google', style: themeData.textTheme.labelMedium),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      AppConstants.ic_clock,
                                      height: 16.w,
                                      width: 16.w,
                                    ),
                                    const Text('2 min ago'),
                                  ],
                                )
                              ],
                            ),
                            12.verticalSpace,
                            Text(
                              'Google has just created a contract and is waiting for you to accept the job 🤑️',
                              maxLines: 2,
                              style: themeData.textTheme.labelMedium,
                            ),
                            12.verticalSpace,
                            Row(
                              children: [
                                Text('Not money available', style: themeData.textTheme.labelMedium),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
