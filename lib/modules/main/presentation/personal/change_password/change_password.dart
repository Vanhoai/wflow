import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/change_password/bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  _listenerChangePasswordBloc(BuildContext context, ChangePasswordState state) {
    if (state is ChangePasswordSuccess) {
      AlertUtils.showMessage('Notification', state.message, callback: () {
        Navigator.of(context).pop();
        context.read<ChangePasswordBloc>().add(ChangePasswordInitialEvent());
      });
    } else if (state is ChangePasswordFailure) {
      AlertUtils.showMessage('Notification', state.message);
    }
  }

  String? validatePassword(String? value, String? secondValue) {
    if (value == null || value.isEmpty) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Password is required');
      return 'Password is required';
    }
    if (!StringsUtil.isPassword(value)) {
      AlertUtils.showMessage(
          instance.get<AppLocalization>().translate('notification'), 'Password must be at least 8 characters');
      return 'Password must be at least 8 characters';
    }
    if (!StringsUtil.isComparePassword(value, secondValue!)) {
      AlertUtils.showMessage(
          instance.get<AppLocalization>().translate('notification'), 'Password and confirm password must be the same');
      return 'Password and confirm password must be the same';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String oldPasswordLabel = instance.get<AppLocalization>().translate('oldPassword') ?? 'Old Password';
    final String newPasswordLabel = instance.get<AppLocalization>().translate('newPassword') ?? 'New Password';
    final String confirmNewPasswordLabel =
        instance.get<AppLocalization>().translate('placeholderNewPassword') ?? 'Confirm New Password';

    return CommonScaffold(
      appBar: AppBarCenterWidget(
          center: Text(instance.get<AppLocalization>().translate('changePassword') ?? 'Change Password')),
      hideKeyboardWhenTouchOutside: true,
      body: BlocProvider<ChangePasswordBloc>(
        create: (context) => ChangePasswordBloc(authUseCase: instance.call<AuthUseCase>()),
        lazy: true,
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: _listenerChangePasswordBloc,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                TextFieldFrom(
                  controller: oldPasswordController,
                  label: oldPasswordLabel,
                  placeholder: oldPasswordLabel,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                TextFieldFrom(
                  controller: newPasswordController,
                  label: newPasswordLabel,
                  placeholder: newPasswordLabel,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                TextFieldFrom(
                  controller: confirmNewPasswordController,
                  label: confirmNewPasswordLabel,
                  placeholder: confirmNewPasswordLabel,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                20.verticalSpace,
                BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                  builder: (context, state) {
                    return Expanded(
                      flex: 1,
                      child: PrimaryButton(
                        onPressed: () {
                          if (validatePassword(oldPasswordController.text, oldPasswordController.text) == null &&
                              validatePassword(newPasswordController.text, confirmNewPasswordController.text) == null) {
                            context.read<ChangePasswordBloc>().add(ChangePasswordSubmitEvent(
                                  oldPassword: oldPasswordController.text,
                                  newPassword: newPasswordController.text,
                                ));
                          }
                        },
                        label: instance.get<AppLocalization>().translate('changePassword') ?? 'Change Password',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
