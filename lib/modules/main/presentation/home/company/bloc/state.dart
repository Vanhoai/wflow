part of 'bloc.dart';

class MyCompanyState extends Equatable {
  final List<UserEntity> listUser;
  final List<PostEntity> listPost;
  final CompanyEntity companyEntity;
  final bool isLoadingCompany;
  final bool isLoadingMember;
  final bool isLoadingPost;
  final String message;

  const MyCompanyState({
    required this.companyEntity,
    this.listUser = const [],
    this.listPost = const [],
    this.isLoadingCompany = false,
    this.isLoadingMember = false,
    this.isLoadingPost = false,
    this.message = '',
  });

  MyCompanyState copyWith({
    CompanyEntity? companyEntity,
    List<UserEntity>? listUser,
    List<PostEntity>? listPost,
    bool? isLoadingCompany,
    bool? isLoadingMember,
    bool? isLoadingPost,
    String? message,
  }) {
    return MyCompanyState(
      companyEntity: companyEntity ?? this.companyEntity,
      listUser: listUser ?? this.listUser,
      listPost: listPost ?? this.listPost,
      isLoadingCompany: isLoadingCompany ?? this.isLoadingCompany,
      isLoadingMember: isLoadingMember ?? this.isLoadingMember,
      isLoadingPost: isLoadingPost ?? this.isLoadingPost,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        companyEntity,
        listUser,
        listPost,
        isLoadingCompany,
        isLoadingMember,
        isLoadingPost,
        message,
      ];
}
