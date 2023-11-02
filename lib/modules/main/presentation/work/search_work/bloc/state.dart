import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class SearchWorkState extends Equatable {
  final List<PostEntity> postsData;
  final bool isHiddenSuffixIcon;
  final int page;
  final String txtSearch;
  final bool isLoadMore;

  const SearchWorkState({
    this.postsData = const [],
    this.isHiddenSuffixIcon = true,
    this.page = 1,
    this.txtSearch = '',
    this.isLoadMore = false,
  });

  SearchWorkState coppyWith({
    List<PostEntity>? postsData,
    bool? isHiddenSuffixIcon,
    int? page,
    String? txtSearch,
    bool? isLoadMore,
  }) {
    return SearchWorkState(
      postsData: postsData ?? this.postsData,
      isHiddenSuffixIcon: isHiddenSuffixIcon ?? this.isHiddenSuffixIcon,
      page: page ?? this.page,
      txtSearch: txtSearch ?? this.txtSearch,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        postsData,
        isHiddenSuffixIcon,
        page,
        txtSearch,
        isLoadMore,
      ];
}
