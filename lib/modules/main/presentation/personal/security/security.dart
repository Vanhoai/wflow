import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/switch/switch.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool TouchID = false;
  bool FaceID = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onClickTouchID(BuildContext context) {}

  void onClickFaceID(BuildContext context) {}

  void onClickVerify(BuildContext context) {}

  void onClickPrivacyPolicy(BuildContext context) {}

  void onClickAccessibility(BuildContext context) {}

  void onClickTermOfService(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
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
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, false),
              ),
              title: Text(
                'Security',
                style: themeData.textTheme.displayLarge,
              ),
              surfaceTintColor: Colors.transparent,
              pinned: true,
              centerTitle: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Touch ID',
                      style: themeData.textTheme.displayLarge!.merge(
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
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Face ID',
                      style: themeData.textTheme.displayLarge!.merge(
                        TextStyle(color: themeData.colorScheme.onBackground),
                      ),
                    ),
                    SwitchAnimation(
                      value: FaceID,
                      onChanged: (bool values) {
                        setState(() {
                          FaceID = !values;
                        });
                        onClickFaceID(context);
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
                        'Verify',
                        style: themeData.textTheme.displayLarge!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not verify',
                            style: themeData.textTheme.displayLarge!.merge(
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
                              color: themeData.colorScheme.onBackground,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              sliver: SliverToBoxAdapter(
                child: Text('Legal',
                    style: themeData.textTheme.displayLarge!.merge(
                      TextStyle(color: themeData.colorScheme.onBackground.withOpacity(0.7)),
                    )),
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
                        'Privacy policy',
                        style: themeData.textTheme.displayLarge!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          color: themeData.colorScheme.onBackground,
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
                        'Accessibility',
                        style: themeData.textTheme.displayLarge!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          color: themeData.colorScheme.onBackground,
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
                        'Term of service',
                        style: themeData.textTheme.displayLarge!.merge(
                          TextStyle(color: themeData.colorScheme.onBackground),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AppConstants.backArrow,
                          width: 20,
                          height: 20,
                          color: themeData.colorScheme.onBackground,
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
