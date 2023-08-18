part of "bloc.dart";

class SecurityState extends Equatable {
  final bool touchIDEnabled;
  final bool faceIDEnabled;
  final UserModel user;

  const SecurityState({
    required this.touchIDEnabled,
    required this.faceIDEnabled,
    required this.user,
  });

  factory SecurityState.fromJson(Map<String, dynamic> json) {
    return SecurityState(
      touchIDEnabled: json["touchIDEnabled"],
      faceIDEnabled: json["faceIDEnabled"],
      user: UserModel.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "touchIDEnabled": touchIDEnabled,
      "faceIDEnabled": faceIDEnabled,
      "user": user.toJson(),
    };
  }

  SecurityState copyWith({
    bool? touchIDEnabled,
    bool? faceIDEnabled,
    UserModel? user,
  }) {
    return SecurityState(
      touchIDEnabled: touchIDEnabled ?? this.touchIDEnabled,
      faceIDEnabled: faceIDEnabled ?? this.faceIDEnabled,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [touchIDEnabled, faceIDEnabled, user];
}
