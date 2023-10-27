import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      appBar: const AppHeader(text: 'Balance'),
      isSafe: true,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 350,
              height: 230,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 154, 241, 0.46),
                    Color.fromRGBO(37, 142, 0, 0.46),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 20,
                    child: Text(
                      'WFlow',
                      style: themeData.textTheme.displayLarge!
                          .copyWith(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: SvgPicture.asset(AppConstants.ic_mastercard),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 20,
                    child: SvgPicture.asset(AppConstants.ic_balancew),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Text(
                      '92837434 VND',
                      style: themeData.textTheme.displayLarge!
                          .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 54,
                    left: 20,
                    child: Text(
                      'Trần Văn Hoài',
                      style: themeData.textTheme.displayLarge!
                          .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      '#6011000000000',
                      style: themeData.textTheme.displayLarge!
                          .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
