import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/switch/switch.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void navigateToCreateContract(BuildContext context) {
    Navigator.of(context).pushNamed(RouteKeys.createContractScreen);
  }

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
                'Setting',
                style: themeData.textTheme.displayLarge,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Dark mode',
                      style: themeData.textTheme.displayLarge!.merge(
                        TextStyle(color: themeData.colorScheme.onBackground),
                      ),
                    ),
                    BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        print('ACASCCSCA: ${state.isDarkMode}');
                        return SwitchAnimation(
                          value: state.isDarkMode,
                          onChanged: (bool values) {
                            instance.call<AppBloc>().add(AppChangeTheme(isDarkMode: !values));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
