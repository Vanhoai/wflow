import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';

class AddBusinessCard extends StatefulWidget {
  const AddBusinessCard({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.isCheck,
    required this.onCheck,
  });

  final String image;
  final String name;
  final String email;
  final bool isCheck;
  final Function(bool?)? onCheck;

  @override
  State<AddBusinessCard> createState() => _AddBusinessCardState();
}

class _AddBusinessCardState extends State<AddBusinessCard> {
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
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 12.75,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 6.1,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width,
        backgroundImage: NetworkImage(
          widget.image,
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
            widget.name,
            style: textTheme.labelMedium,
          ),
          Text(
            widget.email,
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
          color: widget.isCheck ? AppColors.primary : const Color(0XFFD9D9D9),
        ),
        borderRadius: BorderRadius.circular(AppSize.borderSmall),
      ),
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: widget.isCheck,
          onChanged: widget.onCheck,
          checkColor: AppColors.primary,
          side: const BorderSide(
            color: Colors.transparent,
          ),
          fillColor: const MaterialStatePropertyAll(Colors.white),
        ),
      ),
    );
  }
}
