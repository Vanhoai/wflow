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
    return InkWell(
      onTap: () => {},
      child: Ink(
        padding: const EdgeInsets.only(
          left: AppSize.paddingScreenDefault,
          right: AppSize.paddingScreenDefault,
          top: AppSize.paddingMedium * 2,
          bottom: AppSize.paddingMedium * 2,
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
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 12.75,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 6.1,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width,
        backgroundImage: const NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7b2PVyKI3rMsrNGIdognv6uTxYbDWYi8wAPbBgDa_cCmGU-r8qzIvRcqZTK1sQ_OpsqA&usqp=CAU'),
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
