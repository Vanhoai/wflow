import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shimmer_work/shimmer_work.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/my_company_bloc.dart';

class CompanyMemberWidget extends StatefulWidget {
  const CompanyMemberWidget({super.key});

  @override
  State<CompanyMemberWidget> createState() => _CompanyMemberWidgetState();
}

class _CompanyMemberWidgetState extends State<CompanyMemberWidget> {
  int page = 1;
  int pageSize = 10;

  void fetchUser({int? page, int? pageSize}) {
    context.read<MyCompanyBloc>().add(GetMyMemberCompanyEvent(
        isLoading: true, message: 'Start load member', page: page ?? 1, pageSize: pageSize ?? 10));
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
          replacement: ShimmerWork(
            physics: const NeverScrollableScrollPhysics(),
            height: 280,
            width: double.infinity,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            itemCount: 1,
            margin: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: themeData.colorScheme.onBackground.withOpacity(0.8),
                width: 1,
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20, top: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final name = context.watch<MyCompanyBloc>().state.listUser[index].name;
                final phone = context.watch<MyCompanyBloc>().state.listUser[index].phone;
                final img = context.watch<MyCompanyBloc>().state.listUser[index].avatar;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Header(
                    title: Flexible(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: themeData.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    subtitle: Text(phone),
                    onTapLeading: () {},
                    leadingPhotoUrl: img,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(AppConstants.more),
                      ),
                    ],
                  ),
                );
              },
              itemCount: context.watch<MyCompanyBloc>().state.listUser.length,
            ),
          ),
        );
      },
    );
  }
}
