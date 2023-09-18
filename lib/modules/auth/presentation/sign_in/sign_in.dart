import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/domain/auth.usecase.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signInWithGoogle() {
    Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.bottomScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (_) => SignInBloc(authUseCase: instance.get<AuthUseCase>()),
      lazy: true,
      child: CommonScaffold(
        isSafe: true,
        hideKeyboardWhenTouchOutside: true,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Header(
              title: 'Tran Van Hoai',
              subtitle: 'Full-stack PHP Developer',
              onTapTitle: () {},
              onTapLeading: () {},
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) => const AboutDialog());
                  },
                  icon: Icon(
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 24,
                    Icons.search,
                  ),
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  tooltip: MaterialLocalizations.of(context).showMenuTooltip,
                  highlightColor: Theme.of(context).colorScheme.primary,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) => const AboutDialog());
                  },
                  icon: badges.Badge(
                    showBadge: true,
                    badgeAnimation: const badges.BadgeAnimation.slide(),
                    position: badges.BadgePosition.topEnd(top: -6, end: -6),
                    child: Icon(
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 24,
                      Icons.notifications,
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  tooltip: MaterialLocalizations.of(context).showMenuTooltip,
                  highlightColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            PrimaryButton(
              marginHorizontal: 20,
              marginVertical: 20,
              label: 'Sign In With Google',
              onPressed: () => signInWithGoogle(),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.3,
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: JobCard(
                      header: Header(
                        title: 'Tran Van Hoai',
                        subtitle: 'Full-stack PHP Developer',
                        onTapTitle: null,
                        onTapLeading: null,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                            padding: const EdgeInsets.all(0),
                            color: Colors.black,
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              alignment: Alignment.bottomLeft,
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                        actionsSpacing: 0,
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
                      ),
                      listSkill: const ['PHP', 'Angular', 'Android'],
                      descriptionContent: 'DAY LA DESCRIPTION',
                      costContent: 'DAY LA COST',
                    ),
                  );
                },
                itemExtent: MediaQuery.of(context).size.width * 0.8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ),
            const SizedBox(height: 20),
            JobCard(
              showMore: true,
              header: Header(
                title: 'Google LLC',
                subtitle: 'The best company in the world',
                onTapTitle: null,
                onTapLeading: null,
                leadingPhotoUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png',
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    padding: const EdgeInsets.all(0),
                    color: Colors.black,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      alignment: Alignment.bottomLeft,
                    ),
                    alignment: Alignment.center,
                  ),
                ],
                actionsSpacing: 0,
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
              ),
              posterContent: 'DAY LA POSTER',
              progressContent: const [
                'Hit dat 500 cai',
                'Chay bo 100km',
                'Hoc Flutter',
              ],
              durationContent: 'DAY LA DURATION',
              costContent: 'DAY LA COST',
              showMoreDuration: const Duration(seconds: 1),
              bottomChild: const Text('Day la bottom child'),
              listSkill: const [
                'Chi an khong tap',
                'U16 ninh binh',
                'Chay xe 1 banh',
              ],
              descriptionContent: 'Day la description content',
            ),
          ],
        ),
      ),
    );
  }
}
