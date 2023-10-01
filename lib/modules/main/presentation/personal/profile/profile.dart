import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:share_plus/share_plus.dart';

const List<Map<String, dynamic>> _tabs = [
  {
    'title': 'Posts',
    'icon': Icon(Icons.grid_view),
  },
  {
    'title': 'Saved',
    'icon': Icon(Icons.bookmark),
  },
  {
    'title': 'Friends',
    'icon': Icon(Icons.people),
  }
];

const String IMAGE =
    'https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/v1016-c-08_1-ksh6mza3.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=f584d8501c27c5f649bc2cfce50705c0';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  }

  Widget _buildInformation(BuildContext context, ThemeData themeData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage: const NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cristiano_Ronaldo_2018.jpg/220px-Cristiano_Ronaldo_2018.jpg',
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(99),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cristiano Ronaldo',
                        style: themeData.textTheme.titleMedium,
                        maxLines: 1,
                      ),
                      Text(
                        'Football Player',
                        style: themeData.textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(99),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: const Row(
                      children: [
                        Text('Edit Profile'),
                        SizedBox(width: 8),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                  "Php is the best language, I'm a php developer and I love it so much, I'm a php developer and I love it so much",
                  style: themeData.textTheme.bodyMedium),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link),
                      Text(
                        'https://google.com.vn',
                        style: themeData.textTheme.titleMedium!.merge(
                          const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link),
                      Text(
                        'https://google.com.vn',
                        style: themeData.textTheme.titleMedium!.merge(
                          const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScene1(BuildContext context, ThemeData themeData) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }

  Widget _buildScene2(BuildContext context, ThemeData themeData) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.green,
    );
  }

  Widget _buildScene3(BuildContext context, ThemeData themeData) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAboutDialog(context: context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        tooltip: 'Create Post',
        backgroundColor: themeData.primaryColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        mini: true,
        elevation: 10,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: true,
      backgroundColor: themeData.colorScheme.background,
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        animationDuration: const Duration(milliseconds: 300),
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                floating: false,
                snap: false,
                pinned: true,
                expandedHeight: 200,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    IMAGE,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 200,
                    cacheHeight: 200,
                    cacheWidth: 800,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox();
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  collapseMode: CollapseMode.none,
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    tooltip: 'Share',
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteKeys.settingScreen);
                    },
                    icon: const Icon(Icons.settings),
                    tooltip: 'Settings',
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: _buildInformation(context, themeData),
              ),
              SliverToBoxAdapter(
                child: TabBar(
                  tabs: _tabs
                      .map(
                        (e) => Tab(
                          icon: e['icon'] as Widget,
                          text: e['title'] as String,
                        ),
                      )
                      .toList(),
                  indicatorColor: themeData.primaryColor,
                  indicatorWeight: 2,
                  labelColor: themeData.primaryColor,
                  unselectedLabelColor: themeData.colorScheme.onSurface,
                  labelStyle: themeData.textTheme.bodyMedium,
                  unselectedLabelStyle: themeData.textTheme.bodyMedium,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dragStartBehavior: DragStartBehavior.start,
                  physics: const BouncingScrollPhysics(),
                  onTap: (index) {},
                  padding: const EdgeInsets.all(0),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  dragStartBehavior: DragStartBehavior.start,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildScene1(context, themeData),
                    _buildScene2(context, themeData),
                    _buildScene3(context, themeData),
                  ],
                ),
              ),
            ],
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            anchor: 0.0,
            cacheExtent: 0.0,
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            controller: _scrollController,
            dragStartBehavior: DragStartBehavior.start,
            restorationId: 'profile',
            scrollBehavior: const MaterialScrollBehavior(),
          ),
        ),
      ),
    );
  }
}
