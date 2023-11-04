import 'package:dartz/dartz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/core/http/http.dart';
import 'package:wflow/modules/main/data/user/models/request/get_user_not_business_model.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/bloc/state.dart';

class AddBusinessBloc extends Bloc<AddBusinessEvent, AddBusinessState> {
  final UserUseCase userUseCase;
  final int defaultPage = 1;
  final int defaultPageSize = 3;
  final String defaultSearch = '';

  AddBusinessBloc({required this.userUseCase})
      : super(const AddBusinessState()) {
    on<InitAddBusinessEvent>(onInitAddBusiness);
    on<SearchAddBusinessEvent>(onSearchAddBusiness);
    on<ChangedIconClearAddBusinessEvent>(onChangedIconClearAddBusiness);
    on<ScrollAddBusinessEvent>(onScrollAddBusiness);
    // on<RefreshSearchWorkEvent>(onRefreshSearchWork);
    // on<LoadMoreSearchWorkEvent>(onLoadMoreSearchWork);
  }

  Future<void> onInitAddBusiness(
      InitAddBusinessEvent event, Emitter emit) async {
    GetUserNotBusinessModel getUserNotBusinessModel =
        const GetUserNotBusinessModel();
    final Either<List<UserEntity>, Failure> result =
        await userUseCase.getUsersNotBusiness(getUserNotBusinessModel);
    result.fold(
      (List<UserEntity> l) {
        emit(state.copyWith(users: l));
      },
      (Failure r) {
        emit(state.copyWith());
      },
    );
  }

  Future<void> onSearchAddBusiness(
      SearchAddBusinessEvent event, Emitter emit) async {}
  Future<void> onChangedIconClearAddBusiness(
      ChangedIconClearAddBusinessEvent event, Emitter emit) async {}
  Future<void> onScrollAddBusiness(
      ScrollAddBusinessEvent event, Emitter emit) async {}
}
