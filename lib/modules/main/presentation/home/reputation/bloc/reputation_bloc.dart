import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_usecase.dart';

part 'reputation_event.dart';
part 'reputation_state.dart';

class ReputationBloc extends Bloc<ReputationEvent, ReputationState> {
  final FeedbackUseCase feedbackUseCase;

  ReputationBloc({
    required this.feedbackUseCase,
  }) : super(ReputationState(feedbacks: const [], reputationEntity: ReputationEntity.createEmpty(), isLoading: true)) {
    on<ReputationLoad>(onReputationLoad);
    on<FeedbackLoad>(onFeedbackLoad);
  }

  Future onReputationLoad(ReputationLoad event, Emitter<ReputationState> emit) async {
    instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
    emit(state.copyWith(isLoading: true));
    final response = await feedbackUseCase.findReputation();
    response.fold(
      (reputationEntity) {
        emit(state.copyWith(reputationEntity: reputationEntity));
      },
      (failure) {
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), failure.message);
      },
    );
    emit(state.copyWith(isLoading: false));
    instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
  }

  Future onFeedbackLoad(FeedbackLoad event, Emitter<ReputationState> emit) async {
    instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
    emit(state.copyWith(isLoading: false));
    final response = await feedbackUseCase.findFeedbackOfUser();
    response.fold(
      (list) {
        emit(state.copyWith(feedbacks: list));
      },
      (failure) {
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), failure.message);
      },
    );
    emit(state.copyWith(isLoading: false));
    instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
  }
}
