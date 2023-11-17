import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_usecase.dart';

part 'reputation_event.dart';
part 'reputation_state.dart';

class ReputationBloc extends Bloc<ReputationEvent, ReputationState> {
  final FeedbackUseCase feedbackUseCase;

  ReputationBloc({
    required this.feedbackUseCase,
  }) : super(ReputationState(feedbacks: const [], reputationEntity: ReputationEntity.createEmpty())) {
    on<ReputationLoad>(onReputationLoad);
    on<FeedbackLoad>(onFeedbackLoad);
  }

  Future onReputationLoad(ReputationLoad event, Emitter<ReputationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response = await feedbackUseCase.findReputation();
      response.fold(
        (reputationEntity) {
          emit(state.copyWith(
            reputationEntity: reputationEntity,
          ));
        },
        (failure) {},
      );
    } catch (e) {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future onFeedbackLoad(FeedbackLoad event, Emitter<ReputationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response = await feedbackUseCase.findFeedbackOfUser();
      response.fold(
        (list) {
          emit(state.copyWith(feedbacks: list));
        },
        (failure) {
          emit(state.copyWith(
            feedbacks: const [],
          ));
        },
      );
    } catch (e) {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }
}
