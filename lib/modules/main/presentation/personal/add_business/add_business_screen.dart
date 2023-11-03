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

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBusinessBloc(userUseCase: instance.get<UserUseCase>())
        ..add(InitAddBusinessEvent()),
      child: BlocBuilder<AddBusinessBloc, AddBusinessState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppHeader(
              text: 'Add to business',
              onTap: () => {},
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SearchAddBusiness(
                    controller: _controller,
                    isHiddenSuffixIcon: state.isHiddenSuffixIcon,
                    onChangedSearch: (value) => {},
                    onClearSearch: () => {},
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return AddBusinessCard(
                          image: state.users[index].avatar,
                          name: state.users[index].name,
                          email: state.users[index].email,
                          isCheck: state.usersChecked
                              .contains(state.users[index].id),
                          onCheck: (value) => {},
                        );
                      },
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
