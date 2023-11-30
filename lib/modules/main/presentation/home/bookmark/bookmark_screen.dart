import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bloc/state.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => BookmarkBloc(postUseCase: instance.get<PostUseCase>())
        ..add(InitBookmarkEvent()),
      child: Scaffold(
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate('saved') ?? 'Saved',
            style: themeData.textTheme.displayLarge,
          ),
          onBack: () => Navigator.of(context).pushNamedAndRemoveUntil(
              RouteKeys.bottomScreen, (route) => false),
        ),
        body: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            _scrollController.addListener(() {
              if (_scrollController.position.maxScrollExtent ==
                  _scrollController.offset) {
                BlocProvider.of<BookmarkBloc>(context)
                    .add(ScrollBookmarkEvent());
              }
            });
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Builder(builder: (context) {
                      if (state.posts.isNotEmpty) {
                        return BlocListener<BookmarkBloc, BookmarkState>(
                          listenWhen: (previous, current) =>
                              previous != current,
                          listener: (context, state) {
                            if (state is RemoveSuccessedBookmarkState) {
                              final snackBar = SnackBar(
                                content: const Text('Deleted'),
                                action: SnackBarAction(
                                  label: 'Ok',
                                  onPressed: () => {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: ListView.separated(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(bottom: 20, top: 4),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.posts.length,
                            itemBuilder: (context, index) => Container(
                              constraints: const BoxConstraints(maxHeight: 280),
                              child: JobCard(
                                time: state.posts[index].updatedAt!,
                                jobId: state.posts[index].id,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                boxDecoration: BoxDecoration(
                                  color: themeData.colorScheme.background,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: themeData.colorScheme.onBackground
                                          .withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                    BoxShadow(
                                      color: themeData.colorScheme.onBackground
                                          .withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(12),
                                header: Header(
                                  idBusiness:
                                      state.posts[index].business.toString(),
                                  leadingPhotoUrl:
                                      state.posts[index].companyLogo,
                                  title: Text(
                                    state.posts[index].position,
                                    style: themeData.textTheme.displayLarge!
                                        .merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                  ),
                                  subtitle: Text(
                                    state.posts[index].companyName,
                                    style: themeData.textTheme.displayMedium!
                                        .merge(TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    )),
                                  ),
                                  leadingSize: 30,
                                  actions: [
                                    InkWell(
                                      onTap: () =>
                                          BlocProvider.of<BookmarkBloc>(context)
                                              .add(ToggleBookmarkEvent(
                                                  id: state.posts[index].id)),
                                      child: SvgPicture.asset(
                                        AppConstants.bookmark,
                                        height: 24,
                                        width: 24,
                                        colorFilter: ColorFilter.mode(
                                          themeData.colorScheme.primary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                  ],
                                ),
                                cost: instance.get<ConvertString>().moneyFormat(
                                    value: state.posts[index].salary),
                                duration: state.posts[index].duration,
                                description: TextMore(
                                  state.posts[index].content,
                                  trimMode: TrimMode.Hidden,
                                  trimHiddenMaxLines: 3,
                                  style:
                                      themeData.textTheme.displayMedium!.merge(
                                    TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            instance
                                    .get<AppLocalization>()
                                    .translate('savedIsEmpty') ??
                                'Saved is empty',
                          ),
                        );
                      }
                    }),
                  ),
                  Builder(
                    builder: (context) {
                      if (state.isLoadMore) {
                        return Visibility(
                          visible: state.isLoadMore,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: const Loading(),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
