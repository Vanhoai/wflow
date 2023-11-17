import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/custom/switch/switch.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void changeTheme(bool isDarkMode) {
    instance.call<AppBloc>().add(AppChangeTheme(isDarkMode: isDarkMode));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      appBar: AppHeader(
        text: Text(
          'Setting',
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
                      bloc: instance.call<AppBloc>(),
                      builder: (context, state) {
                        return SwitchAnimation(
                          value: state.isDarkMode,
                          onChanged: (bool values) => changeTheme(!values),
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
