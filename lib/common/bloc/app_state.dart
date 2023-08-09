part of 'app_bloc.dart';

class AppState extends Equatable {

  final bool isDarkMode;
  final String languageCode;
  final bool isLoading;

  const AppState({
    this.isDarkMode = false,
    this.languageCode = "en",
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [];
}