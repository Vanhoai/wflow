import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';

class AddBusinessCard extends StatefulWidget {
  const AddBusinessCard({super.key});

  @override
  State<AddBusinessCard> createState() => _AddBusinessCardState();
}

class _AddBusinessCardState extends State<AddBusinessCard> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.marginMedium),
      child: InkWell(
        onTap: () => {},
        child: Ink(
          padding: const EdgeInsets.only(
            left: AppSize.paddingScreenDefault,
            right: AppSize.paddingScreenDefault,
            top: AppSize.paddingMedium,
            bottom: AppSize.paddingMedium,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAvatar(),
              _buildContent(),
              SizedBox(
                width: ((MediaQuery.sizeOf(context).width) / 100) * 8.16,
              ),
              _buildCheckbox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.sizeOf(context).width),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SizedBox(
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tim Denmisons',
            style: textTheme.labelMedium,
          ),
          Text(
            'timden22068@fpt.edu.vn',
            style: textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return Container(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 7.14,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 3.41,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: ((MediaQuery.sizeOf(context).width) / 100) * 0.51,
          style: BorderStyle.solid,
          color: isCheck ? AppColors.primary : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(AppSize.borderSmall),
      ),
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: isCheck,
          onChanged: (value) => setState(() {
            isCheck = value!;
          }),
          checkColor: AppColors.primary,
          side: const BorderSide(
            color: Colors.transparent,
          ),
          fillColor: MaterialStatePropertyAll(
              isCheck ? Colors.white : const Color(0XFFD9D9D9)),
        ),
      ),
    );
  }
}
