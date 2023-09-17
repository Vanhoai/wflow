import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/personal/file/bloc/file_bloc.dart';
import 'package:wflow/modules/main/presentation/personal/file/bloc/file_event.dart';
import 'package:wflow/modules/main/presentation/personal/file/bloc/file_state.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileBloc>(
      create: (BuildContext context) => FileBloc(),
      lazy: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: BlocBuilder<FileBloc, FileState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<FileBloc>().add(const FileClearEvent());
              },
              child: const Icon(Icons.clear),
            );
          },
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('File Screen'),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: BlocBuilder<FileBloc, FileState>(
                    builder: (context, state) {
                      if (state is FileInitial) {
                        return Container(
                          child: Center(
                            child: Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      context.read<FileBloc>().add(const FilePickEvent());
                                    },
                                    child: const Text("Pick File")),
                                ElevatedButton(
                                    onPressed: () {
                                      context.read<FileBloc>().add(const FilePickMultipleEvent());
                                    },
                                    child: const Text("Pick Multiple File")),
                              ],
                            ),
                          ),
                        );
                      } else if (state is FileSuccessState) {
                        switch (state.files.length) {
                          case 0:
                            return Container(
                              child: const Center(
                                child: Text("No file selected"),
                              ),
                            );
                          case 1:
                            return Scaffold(
                              body: Container(
                                child: Center(
                                  child: Text(state.files[0].toString().toString()),
                                ),
                              ),
                            );
                          default:
                            return Scaffold(
                              body: Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      for (var i = 0; i < state.files.length; i++)
                                        Text("${i.toString() + state.files[i].toString()} \n"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                        }
                      } else if (state is FileFailureState) {
                        return Container(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else if (state is FileCancelState) {
                        return Container(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else if (state is FileClearState) {
                        return Container(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container(
                          child: const Center(
                            child: Text('Unknown error'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
