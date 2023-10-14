import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';

import 'components/index.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 10),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Đăng ký',
                        style: textTitle(
                          fontWeight: FontWeight.w400,
                          size: 24,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Theme.of(context).primaryColor,
                        controller: _tabController,
                        tabs: [
                          _tabSelect(icon: AppConstants.email, title: 'Email'),
                          _tabSelect(
                              icon: AppConstants.phone,
                              title: (MediaQuery.of(context).size.width <= 400 ? 'Phone' : 'Số điện thoại')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                          (MediaQuery.of(context).size.height <= 800 ? 400 : MediaQuery.of(context).size.height * 0.5),
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          FormRegisterEmail(),
                          FormRegisterPhone(),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 66),
                            height: 1,
                            width: double.infinity,
                            color: Colors.black26,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.white,
                            child: Text('Hoặc', style: textTitle(size: 16, fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        child: Ink(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 11),
                                    child: SvgPicture.asset(AppConstants.google),
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Đăng ký với Google',
                                  style: textTitle(size: 16, fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Bạn đã có tài khoản? ', style: textTitle(size: 16, fontWeight: FontWeight.w400)),
                          InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => {Navigator.pop(context)},
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                'Đăng nhập',
                                style: textTitle(
                                    colors: Theme.of(context).primaryColor, size: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _tabSelect({String? icon, String? title}) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon!,
          semanticsLabel: 'Logo',
        ),
        const SizedBox(width: 17),
        Text(
          title ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
        )
      ],
    ),
  );
}
