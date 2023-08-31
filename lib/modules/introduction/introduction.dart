
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/modules/auth/presentation/sign_in_huy/sign_in_ui.dart';

class IntroScreen extends StatefulWidget{
  const IntroScreen({super.key});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroductionScreenState();
  }

}
class _IntroductionScreenState extends State<IntroScreen> {

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignInScreenHuy()),
    );
  }
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset(assetName, width: width);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          pages: [
            PageViewModel(
              title: "Fractional shares",
              body:
              "Instead of having to buy an entire share, invest any amount you want.",
              image: _buildImage(AppConstants.plash1),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Another title page",
              body: "Another beautiful body text for this example onboarding",
              image: _buildImage(AppConstants.plash1),
              footer: ElevatedButton(
                onPressed: () {
                  introKey.currentState?.animateScroll(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'FooButton',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 6,
                imageFlex: 6,
                safeArea: 80,
              ),
            ),
            PageViewModel(
              title: "Title of last page - reversed",
              bodyWidget: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Click on ", style: bodyStyle),
                  Icon(Icons.edit),
                  Text(" to edit a post", style: bodyStyle),
                ],
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 2,
                imageFlex: 4,
                bodyAlignment: Alignment.bottomCenter,
                imageAlignment: Alignment.topCenter,
              ),
              image: _buildImage(AppConstants.plash1),
              reverse: true,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.arrow_forward),
          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        )
    );

  }
}
