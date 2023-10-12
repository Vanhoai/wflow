


import 'package:equatable/equatable.dart';

class HeaderRoomsEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ShowSearchEvent extends HeaderRoomsEvent {
  final bool show;

  ShowSearchEvent({required this.show});
  @override
  List<Object?> get props => [show];
}