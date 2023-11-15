import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/firebase/firebase.dart';
import 'package:wflow/common/loading/bloc.dart';
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
import 'package:logger/logger.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, this.arguments});

  final FormRegisterArgument? arguments;

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
  int? count;
  Timer? _everySecond;
  String? verificationId;

  @override
  void initState() {
    super.initState();
    count = 120;
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
    } else {
      _initVerificationEmail();
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
          AlertUtils.showMessage('Notification', error.message!);

          Logger().d(error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          setState(() {
            this.verificationId = verificationId;
          });
          Logger().d(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
          Logger().d(verificationId);
        },
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      Logger().d(e);
    }
  }

  _initVerificationEmail() async {}

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerificationBloc>(
          create: (_) => VerificationBloc(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => RegisterBloc(authUseCase: instance.call<AuthUseCase>()),
          lazy: true,
        ),
      ],
      child: Builder(builder: (context) {
        final VerificationBloc verificationBloc = BlocProvider.of(context);
        final RegisterBloc registerBloc = BlocProvider.of(context);
        return SafeArea(
          child: Listener(
            onPointerDown: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: BlocConsumer<VerificationBloc, VerificationState>(
              listener: (context, state) {
                if (state.isSuccess && !state.isError) {
                  AlertUtils.showMessage('Notification', state.message, callback: () {
                    registerBloc.add(RegisterTypeEvent(
                      username: widget.arguments!.username,
                      password: widget.arguments!.password,
                      type: widget.arguments!.type,
                    ));
                  });
                } else if (!state.isSuccess && state.isError) {
                  AlertUtils.showMessage('Notification', state.message);
                }
              },
              buildWhen: (previous, current) => true,
              listenWhen: (previous, current) => true,
              bloc: BlocProvider.of(context),
              builder: (context, state) {
                return BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterPhoneSuccessState) {
                      AlertUtils.showMessage('Notification', state.message, callback: () {
                        Navigator.popAndPushNamed(context, RouteKeys.signInScreen);
                      });
                    } else if (state is RegisterEmailSuccessState) {
                      AlertUtils.showMessage('Notification', state.message, callback: () {
                        Navigator.popAndPushNamed(context, RouteKeys.signInScreen);
                      });
                    } else if (state is RegisterErrorState) {
                      AlertUtils.showMessage('Notification', state.message, callback: () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  buildWhen: (previous, current) => true,
                  listenWhen: (previous, current) => true,
                  bloc: registerBloc,
                  builder: (context, state) {
                    return Scaffold(
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
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 49),
                              child: Text(
                                'Xác nhận số điện thoại',
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
                            Flexible(
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
                                        AlertUtils.showMessage('Notification', 'Please enter OTP');
                                        return;
                                      }

                                      if (verificationId == null) {
                                        AlertUtils.showMessage('Notification', 'Something went wrong');
                                        return;
                                      }

                                      if (widget.arguments!.type == 'phone') {
                                        verificationBloc.add(VerificationPhoneStartEvent(
                                          otpNumber: _otpController1.text +
                                              _otpController2.text +
                                              _otpController3.text +
                                              _otpController4.text +
                                              _otpController5.text +
                                              _otpController6.text,
                                          verification: verificationId!,
                                        ));
                                      } else {
                                        verificationBloc.add(VerificationEmailStartEvent(
                                          otpNumber: _otpController1.text +
                                              _otpController2.text +
                                              _otpController3.text +
                                              _otpController4.text +
                                              _otpController5.text +
                                              _otpController6.text,
                                          verification: verificationId!,
                                        ));
                                      }
                                    },
                                  ),
                                ],
                              ),
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
                    );
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
