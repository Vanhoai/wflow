import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/button/gradient_button.dart';
import 'package:wflow/core/widgets/textfield/text_field_from.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _tabController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: const Header(text: "Đăng ký"),
            body:Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.black,
                          controller: _tabController,
                          tabs: [
                            _tabSelect(icon: AppConstants.email, title: 'Email'),
                            _tabSelect(icon: AppConstants.phone, title: 'Số điện thoại'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: TabBarView(//TabarView layout chinh
                            controller: _tabController,
                            children: const [
                              MyForm(),
                              Icon(Icons.directions_transit),
                            ],
                          ),
                        ),
                      ],
                    )
                )
            )
        )

    );
  }
}

Widget _tabSelect({String? icon, String? title}) {
  return Tab(
      child: Row(
          children: [
            SvgPicture.asset(
              icon!,
              semanticsLabel: "Logo",
            ),
            const Padding(padding: EdgeInsets.only(left: 17)),
            Text(title ?? "",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                )
            )
          ]));
}

class MyForm extends StatefulWidget{


  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormState() ;
  }

}

class _FormState extends State<MyForm>{
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: _key,
        child: Column(
          children: [
            //Email
            TextFieldFrom(
              label: 'Email',
              controller: emailController,
              placeholder: 'Nhập địa chỉ email',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 16, right: 17, left: 18),
                child: SvgPicture.asset(
                    AppConstants.email,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.srcIn)),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 16, right: 17, left: 18),
                child: SvgPicture.asset(
                    AppConstants.checkFill,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.green, BlendMode.srcIn)),
              ),
            ),
            //Pass
            TextFieldFrom(
              controller: passwordController,
              label: 'Mật khẩu',
              placeholder: 'Nhập mật khẩu',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 16, right: 17, left: 18),
                child: SvgPicture.asset(
                    AppConstants.lock,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.srcIn)),
              ),
              isPassword: true,
            ),
            TextFieldFrom(
              controller: passwordController,
              label: 'Nhập lại mật khẩu',
              placeholder: 'Nhập lại mật khẩu',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 16, right: 17, left: 18),
                child: SvgPicture.asset(
                    AppConstants.lock,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.srcIn)),
              ),
              isPassword: true,
            ),
            const SizedBox(height: 30),
            //Btn_Login
            GradientButton(
                onTap: () {},
                text: "Đăng ký"
            ),
          ],
        )
    );
    }
  }
