

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/button/button.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/core/widgets/textfield/text_field_verification.dart';

class VerificationScreen extends StatefulWidget{
  const VerificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VerificationScreenState();
  }

}

class _VerificationScreenState extends State<VerificationScreen>{
  int? count ;
  Timer? _everySecond;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Xử lý date ở đây

    count =160;

    // defines a timer
    _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if(count == 0){
          _everySecond?.cancel();
        }else{
          count = count !- 1;
        }
      });
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _everySecond?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding:  const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 80),
                  child: SvgPicture.asset(
                    AppConstants.app,
                    semanticsLabel: "Logo",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 49),
                  child: Text(
                    "Xác nhận số điện thoại",
                    style: TextTitle(
                      size: 20,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldVerification(),
                    TextFieldVerification(),
                    TextFieldVerification(),
                    TextFieldVerification(),
                    TextFieldVerification(),
                    TextFieldVerification(),
                  ]
                ),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mã xác nhận sẽ gửi lại sau",
                      style: TextTitle(
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      '${count}s',
                      style: TextTitle(
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppButton(
                        text: "Xác nhận",
                        onTap: () {},
                      ),
                    ],
                  )
                ),
                Container(
                    margin:  EdgeInsets.only(top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bạn đã có tài khoản? ",
                            style: TextTitle(
                                size: 16, fontWeight: FontWeight.w400)),
                        InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => {
                              Navigator.pop(context)
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Đăng nhập",
                                  style: TextTitle(
                                      colors: AppColors.primary,
                                      size: 16,
                                      fontWeight: FontWeight.w500),
                                )
                            )),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

}