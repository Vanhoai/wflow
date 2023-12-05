import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/presentation/home/sub_topic/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/sub_topic/bloc/state.dart';

class SubTopicBloc extends Bloc<SubTopicEvent, SubTopicState> {
  final CategoryUseCase categoryUseCase;

  SubTopicBloc({required this.categoryUseCase}) : super(const SubTopicState()) {
    on<InitSubTopicEvent>(onInitSubTopicEvent);
    on<ToggleSubTopicEvent>(onToggleSubTopicEvent);
    on<NextSubTopicEvent>(onNextSubTopicEvent);
  }

  Future<void> onInitSubTopicEvent(
      InitSubTopicEvent event, Emitter emit) async {
    List<CategoryEntity> categories = await categoryUseCase.getPostCategory();
    emit(state.copyWith(categories: categories));
  }

  Future<void> onToggleSubTopicEvent(
      ToggleSubTopicEvent event, Emitter emit) async {
    List<CategoryEntity> newCategorySelected = [
      ...state.categorySelected.map((e) => CategoryEntity.fromJson(e.toJson()))
    ];

    if (newCategorySelected.contains(event.category)) {
      newCategorySelected.remove(event.category);
    } else {
      newCategorySelected = [...newCategorySelected, event.category];
    }

    emit(state.copyWith(categorySelected: newCategorySelected));
  }

  Future<void> onNextSubTopicEvent(
      NextSubTopicEvent event, Emitter emit) async {
    sharedPreferences.setString('topic', state.categorySelected.toString());
    print('mylog ${sharedPreferences.get('topic')}');

    emit(state.copyWith());
  }
}
