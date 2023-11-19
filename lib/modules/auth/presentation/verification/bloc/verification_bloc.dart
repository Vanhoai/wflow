import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/firebase/firebase.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final AuthUseCase authUseCase;
  final VerificationArgument arguments;

  VerificationBloc({required this.authUseCase, required this.arguments}) : super(VerificationInitial()) {
    on<VerificationEmailInitEvent>(onVerificationEmailInitEvent);
    on<VerificationEmailResetInitEvent>(onVerificationEmailResetInitEvent);
    on<VerificationPhoneRegisterEvent>(onVerificationPhoneRegisterEvent);
    on<VerificationEmailRegisterEvent>(onVerificationEmailRegisterEvent);
    on<VerificationPhoneForgotPasswordEvent>(onVerificationPhoneForgotPasswordEvent);
    on<VerificationEmailForgotPasswordEvent>(onVerificationEmailForgotPasswordEvent);

    if (arguments.type == 'email') {
      add(VerificationEmailInitEvent(email: arguments.username, otpCode: arguments.otpCode));
    } else if (arguments.type == 'reset_password') {
      if (StringsUtil.isEmail(arguments.username)) {
        add(VerificationEmailResetInitEvent(email: arguments.username, otpCode: arguments.otpCode));
      }
    }
  }

  Future onVerificationEmailInitEvent(VerificationEmailInitEvent event, Emitter<VerificationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response = await authUseCase.sendCodeOtpMail(email: event.email, otpCode: event.otpCode);

      response.fold(
        (success) {},
        (failure) {
          AlertUtils.showMessage('Notification', failure.message);
        },
      );
    } catch (e) {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future onVerificationEmailResetInitEvent(
      VerificationEmailResetInitEvent event, Emitter<VerificationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response = await authUseCase.sendCodeOtpMail(email: event.email, otpCode: event.otpCode);
      response.fold(
        (success) {},
        (failure) {
          AlertUtils.showMessage('Notification', failure.message);
        },
      );
    } catch (e) {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future onVerificationPhoneRegisterEvent(VerificationPhoneRegisterEvent event, Emitter<VerificationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        emit(
          VerificationPhoneRegisterSuccessState(
            message: 'Verification phone register success',
            password: event.password,
            username: event.username,
          ),
        );
      } else {
        emit(
          const VerificationPhoneRegisterFailureState(message: 'Verification phone register failure'),
        );
      }
    } catch (e) {
      AlertUtils.showMessage('Notification', e.toString());
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future onVerificationEmailRegisterEvent(VerificationEmailRegisterEvent event, Emitter<VerificationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final response = await authUseCase.verifyCodeOtpMail(email: event.username, otpCode: event.otpCode);
      response.fold(
        (success) {
          emit(
            VerificationEmailRegisterSuccessState(
              message: 'Verification email register success',
              username: event.username,
              password: event.password,
            ),
          );
        },
        (failure) {
          emit(
            const VerificationEmailRegisterFailureState(
              message: 'Verification email register failure',
            ),
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future onVerificationPhoneForgotPasswordEvent(
      VerificationPhoneForgotPasswordEvent event, Emitter<VerificationState> emit) async {
    try {
      instance.call<AppLoadingBloc>().add(AppShowLoadingEvent());
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );

      final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

      print(userCredential.user?.phoneNumber);

      final User? user = userCredential.user;
      if (user != null) {
        emit(
          VerificationPhoneForgotPasswordSuccessState(
              message: 'Verification phone forgot password success', phoneNumber: user.phoneNumber!),
        );
      } else {
        emit(const VerificationPhoneForgotPasswordFailureState(message: 'Verification phone register failure'));
      }
    } catch (e) {
      AlertUtils.showMessage('Notification', e.toString());
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    } finally {
      instance.call<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }

  Future onVerificationEmailForgotPasswordEvent(
      VerificationEmailForgotPasswordEvent event, Emitter<VerificationState> emit) async {}
}
