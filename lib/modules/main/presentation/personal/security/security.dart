import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/switch/switch.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';

class SecurityScreen extends StatefulWidget {
  final bool isVerify;
  const SecurityScreen({super.key, required this.isVerify});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final SecurityBloc securityBloc = instance.get<SecurityBloc>();

  bool TouchID = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      TouchID = securityBloc.state.touchIDEnabled;
    });
  }

  void onClickTouchID(BuildContext context) => securityBloc.add(ToggleTouchIDEvent(touchIDEnabled: TouchID));

  void onClickVerify(BuildContext context) {
    if(!widget.isVerify)
    {
      Navigator.of(context).pushNamed(RouteKeys.auStepOneScreen);
    }
  }

  void onClickPrivacyPolicy(BuildContext context) {}

  void onClickAccessibility(BuildContext context) {}

  void onClickTermOfService(BuildContext context) {}

  void onClickChangePassword(BuildContext context) => Navigator.of(context).pushNamed(RouteKeys.changePasswordScreen);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      appBar: AppHeader(
        text: Text(
          instance.get<AppLocalization>().translate('security') ?? 'Security',
          style: themeData.textTheme.displayMedium,
        ),
      ),
      hideKeyboardWhenTouchOutside: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          clipBehavior: Clip.none,
          cacheExtent: 1000,
          dragStartBehavior: DragStartBehavior.start,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('touchId') ?? 'Touch ID',
                      style: themeData.textTheme.displayMedium!.merge(
                        TextStyle(color: themeData.colorScheme.onBackground),
                      ),
                    ),
                    SwitchAnimation(
                      value: TouchID,
                      onChanged: (bool values) {
                        setState(() {
                          TouchID = !values;
                        });
                        onClickTouchID(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () => onClickVerify(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        instance.get<AppLocalization>().translate('verify') ?? 'Verify',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.isVerify == true
                                ? instance.get<AppLocalization>().translate('hasVerified') ?? 'Verified'
                                : instance.get<AppLocalization>().translate('notVerify') ?? 'Not Verified',
                            style: themeData.textTheme.displayMedium!.merge(
                              TextStyle(color: themeData.colorScheme.onBackground),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              AppConstants.backArrow,
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                themeData.colorScheme.onBackground,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () => onClickChangePassword(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        instance.get<AppLocalization>().translate('changePassword') ?? 'Change Password',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            themeData.colorScheme.onBackground,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              sliver: SliverToBoxAdapter(
                child: Text(
                  instance.get<AppLocalization>().translate('legal') ?? 'Legal',
                  style: themeData.textTheme.displayMedium!.merge(
                    TextStyle(color: themeData.colorScheme.onBackground.withOpacity(0.7)),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () => onClickPrivacyPolicy(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        instance.get<AppLocalization>().translate('privacyPolicy') ?? 'Privacy Policy',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            themeData.colorScheme.onBackground,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () => onClickAccessibility(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        instance.get<AppLocalization>().translate('accessibility') ?? 'Accessibility',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            themeData.colorScheme.onBackground,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () => onClickTermOfService(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        instance.get<AppLocalization>().translate('termOfService') ?? 'Term of service',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            themeData.colorScheme.onBackground,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
