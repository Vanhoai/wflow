import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/state.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/widgets/add_business_card.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key, required this.business});

  final String business;

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  late TextEditingController controller;
  late final ScrollController scrollController;

  @override
  void initState() {
    controller = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> showDialog(String message, Function()? onPressed) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'Notification',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text('OK'),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => AddBusinessBloc(
        userUseCase: instance.get<UserUseCase>(),
      )..add(InitAddBusinessEvent()),
      child: BlocBuilder<AddBusinessBloc, AddBusinessState>(
        builder: (context, state) {
          scrollController.addListener(() {
            if (scrollController.position.maxScrollExtent == scrollController.offset) {
              BlocProvider.of<AddBusinessBloc>(context).add(LoadMoreAddBusinessEvent());
            }
          });

          return Scaffold(
            appBar: AppHeader(
              text: Text(
                'Add to business',
                style: themeData.textTheme.displayMedium,
              ),
              onBack: () {
                Navigator.of(context).pushReplacementNamed(
                  RouteKeys.companyScreen,
                  arguments: widget.business,
                );
              },
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<AddBusinessBloc>(context).add(AddCollaboratorAddBusinessEvent());
                    },
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SharedSearchBar(
                    placeHolder: 'Search by name or email',
                    onSearch: (value) {
                      BlocProvider.of<AddBusinessBloc>(context).add(SearchAddBusinessEvent(search: value));
                    },
                    onClear: () {
                      BlocProvider.of<AddBusinessBloc>(context).add(RefreshAddBusinessEvent());
                    },
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => BlocProvider.of<AddBusinessBloc>(context).add(RefreshAddBusinessEvent()),
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return AddBusinessCard(
                            image: state.users[index].avatar,
                            name: state.users[index].name,
                            email: state.users[index].email,
                            isCheck: state.usersChecked.contains(state.users[index].id),
                            onCheck: (value) => BlocProvider.of<AddBusinessBloc>(context).add(
                              UserCheckedAddBusinessEvent(isChecked: value!, id: state.users[index].id),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
