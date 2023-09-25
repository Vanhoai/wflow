import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

const List<Map<String, dynamic>> _listMenu = [
  {
    'leading': Icons.contact_emergency,
    'title': 'Contact Information',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.summarize,
    'title': 'Summary',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.pie_chart,
    'title': 'Expected Salary',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.work,
    'title': 'Work Experience',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.note,
    'title': 'Education',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.bar_chart,
    'title': 'Projects',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.policy,
    'title': 'Certification and Licenses',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.model_training,
    'title': 'Seminars and Training',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.show_chart,
    'title': 'Skills',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.person_add,
    'title': 'Friends',
    'trailing': Icons.arrow_forward_ios,
  },
  {
    'leading': Icons.note_alt,
    'title': 'CV/Resume',
    'trailing': Icons.arrow_forward_ios,
  },
];

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  FutureOr<void> _showModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => const Column(
        children: [
          Center(
            child: Text('Giỡn quài ný ơi!!'),
          )
        ],
      ),
      isDismissible: true,
      barrierLabel: 'Dismiss',
      clipBehavior: Clip.antiAliasWithSaveLayer,
      enableDrag: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      elevation: 10,
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Header(
      title: 'Tran Van Hoai',
      subtitle: 'tranvanhoai@gmail.com',
      onTapLeading: () {},
      leadingSize: 32,
      leadingPadding: const EdgeInsets.only(right: 8),
      onTapTitle: () {
        Navigator.of(context).pushNamed(RouteKeys.profileScreen);
      },
      actions: [
        IconButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => const AboutDialog());
          },
          icon: Icon(
            color: Theme.of(context).colorScheme.onBackground,
            size: 30,
            Icons.qr_code,
          ),
          color: Colors.black,
          alignment: Alignment.center,
          tooltip: MaterialLocalizations.of(context).showMenuTooltip,
          highlightColor: Theme.of(context).colorScheme.primary,
        ),
      ],
      decorationAction: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 0.2,
            blurRadius: 0.2,
            offset: Offset(0, 0.2),
          ),
        ],
        shape: BoxShape.circle,
      ),
      leadingBadge: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      isSafe: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.flutter_dash, size: 30),
        title: Text('Account', style: themeData.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteKeys.settingScreen);
            },
            icon: Icon(
              color: Theme.of(context).colorScheme.onBackground,
              size: 30,
              Icons.settings,
            ),
            color: Colors.black,
            alignment: Alignment.center,
            tooltip: 'Settings',
            highlightColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future<void>.delayed(const Duration(seconds: 1), () {
            return;
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(4),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context, themeData),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(_listMenu[index]['leading']),
                      title: Text(_listMenu[index]['title']),
                      trailing: Icon(_listMenu[index]['trailing']),
                      onTap: () {},
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                    );
                  },
                  itemCount: _listMenu.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      _showModal(context);
                    },
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: const Text('Add Custom Section'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      hideKeyboardWhenTouchOutside: true,
    );
  }
}
