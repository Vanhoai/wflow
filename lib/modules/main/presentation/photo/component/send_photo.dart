import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/event.dart';
import 'package:wflow/modules/main/presentation/photo/bloc/state.dart';

class SendPhoto extends StatelessWidget {
  const SendPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is SendMultiplePhotoState) {
          Navigator.of(context).pop(state.photoFile);
        }else {
          Navigator.of(context).pop((state as SendSinglePhotoState).file);
        }
      },
      listenWhen: (previous, current) => current is SendMultiplePhotoState || current is SendSinglePhotoState,
      builder: (context, state) {
        if (state is PhotoSingleState) {
          return const SizedBox();
        } else if (state is PhotoMultipleState && state.entities.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () {
              state.entities[0].file.then((value) => print(value));
              context.read<PhotoBloc>().add(SendPhotoEvent());
            },
            child: const Icon(Icons.send),
          );
        }
        return const SizedBox();
      },
    );
  }
}
