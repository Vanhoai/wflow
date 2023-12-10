import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/firebase/firebase.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_verification.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/auth/presentation/register/bloc/register_bloc.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';
import 'package:wflow/modules/auth/presentation/verification/bloc/verification_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, this.arguments});

  final VerificationArgument? arguments;

  @override
  State<StatefulWidget> createState() {
    return _VerificationScreenState();
  }
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();

  int? count = 120;

  Timer? _everySecond;

  String? verificationId;

  @override
  void initState() {
    super.initState();
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (count == 0) {
          _everySecond?.cancel();
        } else {
          count = count! - 1;
        }
      });
    });
    if (widget.arguments!.type == 'phone') {
      _initVerificationPhone();
    } else if (widget.arguments!.type == 'reset_password') {
      if (StringsUtil.isPhoneNumber(widget.arguments!.username)) {
        _initVerificationPhoneResetPassword();
      }
    }
  }

  @override
  void dispose() {
    _everySecond?.cancel();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    super.dispose();
  }

  _initVerificationPhone() async {
    try {
      final phoneNumber = '+84${widget.arguments!.username.substring(1)}';
      await firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (error) {
          instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
          AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), error.message!);

          Logger().d(error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), e.toString(), callback: () {
        Navigator.pop(context);
      });
    }
  }

  _handleVerificationEmail(VerificationBloc verificationBloc, String otp) async {
    // add event to send otp from server to verify
    verificationBloc.add(VerificationEmailRegisterEvent(
        username: widget.arguments!.username, otpCode: otp, password: widget.arguments!.password));
  }

  _handleVerificationEmailResetPassword(VerificationBloc verificationBloc, String otp) async {
    // add event to send otp from server to verify
    verificationBloc.add(VerificationEmailForgotPasswordEvent(email: widget.arguments!.username, otpCode: otp));
  }

  _initVerificationPhoneResetPassword() async {
    // send email and opt to server
    try {
      final phoneNumber = '+84${widget.arguments!.username.substring(1)}';
      await firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (error) {
          instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
          AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), error.toString(),
              callback: () {
            Navigator.pop(context);
          });
        },
        codeSent: (verificationId, forceResendingToken) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      instance.get<AppLoadingBloc>().add(AppHideLoadingEvent());
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), e.toString(), callback: () {
        Navigator.pop(context);
      });
    }
  }

  _handleVerificationPhoneResetPassword(VerificationBloc verificationBloc, String otp) async {
    // add event to send otp from server to verify
    if (verificationId == null) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Something went wrong',
          callback: () {
        Navigator.pop(context);
      });
    } else {
      verificationBloc.add(VerificationPhoneForgotPasswordEvent(verificationId: verificationId!, otpCode: otp));
    }
  }

  _logicOtp(BuildContext context) {
    final VerificationBloc verificationBloc = BlocProvider.of(context);

    if (widget.arguments!.type == 'phone') {
      if (verificationId == null) {
        AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Something went wrong',
            callback: () {
          Navigator.pop(context);
        });
      }
      verificationBloc.add(
        VerificationPhoneRegisterEvent(
          username: widget.arguments!.username,
          password: widget.arguments!.password,
          verificationId: verificationId!,
          smsCode: _otpController1.text +
              _otpController2.text +
              _otpController3.text +
              _otpController4.text +
              _otpController5.text +
              _otpController6.text,
        ),
      );
    } else if (widget.arguments!.type == 'email') {
      _handleVerificationEmail(
          verificationBloc,
          _otpController1.text +
              _otpController2.text +
              _otpController3.text +
              _otpController4.text +
              _otpController5.text +
              _otpController6.text);
    } else if (widget.arguments!.type == 'reset_password') {
      if (StringsUtil.isEmail(widget.arguments!.username)) {
        _handleVerificationEmailResetPassword(
          verificationBloc,
          _otpController1.text +
              _otpController2.text +
              _otpController3.text +
              _otpController4.text +
              _otpController5.text +
              _otpController6.text,
        );
      } else if (StringsUtil.isPhoneNumber(widget.arguments!.username)) {
        _handleVerificationPhoneResetPassword(
          verificationBloc,
          _otpController1.text +
              _otpController2.text +
              _otpController3.text +
              _otpController4.text +
              _otpController5.text +
              _otpController6.text,
        );
      }
    } else {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Something went wrong',
          callback: () {
        Navigator.pop(context);
      });
    }
  }

  _listenerVerification(BuildContext context, VerificationState state) {
    if (state is VerificationPhoneRegisterSuccessState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        context
            .read<RegisterBloc>()
            .add(RegisterTypeEvent(username: state.username, password: state.password, type: state.type));
      });
    } else if (state is VerificationPhoneRegisterFailureState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pop(context);
      });
    } else if (state is VerificationEmailRegisterSuccessState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        context
            .read<RegisterBloc>()
            .add(RegisterTypeEvent(username: state.username, password: state.password, type: state.type));
      });
    } else if (state is VerificationEmailRegisterFailureState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pop(context);
      });
    }
  }

  _listenerRegister(BuildContext context, RegisterState state) {
    if (state is RegisterPhoneSuccessState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pop(context);
      });
    } else if (state is RegisterEmailSuccessState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pop(context);
      });
    } else if (state is RegisterErrorState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pop(context);
      });
    }
  }

  _listenerForgotPasswordVerification(BuildContext context, VerificationState state) {
    if (state is VerificationPhoneForgotPasswordSuccessState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pushReplacementNamed(context, RouteKeys.resetPasswordScreen, arguments: widget.arguments!);
      });
    } else if (state is VerificationPhoneForgotPasswordFailureState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message);
    } else if (state is VerificationEmailForgotSuccessPasswordState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message, callback: () {
        Navigator.pushReplacementNamed(context, RouteKeys.resetPasswordScreen, arguments: widget.arguments!);
      });
    } else if (state is VerificationEmailForgotFailurePasswordState) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerificationBloc>(
          create: (_) => VerificationBloc(authUseCase: instance.call<AuthUseCase>(), arguments: widget.arguments!),
          lazy: true,
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authUseCase: instance.call<AuthUseCase>()),
          lazy: true,
        ),
      ],
      child: Builder(
        builder: (context) {
          final VerificationBloc verificationBloc = BlocProvider.of(context);
          final RegisterBloc registerBloc = BlocProvider.of(context);

          return SafeArea(
            child: Listener(
              onPointerDown: (PointerDownEvent event) => FocusManager.instance.primaryFocus?.unfocus(),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<RegisterBloc, RegisterState>(
                    listener: _listenerRegister,
                    bloc: registerBloc,
                    listenWhen: (previous, current) => true,
                  ),
                  BlocListener<VerificationBloc, VerificationState>(
                    listener: _listenerForgotPasswordVerification,
                    bloc: verificationBloc,
                    listenWhen: (previous, current) => true,
                  ),
                  BlocListener<VerificationBloc, VerificationState>(
                    listener: _listenerVerification,
                    bloc: verificationBloc,
                    listenWhen: (previous, current) => true,
                  ),
                ],
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 80),
                          child: SvgPicture.asset(
                            AppConstants.app,
                            semanticsLabel: 'Logo',
                            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 49),
                          child: Text(
                            'Nhập mã xác nhận',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFieldVerification(controller: _otpController1),
                            TextFieldVerification(controller: _otpController2),
                            TextFieldVerification(controller: _otpController3),
                            TextFieldVerification(controller: _otpController4),
                            TextFieldVerification(controller: _otpController5),
                            TextFieldVerification(controller: _otpController6),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mã xác nhận sẽ gửi lại sau',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text(
                              '${count}s',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Builder(
                          builder: (context) {
                            return Flexible(
                              fit: FlexFit.tight,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  PrimaryButton(
                                    label: 'Xác nhận',
                                    onPressed: () {
                                      if (_otpController1.text.isEmpty ||
                                          _otpController2.text.isEmpty ||
                                          _otpController3.text.isEmpty ||
                                          _otpController4.text.isEmpty ||
                                          _otpController5.text.isEmpty ||
                                          _otpController6.text.isEmpty) {
                                        AlertUtils.showMessage(
                                            instance.get<AppLocalization>().translate('notification'),
                                            'Please enter OTP');
                                        return;
                                      }

                                      _logicOtp(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bạn đã có tài khoản? ',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () => {Navigator.pop(context)},
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    'Đăng nhập',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .merge(const TextStyle(color: AppColors.primary)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
