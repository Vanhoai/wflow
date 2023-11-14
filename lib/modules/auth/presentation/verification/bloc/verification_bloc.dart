import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/firebase/firebase.dart';
import 'package:wflow/common/loading/bloc.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(const VerificationInitial()) {
    on<VerificationPhoneStartEvent>(onVerification);
  }

  Future onVerification(VerificationPhoneStartEvent event, Emitter<VerificationState> emit) async {
    try {
      instance.get<AppLoadingBloc>().add(AppShowLoadingEvent());

      emit(state.copyWith(message: 'Loading', isError: false));

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verification,
        smsCode: event.otpNumber,
      );

      await firebaseAuth.signInWithCredential(credential);

      if (firebaseAuth.currentUser != null) {
        instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
        emit(state.copyWith(isSuccess: true, message: 'Verification Success', isError: false));
      } else {
        instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
        emit(state.copyWith(isSuccess: false, message: 'Verification Failed', isError: true));
      }
    } catch (e) {
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-verification-code') {
          emit(state.copyWith(isSuccess: false, message: 'Invalid Verification Code', isError: true));
          return;
        } else if (e.code == 'invalid-verification-id') {
          emit(state.copyWith(isSuccess: false, message: 'Invalid Verification ID', isError: true));
          return;
        } else if (e.code == 'session-expired') {
          emit(state.copyWith(isSuccess: false, message: 'Session Expired', isError: true));
          return;
        } else if (e.code == 'too-many-requests') {
          emit(state.copyWith(isSuccess: false, message: 'Too Many Requests', isError: true));
          return;
        } else if (e.code == 'channel-error') {
          emit(state.copyWith(isSuccess: false, message: 'Channel Error', isError: true));
          return;
        }
      }
    } finally {
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
    }
  }
}
