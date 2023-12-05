import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntroductionScreenState();
  }
}

class _IntroductionScreenState extends State<IntroScreen> {
  void _onIntroEnd(context) {
    instance.get<AppBloc>().add(SetIsFirstTime());
    Navigator.of(context).pushReplacementNamed(RouteKeys.signInScreen);
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, [double width = double.infinity]) {
    return SvgPicture.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    PageDecoration pageDecoration = PageDecoration(
        titleTextStyle: const TextStyle(
            fontSize: 28.0,
            fontFamily: 'null',
            fontWeight: FontWeight.w700,
            color: AppColors.primary),
        bodyTextStyle: bodyStyle,
        bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Theme.of(context).colorScheme.background,
        imagePadding: EdgeInsets.zero,
        bodyAlignment: Alignment.center,
        bodyFlex: 1,
        imageFlex: 3,
        titlePadding: const EdgeInsets.only(top: 0.0, bottom: 10.0));
    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Theme.of(context).colorScheme.background,
        pages: [
          PageViewModel(
            title: 'Kết nối',
            body: 'Giữa doanh nghiệp và người lao động',
            image: _buildImage(AppConstants.introductionCv),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Tìm kiếm cơ hội việc làm',
            body:
                'Với chiếc smartphone trong tay, dễ dàng đăng ký ứng tuyển công việc',
            image: _buildImage(AppConstants.introductionJob),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Dễ dàng',
            body: 'Tìm kiếm các ứng viên tiềm năng ở mỗi lĩnh vực',
            image: _buildImage(AppConstants.introductionIntern),
            decoration: pageDecoration,
          ),
          PageViewModel(
              title: 'Thanh toán dễ dàng',
              body:
                  //Sửa cái này
                  'Kí hợp đồng, nhận việc, hoàn thành hợp đồng hoàn thành lãnh lương?',
              image: _buildImage(AppConstants.introductionCash),
              decoration: pageDecoration),
          PageViewModel(
            title: 'Task',
            body: 'Quản lý tiến độ công việc dễ dàng',
            image: _buildImage(AppConstants.introductionTask),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w500)),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w500)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
        dotsContainerDecorator: ShapeDecoration(
          color: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
