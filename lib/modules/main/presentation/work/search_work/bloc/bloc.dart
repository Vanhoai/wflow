import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/data/post/models/request/get_work_model.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/state.dart';

class SearchWorkBloc extends Bloc<SearchWorkEvent, SearchWorkState> {
  final PostUseCase postUseCase;

  SearchWorkBloc({required this.postUseCase}) : super(const SearchWorkState()) {
    on<ChangedSearchWorkEvent>(onChangedSearchWork);
  }

  Future<void> onChangedSearchWork(
      ChangedSearchWorkEvent event, Emitter emit) async {
    GetWorkModel getWorkModel =
        GetWorkModel(page: 1, pageSize: 12, search: event.txtSearch);
    final List<PostEntity> posts =
        await postUseCase.getSearchWorks(getWorkModel);

    emit(state.coppyWith(postsData: posts));
  }
}
