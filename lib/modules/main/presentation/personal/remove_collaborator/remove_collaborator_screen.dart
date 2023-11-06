import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/state.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/widgets/collaborator_card.dart';

class RemoveCollaboratorScreen extends StatefulWidget {
  const RemoveCollaboratorScreen({super.key});

  @override
  State<RemoveCollaboratorScreen> createState() =>
      _RemoveCollaboratorScreenState();
}

class _RemoveCollaboratorScreenState extends State<RemoveCollaboratorScreen> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RemoveCollaboratorBloc(userUseCase: instance.get<UserUseCase>())
            ..add(GetAllCollaboratorEvent()),
      child: BlocBuilder<RemoveCollaboratorBloc, RemoveCollaboratorState>(
        builder: (context, state) {
          _scrollController.addListener(() {
            if (_scrollController.position.maxScrollExtent ==
                    _scrollController.offset &&
                !state.isLoadMore) {
              BlocProvider.of<RemoveCollaboratorBloc>(context)
                  .add((LoadMoreCollaboratorEvent()));
              BlocProvider.of<RemoveCollaboratorBloc>(context)
                  .add(ScrollCollaboratorEvent());
            }
          });
          return Scaffold(
            appBar: AppHeader(
              text: 'Members in your business',
              actionTitle: 'remove',
              onTap: () => BlocProvider.of<RemoveCollaboratorBloc>(context)
                  .add(DeleteCollaboratorEvent()),
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.users.length,
                      itemBuilder: (context, index) => CollaboratorCard(
                        name: state.users[index].name,
                        email: state.users[index].email,
                        image: state.users[index].avatar,
                        role: state.users[index].role,
                        isCheck:
                            state.usersChecked.contains(state.users[index].id),
                        onCheck: (value) =>
                            BlocProvider.of<RemoveCollaboratorBloc>(context)
                                .add(CheckedCollaboratorEvent(
                                    isChecked: value!,
                                    id: state.users[index].id)),
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
          );
        },
      ),
    );
  }
}
