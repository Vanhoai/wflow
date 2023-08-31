part of "bloc.dart";

@immutable
class SecurityState extends Equatable {
  final bool touchIDEnabled;
  final bool faceIDEnabled;

  const SecurityState({
    required this.touchIDEnabled,
    required this.faceIDEnabled,
  });

  factory SecurityState.fromJson(Map<String, dynamic> json) {
    return SecurityState(
      touchIDEnabled: json["touchIDEnabled"],
      faceIDEnabled: json["faceIDEnabled"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "touchIDEnabled": touchIDEnabled,
      "faceIDEnabled": faceIDEnabled,
    };
  }

  SecurityState copyWith({
    bool? touchIDEnabled,
    bool? faceIDEnabled,
  }) {
    return SecurityState(
      touchIDEnabled: touchIDEnabled ?? this.touchIDEnabled,
      faceIDEnabled: faceIDEnabled ?? this.faceIDEnabled,
    );
  }

  @override
  List<Object> get props => [touchIDEnabled, faceIDEnabled];
}
