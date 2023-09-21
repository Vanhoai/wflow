import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/personal/personal/bloc/bloc.dart';

const List<Map<String, dynamic>> _listSetting = [
  {
    'leading': Icons.edit_notifications,
    'title': 'Notification',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.work_rounded,
    'title': 'Application Issues',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.access_time_filled_sharp,
    'title': 'Timezone',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.security,
    'title': 'Security',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.language,
    'title': 'Language',
    'trailing': Icons.arrow_forward_ios,
    'subtitle': 'English',
  },
  {
    'leading': Icons.access_time_filled_sharp,
    'title': 'Timezone',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.dark_mode,
    'title': 'Dark Mode',
    'trailing': 'Dark_Mode',
  },
  {
    'leading': Icons.help_center,
    'title': 'Help Center',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.person_add_sharp,
    'title': 'Invite Friends',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.star_rounded,
    'title': 'Rate us',
    'trailing': Icons.arrow_forward_ios,
  }
];

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Widget> _buildAppBar(BuildContext context, bool innerBoxIsScrolled, ThemeData themeData) {
    return [
      SliverAppBar(
        elevation: 10.0,
        automaticallyImplyLeading: false,
        expandedHeight: 50,
        floating: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: const Text('Setting'),
        backgroundColor: Colors.transparent,
        snap: true,
      )
    ];
  }

  Widget _buildCompleteProfile(BuildContext context, ThemeData themeData) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(
          26,
        )),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueAccent,
            Colors.blue,
          ],
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircularPercentIndicator(
                    radius: 30,
                    percent: 99 / 100,
                    center: const Text('99%'),
                    progressColor: Colors.white,
                    animateFromLastPercent: true,
                    animationDuration: 1000,
                    addAutomaticKeepAlive: true,
                    animation: true,
                    curve: Curves.easeInOut,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Profile Completed!', style: themeData.textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(
                          style: themeData.textTheme.titleSmall,
                          'A complete profile increases the chances of a recruiter being more interested in recruiting you.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      isSafe: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => _buildAppBar(context, innerBoxIsScrolled, themeData),
        physics: const BouncingScrollPhysics(),
        body: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Column(
                children: [
                  _buildCompleteProfile(context, themeData),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.remove_red_eye),
                    title: const Text('Job Seeking Status'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account',
                          style: themeData.textTheme.labelSmall,
                        ),
                      )),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Personal Information'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.change_circle_outlined),
                    title: const Text('Linked Accounts'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'General',
                        style: themeData.textTheme.labelSmall,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: _listSetting[index]['subtitle'] != null
                            ? Text(
                                _listSetting[index]['subtitle'],
                                style: themeData.textTheme.labelSmall,
                              )
                            : null,
                        leading: Icon(_listSetting[index]['leading']),
                        title: Text(_listSetting[index]['title']),
                        trailing: _listSetting[index]['trailing'] is IconData
                            ? Icon(_listSetting[index]['trailing'])
                            : BlocBuilder<AppBloc, AppState>(
                                builder: (BuildContext context, state) {
                                  void onChanged(bool value) {
                                    instance.call<AppBloc>().add(AppChangeTheme(isDarkMode: !value));
                                  }

                                  return SwitchAnimation(
                                    value: state.isDarkMode,
                                    onChanged: onChanged,
                                  );
                                },
                                bloc: instance.call<AppBloc>(),
                              ),
                        onTap: () {},
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                      );
                    },
                    itemCount: _listSetting.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About',
                        style: themeData.textTheme.labelSmall,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_sharp),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.key_off_sharp),
                    title: const Text('Terms of Service'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_mark),
                    title: const Text('About Us'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: themeData.colorScheme.error,
                    ),
                    title: Text(
                      'Deactivate My Account',
                      style: TextStyle(color: themeData.colorScheme.error),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                  BlocConsumer(
                    builder: (context, state) {
                      return ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: themeData.colorScheme.error,
                        ),
                        title: Text(
                          'Log Out',
                          style: TextStyle(color: themeData.colorScheme.error),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.read<PersonalBloc>().add(const SignOutEvent());
                        },
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is SignOutSuccess) {
                        Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.signInScreen, (route) => false);
                      }
                    },
                    bloc: context.read<PersonalBloc>(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
