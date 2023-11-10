import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/state.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/widgets/add_business_card.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/widgets/search_add_business.dart';
import 'package:wflow/common/injection.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  late TextEditingController _controller;
  late final ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBusinessBloc(userUseCase: instance.get<UserUseCase>())
        ..add(InitAddBusinessEvent()),
      child: BlocBuilder<AddBusinessBloc, AddBusinessState>(
        builder: (context, state) {
          _scrollController.addListener(() {
            if (_scrollController.position.maxScrollExtent ==
                    _scrollController.offset &&
                !state.isLoadMore) {
              BlocProvider.of<AddBusinessBloc>(context)
                  .add(LoadMoreAddBusinessEvent());
              BlocProvider.of<AddBusinessBloc>(context)
                  .add(ScrollAddBusinessEvent());
            }
          });
          return BlocListener<AddBusinessBloc, AddBusinessState>(
            listenWhen: (previous, current) => previous != current,
            listener: _listener,
            child: Scaffold(
              appBar: AppHeader(
                text: 'Add to business',
                actionTitle: 'add',
                onTap: () => BlocProvider.of<AddBusinessBloc>(context).add(
                    AddCollaboratorAddBusinessEvent(
                        usersChecked: state.usersChecked)),
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    SearchAddBusiness(
                      controller: _controller,
                      isHiddenSuffixIcon: state.isHiddenSuffixIcon,
                      onChangedSearch: (value) => {
                        BlocProvider.of<AddBusinessBloc>(context).add(
                            ChangedIconClearAddBusinessEvent(txtSearch: value)),
                        if (_debounce?.isActive ?? false) _debounce?.cancel(),
                        _debounce =
                            Timer(const Duration(milliseconds: 400), () {
                          BlocProvider.of<AddBusinessBloc>(context)
                              .add(SearchAddBusinessEvent(txtSearch: value));
                        }),
                      },
                      onClearSearch: () => {
                        _controller.clear(),
                        BlocProvider.of<AddBusinessBloc>(context).add(
                            const ChangedIconClearAddBusinessEvent(
                                txtSearch: '')),
                        BlocProvider.of<AddBusinessBloc>(context)
                            .add(const SearchAddBusinessEvent(txtSearch: '')),
                      },
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async =>
                            BlocProvider.of<AddBusinessBloc>(context)
                                .add(RefreshAddBusinessEvent()),
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return AddBusinessCard(
                              image: state.users[index].avatar,
                              name: state.users[index].name,
                              email: state.users[index].email,
                              isCheck: state.usersChecked
                                  .contains(state.users[index].id),
                              onCheck: (value) =>
                                  BlocProvider.of<AddBusinessBloc>(context).add(
                                      UserCheckedAddBusinessEvent(
                                          isChecked: value!,
                                          id: state.users[index].id)),
                            );
                          },
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (state.isLoadMore) {
                          return Visibility(
                            visible: state.isLoadMore,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: const Loading(),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _listener(BuildContext context, AddBusinessState state) async {
    if (state is LoadFailureAddBusinessState) {
      showDialog(
        state.message,
        () => Navigator.of(context)
          ..pop()
          ..pop(),
      );
    } else if (state is AddCollaboratorFailedAddBusinessState) {
      showDialog(state.message, () => Navigator.of(context).pop());
    } else if (state is AddCollaboratorSuccessedAddBusinessState) {
      showDialog(state.message, () => Navigator.of(context).pop());
    }
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
}
