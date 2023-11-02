import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class SearchWorkState extends Equatable {
  final List<PostEntity> postsData;
  final bool isHiddenSuffixIcon;
  final int page;
  final String txtSearch;

  const SearchWorkState({
    this.postsData = const [],
    this.isHiddenSuffixIcon = true,
    this.page = 1,
    this.txtSearch = '',
  });

  SearchWorkState coppyWith({
    List<PostEntity>? postsData,
    bool? isHiddenSuffixIcon,
    int? page,
    String? txtSearch,
  }) {
    return SearchWorkState(
      postsData: postsData ?? this.postsData,
      isHiddenSuffixIcon: isHiddenSuffixIcon ?? this.isHiddenSuffixIcon,
      page: page ?? this.page,
      txtSearch: txtSearch ?? this.txtSearch,
    );
  }

  @override
  List<Object?> get props => [postsData, isHiddenSuffixIcon, page, txtSearch];
}
