import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class SearchWorkState extends Equatable {
  final List<PostEntity> postsData;

  const SearchWorkState({this.postsData = const []});

  SearchWorkState coppyWith({List<PostEntity>? postsData}) {
    return SearchWorkState(
      postsData: postsData ?? this.postsData,
    );
  }

  @override
  List<Object?> get props => [postsData];
}
