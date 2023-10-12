import 'package:equatable/equatable.dart';

class HeaderRoomState extends Equatable {
  final bool showSearch;

  const HeaderRoomState({this.showSearch = false});

  HeaderRoomState copyWith({
    bool? showSearch,
  }) {
    return HeaderRoomState(showSearch: showSearch ?? this.showSearch);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [showSearch];
}
